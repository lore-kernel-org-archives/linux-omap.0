From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: OMAP v3.10-rc regressions that no one's fixed
Date: Tue, 11 Jun 2013 09:47:36 +0200
Message-ID: <51B6D618.30809@ti.com>
References: <alpine.DEB.2.02.1306100716560.4604@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48516 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075Ab3FKHsB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jun 2013 03:48:01 -0400
In-Reply-To: <alpine.DEB.2.02.1306100716560.4604@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On 06/10/2013 09:22 AM, Paul Walmsley wrote:
>=20
> Hi folks -- particularly TIers working on mainline,
>=20
> There are several regressions that started with v3.10-rc that no one'=
s=20
> fixed for over a month.  Some of them should be quite easy:
>=20
> * 2430SDP, 3730 Beagle XM, 3530 Beagle, 3517EVM, CM-T3517: {dmic,mcpd=
m} lookup failure
>   - Cause unknown
>   - These IP blocks don't exist on OMAP3xxx/AM35xx chips

I will send a patch soon to fix these. Need to test the patch(es) first=
=2E I
think they surfaced because I have enabled the audio support in
omap2plus_defconfig for OMAP4 and 5 - which require McPDM and DMIC.
Just couple of minutes, and I'll have the fix.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
