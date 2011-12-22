From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 4/9] ASoC: twl6040: Convert MICBIAS to SUPPLY widget
Date: Thu, 22 Dec 2011 16:30:17 +0200
Message-ID: <4EF33EF9.5090306@ti.com>
References: <1324557768-8216-1-git-send-email-peter.ujfalusi@ti.com> <1324557768-8216-5-git-send-email-peter.ujfalusi@ti.com> <20111222141503.GZ4546@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:47786 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751273Ab1LVOaO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 09:30:14 -0500
Received: by mail-lpp01m010-f41.google.com with SMTP id v3so1773485lag.0
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 06:30:12 -0800 (PST)
In-Reply-To: <20111222141503.GZ4546@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On 12/22/2011 04:15 PM, Mark Brown wrote:
> On Thu, Dec 22, 2011 at 02:42:43PM +0200, Peter Ujfalusi wrote:
>> In order to avoid breakage change the omap-abe-twl6040
>> machine driver's routing.
>=20
> I was going to apply this but it doesn't apply against current code..=
=2E

Yes, because I is touching the machine driver as well (after the rename=
)
to avoid breakage.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
