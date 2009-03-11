From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Suspend/Resume support with Omap2fb
Date: Wed, 11 Mar 2009 23:38:57 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940427C51B5B@dbde02.ent.ti.com>
References: <1236775798.12797.33.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56478 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbZCKSJQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 14:09:16 -0400
In-Reply-To: <1236775798.12797.33.camel@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Wednesday, March 11, 2009 6:20 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: RE: Suspend/Resume support with Omap2fb
> 
> On Wed, 2009-03-11 at 11:47 +0100, ext Hiremath, Vaibhav wrote:
> 
> > > >
> > > > How have you tested this?
> > > > Have you also tested with "echo mem > /sys/power/state"?
> > > > Are you using Kevin's power management tree? What is default
> > > configuration of your kernel during this test?
> > >
> > > It's been some time since I tested it, but it did work on OMAP3
> SDP
> > > with
> > > the pm-branch. Only changed needed were the
> > > get_last_off_on_transaction_id and omapfb -> omapdss. I also
> tested
> > > echo
> > > mem > ....
> > >
> > > I'll try to find time to test it again with latest trees.
> > >
> > [Hiremath, Vaibhav] That would be great, I am also trying few
> things here at my end. Hopefully I will get something.
> 
> Yeah, it works ok for me. I rebased my DSS2 tree to latest l-o, then
> merged pm-branch, and made the changes mentioned above. I get some
> warnings from getnstimeofday when resuming the kernel, but they seem
> to
> be unrelated to DSS, and the image is fine after resume. I used my
> dss_omap_3430sdp_defconfig and made the following commands to enable
> PM:
> 
> echo 1 > /sys/power/clocks_off_while_idle
> echo 1 > /sys/power/enable_off_mode
> echo 1 > /sys/power/voltage_off_while_idle
> echo 1 > /sys/power/sleep_while_idle
> 
[Hiremath, Vaibhav] Tomi, I looked into your latest code base, and I can see that you have added suspend and resume functionality and as you mentioned it is working for you.

The only difference I could point out here is, I am handling suspend at driver level (fb and v4l2) and you are handling it at DSS2 level. I can give try to your implementation; tomorrow morning after reaching to office first thing I will try this and let you know.

Just to share with wider audience, I am seeing some abrupt behavior and I doubt some timing synchronization is causing problem. I could see suspend is working if I comment "ovl->enable" or if I call "echo "gfx e:0 > /sys/devices/platform/omapfb/overlays". Although I have same implementation in omapfb_suspend and it does disables clock and overlay, system doesn't go to off state. It always gives error for dss_prwm.

Tomi,
Can you try enabling CONFIG_CPU_IDLE flag and see whether it is going to state5 or not? 

And I think it won't go due to obvious reasons, framebuffer will hold the clocks. You have to have something in your framebuffer driver to trigger display disable. I have implemented timer here to do that.

I will send you the patch once I get rid of this issue.

>  Tomi
> 
> 

