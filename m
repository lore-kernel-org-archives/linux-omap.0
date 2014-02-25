From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: TWL6040 fails to initialize
Date: Tue, 25 Feb 2014 16:29:46 +0200
Message-ID: <530CA8DA.8050806@ti.com>
References: <530C70B3.4010103@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49192 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753163AbaBYOaO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Feb 2014 09:30:14 -0500
In-Reply-To: <530C70B3.4010103@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, =?ISO-8859-1?Q?Philippe_R=E9tornaz?= <philippe.retornaz@epfl.ch>

Hi Florian,

On 02/25/2014 12:30 PM, Florian Vaussard wrote:
> Hi Peter,
>=20
> I got recently to work on the DT support for an OMAP4 board [1], and =
I
> encountered some troubles with the probe of the twl6040 audio codec o=
n
> 3.14-rc kernels. On 3.13, things were working correctly. So I somewha=
t
> managed to bisect this down to [c7f9129 mfd: twl6040: reg_defaults
> support for regmap]. But looking more into it, things are less obviou=
s.

Interesting. I just booted 3.14.0-rc4 with HEAD:
7472e009a3f1 Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security

on my PandaBoard-ES and audio comes up just fine (twl6040).

>=20
> When the init fails, here is what happens:
>=20
> [    2.455749] twl6040 0-004b: Looking up vio-supply from device tree
> [    2.456359] twl6040 0-004b: Looking up v2v1-supply from device tre=
e
> [    2.457061] twl6040 0-004b: Failed to set masks in 0x4: -121
> [    2.463043] twl6040: probe of 0-004b failed with error -121
>=20
> logically resulting in

Do you have the regulators in your dts file? vio and v2v1 is needed by =
the
twl6040.

>=20
> [    2.770050] omap-abe-twl6040 sound.4: ASoC: CODEC twl6040-codec no=
t
> registered
> [    2.777770] omap-abe-twl6040 sound.4: snd_soc_register_card() fail=
ed:
> -517
> [    2.785095] platform sound.4: Driver omap-abe-twl6040 requests pro=
be
> deferral
>=20
> We get a EREMOTEIO when calling regmap_add_irq_chip() from
> twl6040_probe(). regmap_add_irq_chip() will try to perform non-cached
> i2c writes, where the omap-i2c driver get a NACK from the remote chip=
=2E
> Strange enough, the non-cached read just before (i.e.
> twl6040_reg_read(twl6040, TWL6040_REG_ASICREV)) succeeds.

Power is not enabled? There might be missing 32K clock for twl6040, can=
 you
check your board's schema against PandaBoard-ES?

>=20
> After some fiddling around, I could find that delaying the call to
> regmap_add_irq_chip(), let's say by msleep(1), will "solve" the probl=
em.
>=20
> As the TRM for TWL6040 is not public, and I cannot physically access =
the
> i2c bus on the board, I ran out of hypothesis. I first suspected a
> concurrent access from the McPDM bus, but the mcpdm driver does not s=
eem
> to perform command (write) access.
>=20
> As the regulators are enabled just before, could it be the twl6040 IP
> which is not yet initialized, and NACK'ing writes but not reads? The
> commit c7f9129 changed the regmap logic by reducing the number of
> non-cached accesses, and thus changed the access timings, so it may h=
ave
> trigged this behaviour. But this is pure supposition, as I cannot hac=
k
> the i2c bus :( And adding any kind of tracing before
> regmap_add_irq_chip() usually delays enough to make the probe succeed=
s.
>=20
> Any ideas?
>=20
> Regards,
> Florian
>=20
> [1] http://thread.gmane.org/gmane.linux.ports.arm.omap/110801
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
