From: Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH v2 3/3] omap: gpmc-nand: add ability to keep timings
	defined by the bootloader
Date: Mon, 3 May 2010 23:32:50 +0300
Message-ID: <z2mf870da181005031332w8b8fd1d9vc19af82b4b3fccbe@mail.gmail.com>
References: <cover.1272530653.git.mike@compulab.co.il>
	 <f20c8d0dc1c81a0cc5a334d03c9c7dc73046293d.1272530653.git.mike@compulab.co.il>
	 <20100503182426.GX29604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:64264 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756768Ab0ECUcv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 16:32:51 -0400
Received: by gxk9 with SMTP id 9so1748665gxk.8
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 13:32:50 -0700 (PDT)
In-Reply-To: <20100503182426.GX29604@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, vimal.newwork@gmail.com, s-ghorai@ti.com

On Mon, May 3, 2010 at 9:24 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Mike Rapoport <mike@compulab.co.il> [100429 01:44]:
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>
> Please add a proper description to all the patches.
>
>> --- a/arch/arm/mach-omap2/gpmc-nand.c
>> +++ b/arch/arm/mach-omap2/gpmc-nand.c
>> @@ -116,6 +124,11 @@ int __init gpmc_nand_init(struct omap_nand_plat=
form_data *_nand_data)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (gpmc_nand_data->keep_timings) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpmc_cs_get_timings(gpmc_nand_data->cs, &g=
pmc_default_timings);
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpmc_nand_data->gpmc_t =3D &gpmc_default_t=
imings;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 err =3D gpmc_nand_setup();
>> =A0 =A0 =A0 if (err < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "NAND platform setup failed=
: %d\n", err);
>
> Hmm, so you're setting the timings based on the bootloader values?
>
> I' think the problem with that is that chances are that it still won'=
t
> work for other L3 frequencies because of rounding errors.
>
> With gpmc_cs_get_timings() you're already using tick rounded timings,
> so you won't get the required accuracy out of those for the other
> L3 frequencies.

Agree. But even if the timings are in nanoseconds there are rounding
errors, and there are still chances that L3 frequency change will
break NAND
So it comes down to what provides better tolerance, the explicit NAND
timings in nanosecs or (rounded) timings in ticks derived from
bootloader settings...

> So maybe just not do anything, and print a warning on gpmc L3 changes
> if the timings are not set?

I don't quite understand where exactly this warning should go. I
haven't found any treatment of L3 frequency changes in gpmc related
code neither in linux-omap nor in linux-omap-pm...

> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
	Sincerely Yours,
		Mike.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
