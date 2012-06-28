From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/4] OMAPDSS: Cleanup implementation of LCD channels
Date: Thu, 28 Jun 2012 13:50:49 +0300
Message-ID: <1340880649.5037.39.camel@deskari>
References: <cover.1340874806.git.cmahapatra@ti.com>
	 <013a8d0a8698b3f971c5963115b03701141a4688.1340874806.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Db714fD3UMFz639ARf7n"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:50345 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751028Ab2F1Ku5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 06:50:57 -0400
Received: by lboj14 with SMTP id j14so4104195lbo.21
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 03:50:53 -0700 (PDT)
In-Reply-To: <013a8d0a8698b3f971c5963115b03701141a4688.1340874806.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-Db714fD3UMFz639ARf7n
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-28 at 15:10 +0530, Chandrabhanu Mahapatra wrote:
> The current implementation of LCD channels and managers consists of a num=
ber of
> if-else construct which has been replaced by a simpler interface. A const=
ant
> structure mgr_desc has been created in Display Controller (DISPC) module.=
 The
> mgr_desc contains for each channel its name, irqs and  is initialized one=
 time
> with all registers and their corresponding fields to be written to enable
> various features of Display Subsystem. This structure is later used by va=
rious
> functions of DISPC which simplifies the further implementation of LCD cha=
nnels
> and its corresponding managers.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c   |  233 +++++++++++++++++--------------=
------
>  drivers/video/omap2/dss/dsi.c     |    6 +-
>  drivers/video/omap2/dss/dss.h     |    6 +
>  drivers/video/omap2/dss/manager.c |   12 +--
>  4 files changed, 121 insertions(+), 136 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/di=
spc.c
> index 4749ac3..6c16b81 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -57,6 +57,8 @@
> =20
>  #define DISPC_MAX_NR_ISRS		8
> =20
> +#define DISPC_MGR_FLD_MAX		9

You could have this in the enum mgr_ref_fields, as a last entry. Then
it'll automatically have the value 9, and will adjust automatically when
we add new fields. And actually "MAX" is not quite right. MAX would be
8, as that's the maximum value for the vields. "NUM" is perhaps more
correct.
=20
> +
>  struct omap_dispc_isr_data {
>  	omap_dispc_isr_t	isr;
>  	void			*arg;
> @@ -119,6 +121,78 @@ enum omap_color_component {
>  	DISPC_COLOR_COMPONENT_UV		=3D 1 << 1,
>  };
> =20
> +enum mgr_reg_fields {
> +	DISPC_MGR_FLD_ENABLE,
> +	DISPC_MGR_FLD_STNTFT,
> +	DISPC_MGR_FLD_GO,
> +	DISPC_MGR_FLD_TFTDATALINES,
> +	DISPC_MGR_FLD_STALLMODE,
> +	DISPC_MGR_FLD_TCKENABLE,
> +	DISPC_MGR_FLD_TCKSELECTION,
> +	DISPC_MGR_FLD_CPR,
> +	DISPC_MGR_FLD_FIFOHANDCHECK,
> +};
> +
> +static const struct {
> +	const char *name;
> +	u32 vsync_irq;
> +	u32 framedone_irq;
> +	u32 sync_lost_irq;
> +	struct reg_field reg_desc[DISPC_MGR_FLD_MAX];
> +} mgr_desc[] =3D {
> +	[OMAP_DSS_CHANNEL_LCD] =3D {
> +		.name		=3D "LCD",
> +		.vsync_irq	=3D DISPC_IRQ_VSYNC,
> +		.framedone_irq	=3D DISPC_IRQ_FRAMEDONE,
> +		.sync_lost_irq	=3D DISPC_IRQ_SYNC_LOST,
> +		.reg_desc	=3D {
> +			[DISPC_MGR_FLD_ENABLE]		=3D { DISPC_CONTROL,  0,  0 },
> +			[DISPC_MGR_FLD_STNTFT]		=3D { DISPC_CONTROL,  3,  3 },
> +			[DISPC_MGR_FLD_GO]		=3D { DISPC_CONTROL,  5,  5 },
> +			[DISPC_MGR_FLD_TFTDATALINES]	=3D { DISPC_CONTROL,  9,  8 },
> +			[DISPC_MGR_FLD_STALLMODE]	=3D { DISPC_CONTROL, 11, 11 },
> +			[DISPC_MGR_FLD_TCKENABLE]	=3D { DISPC_CONFIG,  10, 10 },
> +			[DISPC_MGR_FLD_TCKSELECTION]	=3D { DISPC_CONFIG,  11, 11 },
> +			[DISPC_MGR_FLD_CPR]		=3D { DISPC_CONFIG,  15, 15 },
> +			[DISPC_MGR_FLD_FIFOHANDCHECK]	=3D { DISPC_CONFIG,  16, 16 },
> +		},
> +	},
> +	[OMAP_DSS_CHANNEL_DIGIT] =3D {
> +		.name		=3D "DIGIT",
> +		.vsync_irq	=3D DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN,
> +		.framedone_irq	=3D DISPC_IRQ_FRAMEDONETV,

There's a problem with this one. FRAMEDONETV is a new thing, appeared in
omap4. So for this we need a system to select the data depending on the
DSS version.

I suggest you remove the framedone_irq entry for now, and keep the old
code to handle the framedone irq. Let's add it later when we can handle
the differences between omap versions.

Or actually, looking at the code, perhaps you can keep the framedone_irq
field, but set it to 0 for DIGIT mgr. This would keep the functionality
the same as it is now, because there's only one place in dispc.c where
we use FRAMEDONETV, and your patch doesn't touch it. In other places we
presume that TV out does not have FRAMEDONE interrupt (i.e. the irq
number is 0).

> +		.sync_lost_irq	=3D DISPC_IRQ_SYNC_LOST_DIGIT,
> +		.reg_desc	=3D {
> +			[DISPC_MGR_FLD_ENABLE]		=3D { DISPC_CONTROL,  1,  1 },
> +			[DISPC_MGR_FLD_STNTFT]		=3D { },
> +			[DISPC_MGR_FLD_GO]		=3D { DISPC_CONTROL,  6,  6 },
> +			[DISPC_MGR_FLD_TFTDATALINES]	=3D { },
> +			[DISPC_MGR_FLD_STALLMODE]	=3D { },
> +			[DISPC_MGR_FLD_TCKENABLE]	=3D { DISPC_CONFIG,  12, 12 },
> +			[DISPC_MGR_FLD_TCKSELECTION]	=3D { DISPC_CONFIG,  13, 13 },
> +			[DISPC_MGR_FLD_CPR]		=3D { },
> +			[DISPC_MGR_FLD_FIFOHANDCHECK]	=3D { DISPC_CONFIG,  16, 16 },
> +		},
> +	},
> +	[OMAP_DSS_CHANNEL_LCD2] =3D {
> +		.name		=3D "LCD2",
> +		.vsync_irq	=3D DISPC_IRQ_VSYNC2,
> +		.framedone_irq	=3D DISPC_IRQ_FRAMEDONE2,
> +		.sync_lost_irq	=3D DISPC_IRQ_SYNC_LOST2,
> +		.reg_desc	=3D {
> +			[DISPC_MGR_FLD_ENABLE]		=3D { DISPC_CONTROL2,  0,  0 },
> +			[DISPC_MGR_FLD_STNTFT]		=3D { DISPC_CONTROL2,  3,  3 },
> +			[DISPC_MGR_FLD_GO]		=3D { DISPC_CONTROL2,  5,  5 },
> +			[DISPC_MGR_FLD_TFTDATALINES]	=3D { DISPC_CONTROL2,  9,  8 },
> +			[DISPC_MGR_FLD_STALLMODE]	=3D { DISPC_CONTROL2, 11, 11 },
> +			[DISPC_MGR_FLD_TCKENABLE]	=3D { DISPC_CONFIG2,  10, 10 },
> +			[DISPC_MGR_FLD_TCKSELECTION]	=3D { DISPC_CONFIG2,  11, 11 },
> +			[DISPC_MGR_FLD_CPR]		=3D { DISPC_CONFIG2,  15, 15 },
> +			[DISPC_MGR_FLD_FIFOHANDCHECK]	=3D { DISPC_CONFIG2,  16, 16 },
> +		},
> +	},
> +};
> +
>  static void _omap_dispc_set_irqs(void);
> =20
>  static inline void dispc_write_reg(const u16 idx, u32 val)
> @@ -131,6 +205,19 @@ static inline u32 dispc_read_reg(const u16 idx)
>  	return __raw_readl(dispc.base + idx);
>  }
> =20
> +static u32 mgr_fld_read(enum omap_channel channel, enum mgr_reg_fields r=
egfld)
> +{
> +	const struct reg_field rfld =3D mgr_desc[channel].reg_desc[regfld];
> +	return FLD_GET(dispc_read_reg(rfld.reg), rfld.high, rfld.low);

This could use REG_GET(), instead of FLD_GET(dispc_read_reg(...))

> +}
> +
> +static void mgr_fld_write(enum omap_channel channel,
> +					enum mgr_reg_fields regfld, int val) {
> +	const struct reg_field rfld =3D mgr_desc[channel].reg_desc[regfld];
> +	dispc_write_reg(rfld.reg, FLD_MOD(dispc_read_reg(rfld.reg), val,
> +				rfld.high, rfld.low));
> +}

And this one could use REG_FLD_MOD().

Otherwise, looks good.

 Tomi


--=-Db714fD3UMFz639ARf7n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP7DcJAAoJEPo9qoy8lh716qUP/iM4+QgMmuFLEs9Co5R7Y95Q
IVIoS0u2+PuKLo7LR4Sg2YPnK/kPdLwckn9sbNlypdFtPX392wN9M8hgJKoG8NHK
Qms0faVtfmhgxW1D0nkVuoG/+zpsvr5IwA3NpHpOAokya6olyH8WOBIGizdPi4yH
V/XMN11/pxqmAv6Fz5e/zZtWgMuazft4ZOdi10yegTEaUhtB44hgVgvzugH+MtPP
7vHYwsCr+0waoHa9XdZmWLC5IajkeP1kSIQqPhgcWrJNYZJ2uD0g0zMRXrtQceFp
cfLFCY4OxSrWBGKJ7G+TSlCTwjxRNFRNMib6g2t3j0i3/AdHK2815SGZDispjJRB
5iEGbmKlrftPO/FdRFEO2ALBQKrgcMuvkqJBZUOEud7a/05PYoYIp2C/c5Pv2pW5
Qci81XJjflB6BZk/A9p8RQ1U2WVZ1bQDDNhN+8avehieIN/hzYZL+LgByj3xJD+X
hABS8RR87SDSh0JCVwZ6ioRZ1c1aTXeWl5/LexJ6nLxtdUWptPHPfFAVMh3O1ehk
wXjmKThCAGq2y5XtnC4KDxOS0rYbEjmtOGB+Sx2JkSSIjS5AtqvXrhd8RGxj0uov
IHmvmSSw45N1az5lLVzyURNwJMSrJGh2gdG9KgNvId9gi6DoDJOWPxVLqXnqmXBQ
nGS4U/osk2OBe+ak3VCt
=o73e
-----END PGP SIGNATURE-----

--=-Db714fD3UMFz639ARf7n--

