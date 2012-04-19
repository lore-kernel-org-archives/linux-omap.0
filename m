From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: AM3517 boot failure
Date: Thu, 19 Apr 2012 20:43:28 +0100
Message-ID: <yw1xd373qzhb.fsf@unicorn.mansr.com>
References: <alpine.DEB.2.00.1204182005260.29048@utopia.booyaka.com>
	<4F8FC572.80406@compulab.co.il> <yw1x8vhrsqyd.fsf@unicorn.mansr.com>
	<20120419180513.GA14705@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([78.86.181.103]:41076 "EHLO
	unicorn.mansr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab2DSTnb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 15:43:31 -0400
In-Reply-To: <20120419180513.GA14705@animalcreek.com> (Mark A. Greer's message
	of "Thu, 19 Apr 2012 11:05:13 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

"Mark A. Greer" <mgreer@animalcreek.com> writes:

> On Thu, Apr 19, 2012 at 04:04:42PM +0100, M=E5ns Rullg=E5rd wrote:
>> Igor Grinberg <grinberg@compulab.co.il> writes:
>>=20
>> > On 04/19/12 05:07, Paul Walmsley wrote:
>> >>=20
>> >> Hi,
>> >>=20
>> >> just wanted to mention this on the list to see if anyone else was=
 seeing=20
>> >> it.  I'm using a Compulab CM-T3517 and attempting to use nfsroot,=
 and the=20
>> >> boot hangs.  Here are the last few lines when booting with=20
>> >> initcall_debug:
>
>> I did a little digging...
>
>> Secondly, the clock configuration for davinci_emac on am35xx is brok=
en.
>> omap3xxx_clk_init() registers two clocks for dev_id "davinci_emac", =
one
>> with con_id "emac_clk", one with "phy_clk".  When davinci_emac_probe=
()
>> then does a clk_get(dev, NULL), this fails since there is no matchin=
g
>> con_id.  Likewise for davinci_mdio_probe().
>
> This is fixed by 59269b94483eabeacbc9a535944b3dafac92a303
> (ARM: OMAP AM3517/3505: clock data: change EMAC clocks aliases) from
> Ilya Yanok <yanok@emcraft.com>.  Its in the current mainline kernel.

Yeah, I noticed after I'd already figured out why it was failing.  Oh
well, it was a good exercise.

>> With a little hacking, I got the platform device registered and the
>> clocks matching as (I think) they should.  It now detects the correc=
t
>> PHY, so that's something.
>>=20
>> However, the IP config is still getting stuck.  For reasons I don't
>> know, the msleep(1) call in ic_open_devs() never returns.
>>=20
>> That's as far as I got.
>
> I tried the current mainline on my am3517 evm and it hangs as well.
> I'm not surprised, the am35xx has some serious issues ATM.  I submitt=
ed
> a set of patches to fix a lot of them but they need to be reworked.
> I'm working on that now.
>
> Until then, don't expect much to work well.  If it does seem to work =
well,
> you got lucky.  If you want to get running quickly, try the ***HACK**=
*
> below.  Current mainline boot with it applied, CONFIG_TI_DAVINCI_EMAC=
=3Dy,
> boots on my am3517 evm with both an MMC-mounted & NFS-mounted rootfs.
>
> Mark
> --
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 703bd10..187f5cb 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -705,7 +705,6 @@ static int __init omap3_pm_init(void)
>         struct clockdomain *neon_clkdm, *per_clkdm, *mpu_clkdm, *core=
_clkdm;
>         int ret;
>
> -       if (!cpu_is_omap34xx())
>                 return -ENODEV;
>
>         if (!omap3_has_io_chain_ctrl())

That does indeed make it boot.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
