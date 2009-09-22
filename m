From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [APPLIED] [PATCH] omapfb: Reorder Register_framebuffer call
Date: Tue, 22 Sep 2009 12:19:21 -0500
Message-ID: <A24693684029E5489D1D202277BE89444B781B50@dlee02.ent.ti.com>
References: <1252773249-24444-1-git-send-email-saaguirre@ti.com>
 <notify-1253583118@atomide.com>
 <4de7f8a60909220759g63b592eek85a2bca04b264d2e@mail.gmail.com>
 <20090922162853.GC14890@atomide.com>,<4AB907A8.8040805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51725 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753755AbZIVRWm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 13:22:42 -0400
In-Reply-To: <4AB907A8.8040805@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Angelo Arrifano <miknix@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Alistair Buxton <a.j.buxton@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] On Behalf Of Angelo Arrifano [miknix@gmail.com]
Sent: Tuesday, September 22, 2009 12:21 PM
> To: Tony Lindgren
> Cc: Alistair Buxton; linux-omap@vger.kernel.org
> Subject: Re: [APPLIED] [PATCH] omapfb: Reorder Register_framebuffer call
> 
> Tony Lindgren wrote:
> > * Jan Blunck <jblunck@infradead.org> [090922 07:59]:
> >> On Tue, Sep 22, 2009 at 3:31 AM, Tony Lindgren <tony@atomide.com> wrote:
> >>> This patch has been applied to the linux-omap
> >>> by youw fwiendly patch wobot.
> >>>
> >>> Branch in linux-omap: omap-fixes
> >>>
> >>> Initial commit ID (Likely to change): 9aef1066fb5ca8506068eaab1c552ecca4c85475
> >>>
> >>> PatchWorks
> >>> http://patchwork.kernel.org/patch/47089/
> >>>
> >
> > Added back the original Cc's that were dropped from the linux-omap
> > commit message.
> >
> >> Is it actually safe to do this? The framebuffer can be used directly
> >> after it is registered. In this case it would mean it is used before
> >> it is even fully initialized (set_fb_var(), set_fb_fix(), ... are
> >> being called).
> >
> > Good point, dropping the patch.
> >
> > Also, let's let Tomi Valkeinen deal with queueing up the omap fb code.
> > I can then merge Tomi's branck into linux-omap master branch as needed.
> >
> > Regards,
> >
> > Tony
> 
> Hello,
> 
> This patch doesn't work for us at linwizard project (omap850). The
> commit 537a1bf059fa312355696fa6db80726e655e7f17 makes the HTC Wizard
> crash at boot due to usage of uninitialized mutex. Applying the referred
> patch prevents the crash but the LCD screen goes black and doesn't show
> any data.

Angelo,


Some people gave his ACK, because it was booting. and also i kept it since some framebuffer tests in my 3430SDP passed (i.e. it was showing the intended data.)

However, didn't show the Tux during bootup. Isn't the same case as you?

Anyways, Thanks for sharing your results... I'll rework this patch and resend once i'm done.

Regards,
Sergio
> 
> - Angelo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
