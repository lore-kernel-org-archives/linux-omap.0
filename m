From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Fri, 21 Dec 2012 11:19:16 +0100
Message-ID: <CAAwP0s3GmAu8ij37y=5XCs246pWXWfLechaHLZf84+gaPXtwNw@mail.gmail.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com>
 <CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com> <8865776.jqeL1Eqbut@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:51648 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab2LUKZJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Dec 2012 05:25:09 -0500
Received: by mail-ob0-f182.google.com with SMTP id 16so4313906obc.41
        for <linux-omap@vger.kernel.org>; Fri, 21 Dec 2012 02:25:08 -0800 (PST)
In-Reply-To: <8865776.jqeL1Eqbut@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Steve Sakoman <sakoman@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>

On Fri, Dec 21, 2012 at 9:30 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Steve,
>
> On Wednesday 21 November 2012 16:08:06 Steve Sakoman wrote:
>> On Thu, Oct 11, 2012 at 8:58 AM, Enric Balletbo Serra
>>
>> <eballetbo@gmail.com> wrote:
>> > I see that commit dac8eb5f (OMAPDSS: TFP410: rename dvi files to
>> > tfp410) and commit 2e6f2ee7 (OMAPDSS: TFP410: rename dvi -> tfp410)
>> > changes the panel driver used on some boards. I tested current
>> > linux-next-20101011 kernel with my IGEPv2 board and DSS fails with
>> >
>> > following error (see http://pastebin.com/VjPGCQDt for full log) :
>> >    [ 21.222808] omapdss OVERLAY error: check_overlay: paddr cannot be 0
>> >    [ 21.229583] omapdss OVERLAY error: check_overlay: paddr cannot be 0
>> >    [ 21.236236] omapfb omapfb: setup_plane failed
>>
>> Was there ever any resolution to this issue?
>
> Does mainline commit 950e2fb420d54bf0ee0de2fb0f146827a98330bf help ?
>

Hi Laurent,

I just tried today's mainline kernel which has:

950e2fb [media] omap_vout: use omapdss's version instead of cpu_is_*

but I still see the log message "omapdss OVERLAY error: check_overlay:
paddr cannot be 0" (full log: http://fpaste.org/jOBo/)

This doesn't affect the video display though since the framebuffer
video is working correctly.

Setting CONFIG_FB_OMAP2_NUM_FBS=1 in my .config makes the error
message disappear since the paddr is correctly
set for the first overlay:

[    3.175842] OMAPFB: allocated VRAM paddr 9e900000, vaddr de900000
[    3.182891] OMAPFB: paddr 9e900000

Best regards,
Javier
