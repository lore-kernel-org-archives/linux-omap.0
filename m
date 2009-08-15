From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: [PATCH 8/9] OMAP2: add board file for Nokia N800 and N810
Date: Sat, 15 Aug 2009 09:28:17 +0300
Message-ID: <da94abde0908142328y5b7701cm711b6d9727463a1f@mail.gmail.com>
References: <20090811094348.32577.81307.stgit@localhost>
	 <20090811095558.32577.26177.stgit@localhost>
	 <20090813091510.GK6132@n2100.arm.linux.org.uk>
	 <87vdkrhr2q.fsf@litku.valot.fi> <20090814110850.GU7278@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:47535 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbZHOG2R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 02:28:17 -0400
Received: by ewy10 with SMTP id 10so1949931ewy.37
        for <linux-omap@vger.kernel.org>; Fri, 14 Aug 2009 23:28:17 -0700 (PDT)
In-Reply-To: <20090814110850.GU7278@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, Aug 14, 2009 at 2:08 PM, Tony Lindgren<tony@atomide.com> wrote:
>> >> +static struct musb_hdrc_platform_data tusb_data =3D {
>> >> + =A0.mode =A0 =A0 =A0 =A0 =A0 =3D BOARD_MODE,
>> >> + =A0.set_power =A0 =A0 =A0=3D tusb_set_power,
>> >> + =A0.set_clock =A0 =A0 =A0=3D tusb_set_clock,
>> >> + =A0.min_power =A0 =A0 =A0=3D 25, =A0 /* x2 =3D 50 mA drawn from=
 VBUS as peripheral */
>> >> + =A0.power =A0 =A0 =A0 =A0 =A0=3D 100, =A0/* Max 100 mA VBUS for=
 host mode */
>> >> + =A0.clock =A0 =A0 =A0 =A0 =A0=3D "osc_ck",
>> >
>> > Still passing clock names around?
>>
>> Sorry, I'm not familiar with this. How should I fix it?
>
> This should be fixed with the clkdev alias, see omap24xx_clks[].
>
> But we need to check how the fix affects other platforms for
> drivers/usb/musb/musb_core.c and send the patch via linux-usb.
>
> Maybe take a quick look, and if it looks like a bigger change,
> then leave out the tusb_data for now and let's do it in a separate
> patch?

Thanks, I'll take a look.

>> Tony, do you want me to send v2?
>
> Sure, it's best that you update it.

I'll send v2 later today.

Kalle
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
