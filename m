From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 11/11] TWL4030: Codec: Fix fucntion declaration error
Date: Tue, 31 Aug 2010 10:32:13 +0300
Message-ID: <201008311032.13910.peter.ujfalusi@nokia.com>
References: <1282856209-15645-1-git-send-email-manjugk@ti.com> <1282856209-15645-12-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53704 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755992Ab0HaHcm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 03:32:42 -0400
In-Reply-To: <1282856209-15645-12-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

On Thursday 26 August 2010 23:56:49 ext G, Manjunath Kondaiah wrote:
> From: Manjunatha GK <manjugk@ti.com>
>=20
> Fixes sparse warning for the below error
>=20
> drivers/mfd/twl4030-codec.c:118:5: error: symbol
> 'twl4030_codec_disable_resource' redeclared with different type
> (originally declared at include/linux/mfd/twl4030- codec.h:268) -
> incompatible argument 1 (different signedness)
>=20
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Nishanth Menon <nm@ti.com>
> ---
>  include/linux/mfd/twl4030-codec.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/include/linux/mfd/twl4030-codec.h
> b/include/linux/mfd/twl4030-codec.h index 2ec317c..0f7300e 100644
> --- a/include/linux/mfd/twl4030-codec.h
> +++ b/include/linux/mfd/twl4030-codec.h
> @@ -265,7 +265,7 @@ enum twl4030_codec_res {
>  	TWL4030_CODEC_RES_MAX,
>  };
>=20
> -int twl4030_codec_disable_resource(enum twl4030_codec_res id);
> +int twl4030_codec_disable_resource(unsigned id);
>  int twl4030_codec_enable_resource(enum twl4030_codec_res id);
>  unsigned int twl4030_codec_get_mclk(void);

I have no idea how this happened, but it would be better to correct the=
 driver=20
instead the header.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
