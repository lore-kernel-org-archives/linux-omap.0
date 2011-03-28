From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH] watchdog: twl4030_wdt: Watchdog device registration issue fix
Date: Mon, 28 Mar 2011 16:34:53 +0530
Message-ID: <AANLkTinVtNtoAh_AnLxC3z2EHzLXdndj27SjR3LD5Z8d@mail.gmail.com>
References: <1299012474-4993-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:46182 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752443Ab1C1LE4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Mar 2011 07:04:56 -0400
In-Reply-To: <1299012474-4993-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-watchdog@vger.kernel.org, wim@iguana.be
Cc: linux-omap@vger.kernel.org, j-keerthy@ti.com

Hello All,

Any comments on this patch?

Regards,
Keerthy

On Wed, Mar 2, 2011 at 2:17 AM, Keerthy <j-keerthy@ti.com> wrote:
> twl4030_wdt driver and omap_wdt driver are registering as misc_device=
 name as
> "watchdog" and the same minor number WATCHDOG_MINOR( value =3D 130).
> There is a conflict since the name and minor were the same for
> both the misc_device registered by omap_wdt.c as well as twl4030_wdt.=
c
>
> The omap_wdt.c probe is getting called first. Hence it succeeds.
> twl4030_wdt.c always failed on the minor number comparison check.
> Now requesting for MISC_DYNAMIC_MINOR as the minor
> number for twl4030_watchdog and renamed the device name as
> "twl4030_watchdog".
>
> Tested for basic boot up on OMAP4 Blaze and OMAP3630 SDP. OMAP3630 SD=
P
> twl4030_wdt registration succeeds.2430SDP boot tested, watchdog regis=
tration
> without errors.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> =A0drivers/watchdog/twl4030_wdt.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl403=
0_wdt.c
> index b5045ca..89bf78d 100644
> --- a/drivers/watchdog/twl4030_wdt.c
> +++ b/drivers/watchdog/twl4030_wdt.c
> @@ -183,8 +183,8 @@ static int __devinit twl4030_wdt_probe(struct pla=
tform_device *pdev)
> =A0 =A0 =A0 =A0wdt->timer_margin =A0 =A0 =A0 =3D 30;
> =A0 =A0 =A0 =A0wdt->miscdev.parent =A0 =A0 =3D &pdev->dev;
> =A0 =A0 =A0 =A0wdt->miscdev.fops =A0 =A0 =A0 =3D &twl4030_wdt_fops;
> - =A0 =A0 =A0 wdt->miscdev.minor =A0 =A0 =A0=3D WATCHDOG_MINOR;
> - =A0 =A0 =A0 wdt->miscdev.name =A0 =A0 =A0 =3D "watchdog";
> + =A0 =A0 =A0 wdt->miscdev.minor =A0 =A0 =A0=3D MISC_DYNAMIC_MINOR;
> + =A0 =A0 =A0 wdt->miscdev.name =A0 =A0 =A0 =3D "twl4030_watchdog";
>
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, wdt);
>
> --
> 1.7.0.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
