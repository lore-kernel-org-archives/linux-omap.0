From: Tony Lindgren <tony@atomide.com>
Subject: Re: AM3517 boot failure
Date: Thu, 19 Apr 2012 09:53:13 -0700
Message-ID: <20120419165312.GW21106@atomide.com>
References: <alpine.DEB.2.00.1204182005260.29048@utopia.booyaka.com>
 <4F8FC572.80406@compulab.co.il>
 <yw1x8vhrsqyd.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17341 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755398Ab2DSQxU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 12:53:20 -0400
Content-Disposition: inline
In-Reply-To: <yw1x8vhrsqyd.fsf@unicorn.mansr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

* M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com> [120419 08:31]:
> Igor Grinberg <grinberg@compulab.co.il> writes:
>=20
> > On 04/19/12 05:07, Paul Walmsley wrote:
> >>=20
> >> Hi,
> >>=20
> >> just wanted to mention this on the list to see if anyone else was =
seeing=20
> >> it.  I'm using a Compulab CM-T3517 and attempting to use nfsroot, =
and the=20
> >> boot hangs.  Here are the last few lines when booting with=20
> >> initcall_debug:
> >>=20
> >> [    7.069885] initcall scsi_complete_async_scans+0x0/0x10c return=
ed 0 after 29 usecs
> >> [    7.077880] calling  gpio_keys_init+0x0/0xc @ 1
> >> [    7.084167] initcall gpio_keys_init+0x0/0xc returned 0 after 14=
00 usecs
> >> [    7.091278] calling  rtc_hctosys+0x0/0x110 @ 1
> >> [    7.096038] /home/paul/linux/drivers/rtc/hctosys.c: unable to o=
pen rtc device (rtc0)
> >> [    7.104217] initcall rtc_hctosys+0x0/0x110 returned -19 after 7=
987 usecs
> >> [    7.111297] calling  net_secret_init+0x0/0x1c @ 1
> >> [    7.116333] initcall net_secret_init+0x0/0x1c returned 0 after =
119 usecs
> >> [    7.123443] calling  tcp_congestion_default+0x0/0xc @ 1
> >> [    7.128997] initcall tcp_congestion_default+0x0/0xc returned 0 =
after 0 usecs
> >> [    7.136444] calling  ip_auto_config+0x0/0xf70 @ 1
> >>=20
> >> Is anyone else seeing this?
> >
> > I've tried various configurations and can confirm this hang.
> > I still haven't got my hands on bisecting this.
> > There is nothing special about CM-T3517,
> > IMO this can be seen on any AM35xx based board with EMAC, or am I m=
istaken?
> > Anyway, can anybody try nfsroot on other AM35xx based board with EM=
AC
> > supported?
>=20
> I did a little digging...
>=20
> Firstly, only the am3571evm board registers the davinci_emac platform
> device.  On a Craneboard or a CM-T3517 there will simply be no networ=
k
> device for IP autoconfig to use (unless you magically have DT working=
).
>=20
> Secondly, the clock configuration for davinci_emac on am35xx is broke=
n.
> omap3xxx_clk_init() registers two clocks for dev_id "davinci_emac", o=
ne
> with con_id "emac_clk", one with "phy_clk".  When davinci_emac_probe(=
)
> then does a clk_get(dev, NULL), this fails since there is no matching
> con_id.  Likewise for davinci_mdio_probe().
>=20
> With a little hacking, I got the platform device registered and the
> clocks matching as (I think) they should.  It now detects the correct
> PHY, so that's something.
>=20
> However, the IP config is still getting stuck.  For reasons I don't
> know, the msleep(1) call in ic_open_devs() never returns.
>=20
> That's as far as I got.

Just to check, is this with the bad muxing removed in fixes branch? Wit=
hout
that there can be all kinds of weird issues if some uart pins are used =
for
non-uart functionality:

bce492c0 (ARM: OMAP2+: UART: Fix incorrect population of default uart p=
ads)?

Regards,

Tony


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
