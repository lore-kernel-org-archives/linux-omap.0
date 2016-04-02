From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 2/2] ARM: OMAP4: Store reboot mode to SAR scratchpad
 memory before restart
Date: Sat, 02 Apr 2016 22:06:28 +0200
Message-ID: <1459627588.12073.30.camel@paulk.fr>
References: <1459279517-17479-1-git-send-email-contact@paulk.fr>
	 <1459279517-17479-2-git-send-email-contact@paulk.fr>
	 <56FB14D3.5090207@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-wXMhGqzhWD0IIkOr5FPU"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56FB14D3.5090207@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Mahaveer, Vishal" <vishalm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org


--=-wXMhGqzhWD0IIkOr5FPU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mardi 29 mars 2016 =C3=A0 18:50 -0500, Nishanth Menon a =C3=A9crit=C2=A0=
:
> On 03/29/2016 02:25 PM, Paul Kocialkowski wrote:
> >=20
> > This adds support for storing the reboot mode command to SAR scratchpad
> > memory,
> > at a location compatible with TI kernels, so that bootloaders can grab =
the
> > reboot mode and act upon it.
> >=20
> > Currently, upstream U-Boot has support for this feature on OMAP4.
> Since this impacts more SoCs than OMAP4, + Vishal.
>=20
> >=20
> >=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> > =C2=A0arch/arm/mach-omap2/common.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A01 +
> > =C2=A0arch/arm/mach-omap2/omap4-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=
 12 ++++++++++++
> > =C2=A0arch/arm/mach-omap2/omap4-restart.c=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A02 +-
> > =C2=A0arch/arm/mach-omap2/omap4-sar-layout.h |=C2=A0=C2=A03 +++
> > =C2=A04 files changed, 17 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.=
h
> > index f7666b9..d773385 100644
> > --- a/arch/arm/mach-omap2/common.h
> > +++ b/arch/arm/mach-omap2/common.h
> > @@ -258,6 +258,7 @@ extern bool gic_dist_disabled(void);
> > =C2=A0extern void gic_timer_retrigger(void);
> > =C2=A0extern void omap_smc1(u32 fn, u32 arg);
> > =C2=A0extern void __iomem *omap4_get_sar_ram_base(void);
> > +extern void omap4_sar_ram_write_boot_mode(const char *cmd);
> > =C2=A0extern void omap_do_wfi(void);
> > =C2=A0
> > =C2=A0#ifdef CONFIG_SMP
> > diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/o=
map4-
> > common.c
> > index 949696b..85f251e 100644
> > --- a/arch/arm/mach-omap2/omap4-common.c
> > +++ b/arch/arm/mach-omap2/omap4-common.c
> > @@ -265,6 +265,18 @@ void __iomem *omap4_get_sar_ram_base(void)
> > =C2=A0	return sar_ram_base;
> > =C2=A0}
> > =C2=A0
> > +void omap4_sar_ram_write_boot_mode(const char *cmd)
> > +{
> > +	void __iomem *sar_base;
> > +
> > +	sar_base =3D omap4_get_sar_ram_base();
> > +
> > +	if (!cmd)
> > +		strncpy(sar_base + BOOT_MODE_OFFSET, "", BOOT_MODE_SIZE);
> > +	else
> > +		strncpy(sar_base + BOOT_MODE_OFFSET, cmd, BOOT_MODE_SIZE);
> > +}
> >=20
> > +
> > =C2=A0/*
> > =C2=A0 * SAR RAM used to save and restore the HW
> > =C2=A0 * context in low power modes
> > diff --git a/arch/arm/mach-omap2/omap4-restart.c b/arch/arm/mach-
> > omap2/omap4-restart.c
> > index e17136a..74f29b5 100644
> > --- a/arch/arm/mach-omap2/omap4-restart.c
> > +++ b/arch/arm/mach-omap2/omap4-restart.c
> > @@ -22,6 +22,6 @@
> > =C2=A0 */
> > =C2=A0void omap44xx_restart(enum reboot_mode mode, const char *cmd)
> > =C2=A0{
> > -	/* XXX Should save 'cmd' into scratchpad for use after reboot */
> > +	omap4_sar_ram_write_boot_mode(cmd);
> I think you might have noticed that the function gets reused for more
> SoCs than just OMAP4. Did you consider the impact on other SoCs?

I did not. In fact, I only figured that newer platforms are also using that=
 code
after writing that patch up. The name is quite confusing IMO, but then the =
whole
mach directory is named "omap2", so I get the logic here.

I have an OMAP5 uEVM board at disposal to test, so I'll at least check it a=
t
runtime on it.

> A) I would suggest you should download the TRMs from TI website and
> check the impact this change has for all other platforms.

Do you think it's enough to check for the SAR scratchpad presence at the sa=
me
address, or is there something more I should look into?

> B) on certain platforms like DRA74 SoCs, warm reset cannot be used -
> instead all warm resets are converted to cold resets. what that means is
> that you'd probably want to update the reset reason to a PMIC scratch
> pad register.

I understand, but since I have no means of testing this, I'm not very
comfortable writing up an implementation. Either way, if SAR memory is ther=
e on
DRA74, this won't cause any trouble. And I'd be more comfortable with someo=
ne
else adding DRA74 support later.

What do you think?

> > =C2=A0	omap_prm_reset_system();
> > =C2=A0}
> > diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-
> > omap2/omap4-sar-layout.h
> > index 792b106..247b2bf 100644
> > --- a/arch/arm/mach-omap2/omap4-sar-layout.h
> > +++ b/arch/arm/mach-omap2/omap4-sar-layout.h
> > @@ -20,6 +20,7 @@
> > =C2=A0#define SAR_BANK4_OFFSET		0x3000
> > =C2=A0
> > =C2=A0/* Scratch pad memory offsets from SAR_BANK1 */
> > +#define BOOT_MODE_OFFSET			0xa0c
> > =C2=A0#define SCU_OFFSET0				0xfe4
> > =C2=A0#define SCU_OFFSET1				0xfe8
> > =C2=A0#define OMAP_TYPE_OFFSET			0xfec
> > @@ -28,6 +29,8 @@
> > =C2=A0#define L2X0_AUXCTRL_OFFSET			0xff8
> > =C2=A0#define L2X0_PREFETCH_CTRL_OFFSET		0xffc
> > =C2=A0
> > +#define BOOT_MODE_SIZE				0xf
> > +
> > =C2=A0/* CPUx Wakeup Non-Secure Physical Address offsets in SAR_BANK3 *=
/
> > =C2=A0#define CPU0_WAKEUP_NS_PA_ADDR_OFFSET		0xa04
> > =C2=A0#define CPU1_WAKEUP_NS_PA_ADDR_OFFSET		0xa08
> >=20
>=20
--=-wXMhGqzhWD0IIkOr5FPU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXACZEAAoJEIT9weqP7pUM/08P/ia/5QK+i6QQwDs6trDzrTGB
fizIMoCjRkYpw0ezci5ct6MqGtg3Jh+W2v03/OLJnm+i5MkwvKd4CnsQClQPYsBL
METFRvdWHwfrzeGPssuG/OaIbRzk1yJ8qiMD80xexn4wAlw1eusopBvxe70zVm92
c3pRUU3bVztXTjoCzwINhzWqMZa88ohxcAk4fRcVjxgOJL05d1Xm5UuPvY3jHOFd
EfoAVFxwNUhlwJ0+NOqi/TfnwmElpRtp8KoGuf46WOZT3MqZTMPwiCC3FlNuNda1
/MA1IBBylOvn8ha5+AYQYDLJ9eDpHpl3l4SFMpY2yLePffJfZTxUIm6azj1Jxmd2
i8jhZGCBusbdYgyvESmx0ZOdTLyIUIdbdFCkhsF6i9ThgOy0wk7bg2yOmB2JMQC8
ZfWvmOy5ZfTwu2Q6bDbPSYLgBeL/OsbEX9uWXos3eKlZ6DqVXpb4VSe1t64YSEyB
9pta9F7ZUydp5lwd40iLKpgyAyhQ5WTa3xfiSdNKDLnKoZwWCBs10UtKUwh5B9tg
olcMx+FiC+rIzs1lYHsTEb3GdJaV0EkpDRFuyKE6oQghCMApb2R16nKTTlX+jDGF
J9TIePQs4J9kWjvuMTFyHKqjh0DTSWOI0lDoGMy11iNaGYEWl2ucdc8mYdEP8ac4
GpzU6bZEiwx3OEOd2eXm
=P0A2
-----END PGP SIGNATURE-----

--=-wXMhGqzhWD0IIkOr5FPU--
