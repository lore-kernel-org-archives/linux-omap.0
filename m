From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: [PATCH] ARM: OMAP: MMC performance upgrade on OMAP2
Date: Thu, 8 Mar 2007 16:28:04 +0900
Message-ID: <007001c76153$523fc800$c7a3580a@swcenter.sec.samsung.co.kr>
References: <00e501c7608c$6ec71fe0$c7a3580a@swcenter.sec.samsung.co.kr>
	<005a01c76147$dd2d8a30$c7a3580a@swcenter.sec.samsung.co.kr>
	<45EFA96D.9010604@drzeus.cx>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <45EFA96D.9010604@drzeus.cx>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Pierre Ossman' <drzeus@drzeus.cx>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


> Do _not_ take these flags lightly. If you enable them when 
> the hardware doesn't support the alternative timing, you have 
> a good chance of cards not working. So to me this looks very 
> wrong as the pre-48MHz controllers probably only follow the 
> legacy timing requirements.
> 

I'm not sure OMAP2 MMC supports highspeed feature. I can't find anytings in
OMAP2 TRM.
 
	if (cpu_class_is_omap2())
		mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;

mmc0: selected 48.000MHz transfer rate
mmc0: clock 48000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 2 timing 1

Then is it dependent on platform?

	if (minfo->highspeed)
		mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;

And even though we set HIGHSPEED, the card set their clock correctly. Is it
right?

mmc0: selected 26.000MHz transfer rate
mmc0: clock 26000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 2 timing 1

Thank you,
Kyungmin Park
