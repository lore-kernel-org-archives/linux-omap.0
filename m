From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
Date: Wed, 24 Nov 2010 10:57:37 +0200
Message-ID: <1290589057.13243.22.camel@tubuntu>
References: <19F8576C6E063C45BE387C64729E739404BC762E9A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:56800 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142Ab0KXJcg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 04:32:36 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739404BC762E9A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2010-11-23 at 23:46 +0530, ext Hiremath, Vaibhav wrote:
> Hi,
> 
> While supporting one of customer I came across one interesting issue and finding with WAITFORVSYNC ioctl - 
> 
> Problem Statement - 
> -------------------
> With WAITFORVSYNC lots of tearing artifacts are visible on LCD output, but WAITFORGO works fine without any issues.
> 
> Debugging/Findings - 
> --------------------
> 
> Technically both, WAITFORVSYNC and WAITFORGO wait on VSYNC interrupt - but there is slight difference in their implementation/processing. 

No, that's not quite right.

WAITFORVSYNC waits for the next vsync.

WAITFORGO waits until the the config changes for the particular overlay
have been applied to the HW, which may take multiple vsyncs if there are
already pending config changes. Or, if there are no changes to be
applied, it doesn't wait at all.

> WAITFORGO ioctl ensures that dirty & shadow_dirty flags (software flag) are cleared, making sure that hardware state and software state always stays in sync. It makes 4 attempts to do so - inside loop it checks for dirty flags and call wait_for_vsync API. In ideal usecase scenario it should come out in single iteration. 
> 
> On the other hand WAITFORVSYNC is unconditional wait on VSYNC interrupt. The processing continues with an assumption that HW and SW states are in sync.
> 
> Since WAITFORGO ioctl seems to be working in all conditions I started debugging with it and I observed that dirty and shadow_dirty flags are getting cleared on 2nd attempt in some cases. This forced me to think about the window between VFP start and VSYNC.
> 
> 
> Root-cause (How the behavior impact software)-
> ----------------------------------------------
> 
> The DSS registers are shadow registers, meaning: after updating the HW registers software must write 1 to GO_LCD bit to indicate that we are finished with register update and HW can now read it on next VFP start (not the vsync). This is the way software and hardware handshaking is done.
> 
> In Linux Display driver, we have 2 flags, dirty and shadow_dirty, first one indicates software bookkeeping registers are updated and later indicates that shadow registers are written but DSS HW has not yet read it (which happens on VFP start).
> 
> Now, if the PAN ioctl is called in the above mentioned window then DSS hardware is not going to read the shadow register (setting dirty flags), DMA will still happen on old buffer. Then immediately after PAN ioctl we are calling WAITFORVSYNC ioctl, which is unconditional wait for VSYNC interrupt and then application moves on writing to another buffer (which is now same as where DMA is happening). So here we are breaking and going out-of-sync to handle our ping-pong mechanism in application. As soon as the flow breaks, we see the artefacts on screen.
> 
> I have created Public Wiki page explaining above issue with more details and pictorial diagrams, you can refer it under http://processors.wiki.ti.com/index.php/OMAP35x_Linux_-_DSS_FAQ
> 
> 
> Suggestions/Recommendation - 
> --------------------------
> 
> From User application point of view, user won't care about driver internal implementation. Application believes that WAITFORVSYNC will only return after displaying (DMAing) previous buffer and now with addition to FBIO_WAITFORVSYNC standard ioctl interface this is very well expected from user application as a standard behavior.
> 
> I would recommend having WAITFORGO like implementation under WAITFORVSYNC, merging WAITFORGO with WAITFORVSYNC, and killing WAITFORGO (since we have FBIO_WAITFORVSYNC standard ioctl). 
> Also WAITFORGO ioctl is OMAP specific custom ioctl.  

I have to say that I'm not quite sure what WAITFORVSYNC should do. The
name implies that it should wait for the next vsync, which is what it
does for omapfb.

Changing it to WAITFORGO would alter the behaviour. Sometimes it would
not wait at all, sometimes it could wait for multiple vsyncs.

But I see the problem. Perhaps we should have a WAITFORVSYNC which would
wait until the changes are applied, or the next VSYNC if there are no
changes. That doesn't quite sound like what WAITFORVSYNC name implies,
but it would perhaps be more right (from users point of view) than the
current implementation.

 Tomi


