From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [beagleboard] Re: TWL4030 intermittent freakout on boot
Date: Fri, 9 May 2008 16:11:36 -0700
Message-ID: <5e088bd90805091611q4a8a22d0l3dab427fe644a990@mail.gmail.com>
References: <alpine.DEB.1.00.0805081201450.27986@utopia.booyaka.com>
	 <EF9B9E21-ACCB-46A7-94C7-1FB6DD58B093@student.utwente.nl>
	 <20080508182807.GE24454@atomide.com> <48249322.4060004@googlemail.com>
	 <20080509213608.GA5976@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:24767 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086AbYEIXLi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2008 19:11:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so976966fgg.17
        for <linux-omap@vger.kernel.org>; Fri, 09 May 2008 16:11:36 -0700 (PDT)
In-Reply-To: <20080509213608.GA5976@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dirk Behme <dirk.behme@googlemail.com>, beagleboard@googlegroups.com, Koen Kooi <k.kooi@student.utwente.nl>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, felipe.balbi@nokia.com, peter.de-schrijver@nokia.com

FWIW, I've never had any issues with the twl4030 on my OMAP3 EVM.
Both it and the MMC come up fine every boot.

I'm sure that by saying that I have jinxed myself and will have no end
of issues from this point forward :-)

It's not obvious from looking at the board files why this might be.
Perhaps the order of inits?

Steve

On Fri, May 9, 2008 at 2:36 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Dirk Behme <dirk.behme@googlemail.com> [080509 11:08]:
>
>
> > Tony Lindgren wrote:
>  >> * Koen Kooi <k.kooi@student.utwente.nl> [080508 11:22]:
>  >>
>  >>> Op 8 mei 2008, om 20:13 heeft Paul Walmsley het volgende geschreven:
>  >>>
>  >>>> Hello everyone,
>  >>>>
>  >>>> occasionally the TWL4030 driver on the 3430SDP freaks out on boot.
>  >>>>  (This
>  >>>> is either an ES2.0 or ES2.1, not sure.)  Here's a partial console
>  >>>> log with
>  >>>> initcall debugging enabled.  This probably happens every thirty or
>  >>>> forty
>  >>>> boots, I would guess.  The board does boot to userspace when this
>  >>>> happens.
>  >>>>
>  >>>> Perhaps the TWL4030 experts out there might know what's going on?
>  >>>>
>  >>>> <3>i2c_omap i2c_omap.1: controller timed out
>  >>>> <3>i2c_omap i2c_omap.1: controller timed out
>  >>>> <3>twl4030_usb: i2c write failed, line 422
>  >>>
>  >>> Looks suspiciously like the symptons in
>  >>>
>  >>> http://code.google.com/p/beagleboard/issues/detail?id=14
>  >>
>  >>
>  >> This also looks similar to the earlier twl4030 hangs where access
>  >> to some domains caused twl4030 to hang. If twl4030 hangs, there's
>  >> no way to reset it as all control is over I2C. When twl4030 hangs,
>  >> bootloader won't be able to detect the chip either unless devices
>  >> is power cycled (and USB cable detached).
>  >>
>  >> The reason earlier was that twl4030 internal clock was not being
>  >> programmed properly, and was fixed by patch
>  >> 0d81cf7e804c529c58d3054c1b9bdb7b3f1dec5d.
>  >
>  > Link for this is
>  >
>  > http://source.mvista.com/git/?p=linux-omap-2.6.git;a=commitdiff;h=0d81cf7e804c529c58d3054c1b9bdb7b3f1dec5d
>  >
>  > I don't know OMAP3 good enough yet, but which clock should we use on
>  > OMAP3 here?
>
>  It should be osc_sys_ck for 34xx.
>
>
>  > Does it make sense to use osc_ck for OMAP3 instead of osc_sys_ck, too?
>  >
>  > E.g something like
>  >
>  > ...
>  > if (cpu_is_omap2430() || cpu_is_omap34xx())
>  >   osc = clk_get(NULL, "osc_ck");
>  > else
>  >   osc = clk_get(NULL, "osc_sys_ck");
>  > ...
>
>  There's no osc_ck in clock34xx.h.
>
>  But what I'm thinking is that maybe the MMC driver does twl4030 calls
>  before the twl4030 clock is programmed to the right value?
>
>  Tony
>
>
> --
>  To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
