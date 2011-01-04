From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v1 09/10] OMAP: McBSP: use omap_device APIs to modify
 SYSCONFIG
Date: Tue, 04 Jan 2011 09:35:12 +0200
Message-ID: <4D22CDB0.6000503@nokia.com>
References: <1292917231-13800-1-git-send-email-kishon@ti.com> <1292917231-13800-9-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:24894 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926Ab1ADHfT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Jan 2011 02:35:19 -0500
In-Reply-To: <1292917231-13800-9-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@deeprootsystems.com, p-basak2@ti.com, b-cousson@ti.com

Hi,

On 12/21/10 09:40, ext Kishon Vijay Abraham I wrote:
> McBSP2/3 in OMAP3 has sidetone feature which requires autoidle
> to be disabled before starting the sidetone. Also SYSCONFIG
> register has to be set with smart idle or no idle depending on the
> dma op mode (threshold or element sync). For doing these operations
> dynamically at runtime, omap_device APIs are used to modify SYSCONFIG=
 register.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>


>  static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
>  {
> +	struct omap_device *od;
> +
> +	od =3D find_omap_device_by_dev(mcbsp->dev);
>  	/*
>  	 * Enable wakup behavior, smart idle and all wakeups
>  	 * REVISIT: some wakeups may be unnecessary
>  	 */
>  	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
> -		u16 syscon;
> -
> -		syscon =3D MCBSP_READ(mcbsp, SYSCON);
> -		syscon &=3D ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
> -
> -		if (mcbsp->dma_op_mode =3D=3D MCBSP_DMA_MODE_THRESHOLD) {
> -			syscon |=3D (ENAWAKEUP | SIDLEMODE(0x02) |
> -					CLOCKACTIVITY(0x02));
> -			MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
> -		} else {
> -			syscon |=3D SIDLEMODE(0x01);
> -		}
> -
> -		MCBSP_WRITE(mcbsp, SYSCON, syscon);
> +		if (mcbsp->dma_op_mode !=3D MCBSP_DMA_MODE_THRESHOLD)
> +			omap_device_noidle(od);

Should you configure McBSP to SMART_IDLE, when the THRESHOLD mode is
selected?
While we are here:
1. How we select the WAKE events from McBSP?
   We need XRDYEN, and RRDYEN bits for wake (in WAKEUPEN register), and
   also we need to enable the WAKEUP in SYSCON register.
2. How we are configuring the CLOCKACTIVITY field in SYSCON register?

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
