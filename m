From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [GIT PULL] ARM: OMAP: GPIO cleanup and device tree adaptation
Date: Fri, 9 Mar 2012 09:38:12 -0700
Message-ID: <CACxGe6uo774Vf=rgnxxT6htFYSu7xROhgT-=Ernfbr9Lp-WvYQ@mail.gmail.com>
References: <4F5A30DB.7060004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:41799 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754557Ab2CIQid convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Mar 2012 11:38:33 -0500
Received: by obbuo6 with SMTP id uo6so2343341obb.19
        for <linux-omap@vger.kernel.org>; Fri, 09 Mar 2012 08:38:32 -0800 (PST)
In-Reply-To: <4F5A30DB.7060004@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>

On Fri, Mar 9, 2012 at 9:33 AM, Cousson, Benoit <b-cousson@ti.com> wrot=
e:
> Hi Grant,
>
> Please pull the patches for OMAP GPIO DT support.
> It is based on your current gpio/next branch.
>
> Thanks,
> Benoit

Merged, thanks.

g.

>
>
> The following changes since commit e4e449e82871c53ef3b22bd3a50fceabc0=
638926:
> =A0Mark Brown (1):
> =A0 =A0 =A0 =A0gpiolib: Add comments explaining the _cansleep() WARN_=
ON()s
>
> are available in the git repository at:
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-=
dt.git for_grant/for_3.4/dt_gpio
>
> Benoit Cousson (4):
> =A0 =A0 =A0gpio/omap: Remove bank->id information and misc cleanup
> =A0 =A0 =A0gpio/omap: Use devm_ API and add request_mem_region
> =A0 =A0 =A0gpio/omap: Add DT support to GPIO driver
> =A0 =A0 =A0gpio/omap: Fix IRQ handling for SPARSE_IRQ
>
> =A0.../devicetree/bindings/gpio/gpio-omap.txt =A0 =A0 =A0 =A0 | =A0 3=
6 ++++
> =A0arch/arm/plat-omap/include/plat/gpio.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 22 +--
> =A0drivers/gpio/gpio-omap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0208 ++++++++++++++------
> =A03 files changed, 190 insertions(+), 76 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/gpio/gpio-oma=
p.txt



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
