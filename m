From: Joel A Fernandes <agnel.joel@gmail.com>
Subject: Re: MMC breakage on 3.11/cleanup
Date: Tue, 25 Jun 2013 08:56:43 -0500
Message-ID: <CAD=GYpa1MHDiep-q5Egb4x5RjbdBNtCu64cRuC5gq0BJye=asw@mail.gmail.com>
References: <CAD=GYpZGdLem1igUsLq7DzMu-Z=9d6apS-aT=MJ59_-ytZan7w@mail.gmail.com>
	<20130625064944.GX5523@atomide.com>
	<20130625104011.GH15407@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:57867 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab3FYN4o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jun 2013 09:56:44 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so13279642oag.20
        for <linux-omap@vger.kernel.org>; Tue, 25 Jun 2013 06:56:43 -0700 (PDT)
In-Reply-To: <20130625104011.GH15407@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>

On Tue, Jun 25, 2013 at 5:40 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Mon, Jun 24, 2013 at 11:49:44PM -0700, Tony Lindgren wrote:
>> * Joel A Fernandes <agnel.joel@gmail.com> [130624 15:33]:
>> > Hi Tony,
>> >
>> > Following branch breaks MMC for me on am33xx (beaglebone):
>> > http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v3.11/cleanup
>> >
>> > I tried to work around it by specifying interrupt and reg property in DT:
>> >       mmc1: mmc@48060000 {
>> >          compatible = "ti,omap3-hsmmc";
>> >          ti,hwmods = "mmc1";
>> >          ti,dual-volt;
>> >          ti,needs-special-reset;
>> >          dmas = <&edma 24
>> >             &edma 25>;
>> >          dma-names = "tx", "rx";
>> >          interrupts = <64>;
>> >          interrupt-parent = <&intc>;
>> >          reg = <0x48060000 0x1000>;
>> >          status = "disabled";
>> >       };
>> >
>> > The probe succeeds but I still get a "Waiting for root device
>> > /dev/mmcblk0p2" when booting over MMC.
>> >
>> > If you're planning to push the cleanup branch, can we temporarily add
>> > the hwmod data back while we work on this issue so that upstream MMC
>> > is kept working.
>>
>> Yes the cleanup branch is queued up. Can you please send a patch
>> reverting the MMC parts of the hwmod change for am33xx for now,
>> then try to find the real cause for the breakage?
>
> I had mentioned that Joel should *not* depend on hwmod data and if
> adding interrupts to DTS caused issues, that issue should be resolved.
>
> http://marc.info/?l=linux-omap&m=137124891908957&w=2

Ofcourse, that is what we are talking about too. hwmod data is being
added only as a temporary fix to keep upstream working while we work
on a resolution.

Maybe you missed the "add the hwmod data back while we work on this
issue so that upstream MMC is kept working." in my post?

Please read,
  http://www.mail-archive.com/linux-omap@vger.kernel.org/msg91130.html


Thanks,

-Joel
