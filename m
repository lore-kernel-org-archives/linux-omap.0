From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] ARM: DTS: am335x-evmsk: Audio and MMC1 fix (for 3.13?)
Date: Tue, 7 Jan 2014 10:15:04 +0200
Message-ID: <52CBB788.9070404@ti.com>
References: <1387790915-7217-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57780 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbaAGIPg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jan 2014 03:15:36 -0500
In-Reply-To: <1387790915-7217-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, rogerq@ti.com, balbi@ti.com

Hi Benoit,

On 12/23/2013 11:28 AM, Peter Ujfalusi wrote:
> Hi,
>=20
> The audio frequency has been incorrectly set in the DTS file which re=
sults
> incorrect playback frequency on EVM-SK.
>=20
> The SD card can not be used without the second patch on 3.13-rc5.

Can you take a look at these and if it is possible send it for 3.13?

>=20
> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
>   ARM: DTS: am335x-evmsk: Correct audio clock frequency
>   ARM: dts: am335x-evmsk: Fix mmc1 support
>=20
>  arch/arm/boot/dts/am335x-evmsk.dts | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
