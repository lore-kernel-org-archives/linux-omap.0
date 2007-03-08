From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH] ARM: OMAP: MMC performance upgrade on OMAP2
Date: Thu, 8 Mar 2007 06:02:15 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47081032@dlee13.ent.ti.com>
References: <00e501c7608c$6ec71fe0$c7a3580a@swcenter.sec.samsung.co.kr><005a01c76147$dd2d8a30$c7a3580a@swcenter.sec.samsung.co.kr><45EFA96D.9010604@drzeus.cx>
	<007001c76153$523fc800$c7a3580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: kmpark@infradead.org, Pierre Ossman <drzeus@drzeus.cx>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Kyungmin,
=20
OMAP2420 doesn't support High Speed. OMAP2430 does support Highspeed.
=20
Please see our code for 2430 (its on linux.omap.com).
=20
Regards,
Khasim

________________________________

From: linux-omap-open-source-bounces@linux.omap.com on behalf of =
Kyungmin Park
Sent: Thu 3/8/2007 1:28 AM
To: 'Pierre Ossman'
Cc: linux-omap-open-source@linux.omap.com
Subject: RE: [PATCH] ARM: OMAP: MMC performance upgrade on OMAP2




> Do _not_ take these flags lightly. If you enable them when
> the hardware doesn't support the alternative timing, you have
> a good chance of cards not working. So to me this looks very
> wrong as the pre-48MHz controllers probably only follow the
> legacy timing requirements.
>

I'm not sure OMAP2 MMC supports highspeed feature. I can't find anytings =
in
OMAP2 TRM.

        if (cpu_class_is_omap2())
                mmc->caps |=3D MMC_CAP_MMC_HIGHSPEED | =
MMC_CAP_SD_HIGHSPEED;

mmc0: selected 48.000MHz transfer rate
mmc0: clock 48000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 2 timing =
1

Then is it dependent on platform?

        if (minfo->highspeed)
                mmc->caps |=3D MMC_CAP_MMC_HIGHSPEED | =
MMC_CAP_SD_HIGHSPEED;

And even though we set HIGHSPEED, the card set their clock correctly. Is =
it
right?

mmc0: selected 26.000MHz transfer rate
mmc0: clock 26000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 2 timing =
1

Thank you,
Kyungmin Park

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
