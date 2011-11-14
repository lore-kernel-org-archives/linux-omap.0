From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/4] OMAPDSS: HDMI: update static timing table
Date: Mon, 14 Nov 2011 09:20:38 +0200
Message-ID: <1321255238.1931.5.camel@deskari>
References: <1321016977-1808-1-git-send-email-mythripk@ti.com>
	 <1321016977-1808-2-git-send-email-mythripk@ti.com>
	 <1321016977-1808-3-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-zwRx9jgBm20/J9/8zbqD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:47708 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751638Ab1KNHUp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Nov 2011 02:20:45 -0500
Received: by bke11 with SMTP id 11so8042546bke.33
        for <linux-omap@vger.kernel.org>; Sun, 13 Nov 2011 23:20:42 -0800 (PST)
In-Reply-To: <1321016977-1808-3-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-zwRx9jgBm20/J9/8zbqD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2011-11-11 at 18:39 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Add the vsync polarity, hsync polarity, interlace to hdmi_video_timings.
> Remove the now duplicate structure hdmi_timings.
> update the static table structure in HDMI with CEA/VESA code and mode.
>=20
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.c            |   96 ++++++++++++++---------=
-----
>  drivers/video/omap2/dss/ti_hdmi.h         |   14 ++---
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   20 +++---
>  3 files changed, 63 insertions(+), 67 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdm=
i.c
> index c56378c..f76ae47 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -88,42 +88,42 @@ static struct {
>   * map it to corresponding CEA or VESA index.
>   */
> =20
> -static const struct hdmi_timings cea_vesa_timings[OMAP_HDMI_TIMINGS_NB] =
=3D {
> -	{ {640, 480, 25200, 96, 16, 48, 2, 10, 33} , 0 , 0},
> -	{ {1280, 720, 74250, 40, 440, 220, 5, 5, 20}, 1, 1},
> -	{ {1280, 720, 74250, 40, 110, 220, 5, 5, 20}, 1, 1},
> -	{ {720, 480, 27027, 62, 16, 60, 6, 9, 30}, 0, 0},
> -	{ {2880, 576, 108000, 256, 48, 272, 5, 5, 39}, 0, 0},
> -	{ {1440, 240, 27027, 124, 38, 114, 3, 4, 15}, 0, 0},
> -	{ {1440, 288, 27000, 126, 24, 138, 3, 2, 19}, 0, 0},
> -	{ {1920, 540, 74250, 44, 528, 148, 5, 2, 15}, 1, 1},
> -	{ {1920, 540, 74250, 44, 88, 148, 5, 2, 15}, 1, 1},
> -	{ {1920, 1080, 148500, 44, 88, 148, 5, 4, 36}, 1, 1},
> -	{ {720, 576, 27000, 64, 12, 68, 5, 5, 39}, 0, 0},
> -	{ {1440, 576, 54000, 128, 24, 136, 5, 5, 39}, 0, 0},
> -	{ {1920, 1080, 148500, 44, 528, 148, 5, 4, 36}, 1, 1},
> -	{ {2880, 480, 108108, 248, 64, 240, 6, 9, 30}, 0, 0},
> -	{ {1920, 1080, 74250, 44, 638, 148, 5, 4, 36}, 1, 1},
> -	/* VESA From Here */
> -	{ {640, 480, 25175, 96, 16, 48, 2 , 11, 31}, 0, 0},
> -	{ {800, 600, 40000, 128, 40, 88, 4 , 1, 23}, 1, 1},
> -	{ {848, 480, 33750, 112, 16, 112, 8 , 6, 23}, 1, 1},
> -	{ {1280, 768, 79500, 128, 64, 192, 7 , 3, 20}, 1, 0},
> -	{ {1280, 800, 83500, 128, 72, 200, 6 , 3, 22}, 1, 0},
> -	{ {1360, 768, 85500, 112, 64, 256, 6 , 3, 18}, 1, 1},
> -	{ {1280, 960, 108000, 112, 96, 312, 3 , 1, 36}, 1, 1},
> -	{ {1280, 1024, 108000, 112, 48, 248, 3 , 1, 38}, 1, 1},
> -	{ {1024, 768, 65000, 136, 24, 160, 6, 3, 29}, 0, 0},
> -	{ {1400, 1050, 121750, 144, 88, 232, 4, 3, 32}, 1, 0},
> -	{ {1440, 900, 106500, 152, 80, 232, 6, 3, 25}, 1, 0},
> -	{ {1680, 1050, 146250, 176 , 104, 280, 6, 3, 30}, 1, 0},
> -	{ {1366, 768, 85500, 143, 70, 213, 3, 3, 24}, 1, 1},
> -	{ {1920, 1080, 148500, 44, 148, 80, 5, 4, 36}, 1, 1},
> -	{ {1280, 768, 68250, 32, 48, 80, 7, 3, 12}, 0, 1},
> -	{ {1400, 1050, 101000, 32, 48, 80, 4, 3, 23}, 0, 1},
> -	{ {1680, 1050, 119000, 32, 48, 80, 6, 3, 21}, 0, 1},
> -	{ {1280, 800, 79500, 32, 48, 80, 6, 3, 14}, 0, 1},
> -	{ {1280, 720, 74250, 40, 110, 220, 5, 5, 20}, 1, 1}
> +static const struct hdmi_config cea_vesa_timings[OMAP_HDMI_TIMINGS_NB] =
=3D {
> +{ {640, 480, 25200, 96, 16, 48, 2, 10, 33, 0, 0, 0}, {1, HDMI_HDMI} },
> +{ {720, 480, 27027, 62, 16, 60, 6, 9, 30, 0, 0, 0}, {2, HDMI_HDMI} },
> +{ {1280, 720, 74250, 40, 110, 220, 5, 5, 20, 1, 1, 0}, {4, HDMI_HDMI} },
> +{ {1920, 540, 74250, 44, 88, 148, 5, 2, 15, 1, 1, 1}, {5, HDMI_HDMI} },
> +{ {1440, 240, 27027, 124, 38, 114, 3, 4, 15, 0, 0, 1}, {6, HDMI_HDMI} },
> +{ {1920, 1080, 148500, 44, 88, 148, 5, 4, 36, 1, 1, 0}, {16, HDMI_HDMI} =
},
> +{ {720, 576, 27000, 64, 12, 68, 5, 5, 39, 0, 0, 0}, {17, HDMI_HDMI} },
> +{ {1280, 720, 74250, 40, 440, 220, 5, 5, 20, 1, 1, 0}, {19, HDMI_HDMI} }=
,
> +{ {1920, 540, 74250, 44, 528, 148, 5, 2, 15, 1, 1, 1}, {20, HDMI_HDMI} }=
,
> +{ {1440, 288, 27000, 126, 24, 138, 3, 2, 19, 0, 0, 1}, {21, HDMI_HDMI} }=
,
> +{ {1440, 576, 54000, 128, 24, 136, 5, 5, 39, 0, 0, 0}, {29, HDMI_HDMI} }=
,
> +{ {1920, 1080, 148500, 44, 528, 148, 5, 4, 36, 1, 1, 0}, {31, HDMI_HDMI}=
 },
> +{ {1920, 1080, 74250, 44, 638, 148, 5, 4, 36, 1, 1, 0}, {32, HDMI_HDMI} =
},
> +{ {2880, 480, 108108, 248, 64, 240, 6, 9, 30, 0, 0, 0}, {35, HDMI_HDMI} =
},
> +{ {2880, 576, 108000, 256, 48, 272, 5, 5, 39, 0, 0, 0}, {37, HDMI_HDMI} =
},
> +/* VESA From Here */
> +{ {640, 480, 25175, 96, 16, 48, 2 , 11, 31, 0, 0, 0}, {4, HDMI_DVI} },
> +{ {800, 600, 40000, 128, 40, 88, 4 , 1, 23, 1, 1, 0}, {9, HDMI_DVI} },
> +{ {848, 480, 33750, 112, 16, 112, 8 , 6, 23, 1, 1, 0}, {0xE, HDMI_DVI} }=
,
> +{ {1280, 768, 79500, 128, 64, 192, 7 , 3, 20, 1, 0, 0}, {0x17, HDMI_DVI}=
 },
> +{ {1280, 800, 83500, 128, 72, 200, 6 , 3, 22, 1, 0, 0}, {0x1C, HDMI_DVI}=
 },
> +{ {1360, 768, 85500, 112, 64, 256, 6 , 3, 18, 1, 1, 0}, {0x27, HDMI_DVI}=
 },
> +{ {1280, 960, 108000, 112, 96, 312, 3 , 1, 36, 1, 1, 0}, {0x20, HDMI_DVI=
} },
> +{ {1280, 1024, 108000, 112, 48, 248, 3 , 1, 38, 1, 1, 0}, {0x23, HDMI_DV=
I} },
> +{ {1024, 768, 65000, 136, 24, 160, 6, 3, 29, 0, 0, 0}, {0x10, HDMI_DVI} =
},
> +{ {1400, 1050, 121750, 144, 88, 232, 4, 3, 32, 1, 0, 0}, {0x2A, HDMI_DVI=
} },
> +{ {1440, 900, 106500, 152, 80, 232, 6, 3, 25, 1, 0, 0}, {0x2F, HDMI_DVI}=
 },
> +{ {1680, 1050, 146250, 176 , 104, 280, 6, 3, 30, 1, 0, 0}, {0x3A, HDMI_D=
VI} },
> +{ {1366, 768, 85500, 143, 70, 213, 3, 3, 24, 1, 1, 0}, {0x51, HDMI_DVI} =
},
> +{ {1920, 1080, 148500, 44, 148, 80, 5, 4, 36, 1, 1, 0}, {0x52, HDMI_DVI}=
 },
> +{ {1280, 768, 68250, 32, 48, 80, 7, 3, 12, 0, 1, 0}, {0x16, HDMI_DVI} },
> +{ {1400, 1050, 101000, 32, 48, 80, 4, 3, 23, 0, 1, 0}, {0x29, HDMI_DVI} =
},
> +{ {1680, 1050, 119000, 32, 48, 80, 6, 3, 21, 0, 1, 0}, {0x39, HDMI_DVI} =
},
> +{ {1280, 800, 79500, 32, 48, 80, 6, 3, 14, 0, 1, 0}, {0x1B, HDMI_DVI} },
> +{ {1280, 720, 74250, 40, 110, 220, 5, 5, 20, 1, 1, 0}, {0x55, HDMI_DVI} =
}

If you don't have any particular reason to use both decimal and
hexadecimal numbers for code, just use one type of numbers.

 Tomi


--=-zwRx9jgBm20/J9/8zbqD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOwMFGAAoJEPo9qoy8lh71w5kQAI2zX9PdgUxJdQ/RIYSA6WPT
jN9k8xPe/swW77978IpKpEycjplxOgPvQSrQYRX8L6sgDPvaNzkt2khoi3sRKBcF
izfoCzrRnEOuet0fbAxAdjjvrCgULx92W6CbXMxI0fy3Pnd5ZF7D+sHbGeMlZHnD
sBpwFx2NZvm5pz9EGxImQDHKki0eg93rUfOefHyM752YTbZWU0+hpH45/7nC3jc2
7fKX2c6xqr1g4MFtnhkffr/s1A3m7d/+6FGXLLmF8R1n1PbgPH2chnx/1MjbY5uk
Yk1bRTKMrJdBThPFkkQZ/h70+6wDec6xbdaoo8Zj8cME/1CkjU4h4vtxAUbFYIrw
MjxLRh4C1cCZl15eNzLX51zm+f8qnAvnJZe5SDb06uDGfgPRP3vGhCq9Tga2ocuS
04Og6JxCLAY3j53YT/Z4eI9ij/zoqjr2GrnMqKho3VxM4k/6nxSJEkLMcbHYH0DV
e/r6FyABKIyQ+LNsi5kWCxqs7nnp4vBR1ueviT3afu3cwkmzysxngfJlozj3g+OW
370gn8uCy46jTWMQ+EmsHClcrdnC7wHAQZH25UTJA9wsMq8/8U1Xc6iAsN9KEDAF
sZLzx2la21jThtra6MXRjJHB6CMAB3vChTNbZqEYuX40RfzvKNNgQ23g+eHdxicW
z09dm7mbLaqZHjusxgok
=ft56
-----END PGP SIGNATURE-----

--=-zwRx9jgBm20/J9/8zbqD--

