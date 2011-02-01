From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v2 08/13] OMAP2+: McBSP: hwmod adaptation for McBSP
Date: Tue, 01 Feb 2011 14:22:49 +0200
Message-ID: <4D47FB19.9040901@nokia.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com> <1296485437-12806-9-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:35839 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951Ab1BAMQ6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Feb 2011 07:16:58 -0500
In-Reply-To: <1296485437-12806-9-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, p-basak2@ti.com

Looks good, but...

On 01/31/2011 04:50 PM, ext Kishon Vijay Abraham I wrote:
> Modify OMAP2+ McBSP to use omap hwmod framework APIs
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  arch/arm/mach-omap2/mcbsp.c |  685 +++------------------------------=
----------
>  1 files changed, 43 insertions(+), 642 deletions(-)

=2E..

> +	if (oh->class->rev =3D=3D MCBSP_CONFIG_TYPE3) {
> +		if (id =3D=3D 2)
> +			pdata->buffer_size =3D 0x500; /*FIFO size is 1024 + 256*/
> +		else
> +			pdata->buffer_size =3D 0x80;  /*FIFO size is 128*/
> +	}

I would add spaces around these comments (after /* and before */).

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
