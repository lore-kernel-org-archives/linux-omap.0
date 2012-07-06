From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2: twl-common: fix compiler warnings
Date: Fri, 06 Jul 2012 12:07:47 +0200
Message-ID: <4FF6B8F3.8010501@ti.com>
References: <1340880592-21700-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:36557 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756525Ab2GFKHc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 06:07:32 -0400
Received: by obbup19 with SMTP id up19so10999825obb.26
        for <linux-omap@vger.kernel.org>; Fri, 06 Jul 2012 03:07:30 -0700 (PDT)
In-Reply-To: <1340880592-21700-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

Hi Tero,

On 06/28/2012 12:49 PM, Tero Kristo wrote:
> OMAP2 does not use the external voltage controller code for TWL, and
> thus OMAP2 only compilation generates following warnings:
>=20
> arch/arm/mach-omap2/twl-common.c:51: warning: 'twl_set_voltage' defin=
ed but not used
> arch/arm/mach-omap2/twl-common.c:57: warning: 'twl_get_voltage' defin=
ed but not used
>=20
> This patch moves the code in question behind ARCH specific flags and
> eliminates these warnings.
>=20
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

I did sent similar patch:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg70432.html

Tony applied it to fixes I think already.

--=20
P=E9ter


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
