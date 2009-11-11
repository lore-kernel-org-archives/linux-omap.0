From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 2/3]NAND: OMAP: Fixing omap nand driver, compiled as
	module
Date: Wed, 11 Nov 2009 10:16:25 +0530
Message-ID: <ce9ab5790911102046w389b0b11l367876fdb49e5dca@mail.gmail.com>
References: <ce9ab5790910292321y1e7239b7pbffe9a5891d66448@mail.gmail.com>
	<ce9ab5790910300142kf12e31cpd6249d4c7383553f@mail.gmail.com>
	<ce9ab5790910300227r41d42673webad0ee48e3444d1@mail.gmail.com>
	<1257862989.21596.763.camel@localhost> <20091110185621.GB23952@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:52884 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756455AbZKKEqk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 23:46:40 -0500
Received: by fxm21 with SMTP id 21so702373fxm.21
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2009 20:46:45 -0800 (PST)
In-Reply-To: <20091110185621.GB23952@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, Linux MTD <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org

On Wed, Nov 11, 2009 at 12:26 AM, Tony Lindgren <tony@atomide.com> wrot=
e:
> * Artem Bityutskiy <dedekind1@gmail.com> [091110 06:22]:
>> On Fri, 2009-10-30 at 14:57 +0530, Vimal Singh wrote:
>> > Last time I forgot to 'git add' for 'arch/arm/mach-omap2/gpmc.c'..=
=2E My bad.
>> > Correct patch is below.
>> >
>> > -vimal
>> >
>> >
>> > From: Vimal Singh <vimalsingh@ti.com>
>> > Date: Fri, 30 Oct 2009 14:54:29 +0530
>> > Subject: [PATCH] NAND: OMAP: Fixing omap nand driver, compiled as =
module
>> >
>> > Removing OMAP NAND driver, when loaded as a module, gives error an=
d
>> > does not get success. This fixes this and makes driver loadable an=
d
>> > removable run time.
>> >
>> > Signed-off-by: Vimal Singh <vimalsingh@ti.com>
>> > ---
>> > =A0arch/arm/mach-omap2/gpmc.c | =A0 =A02 ++
>> > =A0drivers/mtd/nand/omap2.c =A0 | =A0 =A05 ++++-
>> > =A02 files changed, 6 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc=
=2Ec
>> > index 1587682..1d10b7b 100644
>> > --- a/arch/arm/mach-omap2/gpmc.c
>> > +++ b/arch/arm/mach-omap2/gpmc.c
>> > @@ -88,6 +88,7 @@ void gpmc_cs_write_reg(int cs, int idx, u32 val)
>> > =A0 =A0 reg_addr =3D gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + =
idx;
>> > =A0 =A0 __raw_writel(val, reg_addr);
>> > =A0}
>> > +EXPORT_SYMBOL(gpmc_cs_write_reg);
>> >
>> > =A0u32 gpmc_cs_read_reg(int cs, int idx)
>> > =A0{
>> > @@ -96,6 +97,7 @@ u32 gpmc_cs_read_reg(int cs, int idx)
>> > =A0 =A0 reg_addr =3D gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + =
idx;
>> > =A0 =A0 return __raw_readl(reg_addr);
>> > =A0}
>> > +EXPORT_SYMBOL(gpmc_cs_read_reg);
>>
>> You should get Tony's ack for this. I do not know the code, but on
>> surface it looks strange. Exporting so low-level functions is bad in
>> general, IMO. These function should either be inlined, or you should
>> invent better abstraction, so that you would not need to ever call t=
hese
>> functions from omap2.c.
>
> NAK. We don't want the drivers to tinker with these registers
> directly. And really, the drivers should be platform independent.
>
> This seems like a quick hack to add back the missing functionality
> we threw out of the linux-omap tree. It was thrown out because there
> were the same cut and paste hacks duplicated all over the place
> tinkering with the GPMC registers directly.
>
> We've fixed a lot of this by creating gpmc-onenand.c and gpmc-smc91x.=
c,
> and that's clearly the way to go.
>
> So instead of trying to add back the same old hacks, how about rather
> spend that time to create something that we can use for all boards
> using GPMC?
>
> To me it looks like platform init like this should be done in a
> generic way in arch/arm/mach-omap2/gpmc-nand.c the same way we have
> gpmc-onenand.c and gpmc-smc91x.c.
>
> Also, you should calculate the GPMC timings dynamically as they
> can change based on the L3 frequency. Just take a look at the
> gpmc-onenand.c and gpmc-smc91x.c.

Ok, I'll look into these and will try to do something generic.

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
