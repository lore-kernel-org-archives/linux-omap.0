From: Tony Lindgren <tony@atomide.com>
Subject: Re: mismerge of 'omap-cleanup-for-v3.6' into tmp-merge
Date: Thu, 12 Jul 2012 23:43:50 -0700
Message-ID: <20120713064349.GH1122@atomide.com>
References: <87fw8yjby4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:47022 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857Ab2GMGnw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jul 2012 02:43:52 -0400
Content-Disposition: inline
In-Reply-To: <87fw8yjby4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Mark A. Greer" <Mark.Greer@AnimalCreek.com>

* Kevin Hilman <khilman@ti.com> [120711 13:15]:
> Hi Tony,
>=20
> In your current master branch, commit 3dd50d054 (Merge tag
> 'omap-cleanup-for-v3.6' into tmp-merge) added back the mpu_3xxx_clkdm
> into the common clockdomains that was removed by commit 16e5e2c47 (AR=
M:
> OMAP AM35x: clockdomain data: Fix clockdomain dependencies)
>=20
> This causes duplicate registration attempts for mpu_clkdm and the sec=
ond
> registration causes a warning from the clockdomain layer:
>=20
>    clockdomain: mpu_clkdm: powerdomain ({Z=EF=BF=BD=18=D7=82=EF=BF=BD=
 does not exist

OK. Can you please check if this issue is also in arm-soc for-next
and provide a patch if that's the case?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
