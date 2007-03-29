From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: MMC performance upgrade on OMAP2
Date: Thu, 29 Mar 2007 16:13:18 -0400
Message-ID: <20070329201316.GG3638@atomide.com>
References: <00e501c7608c$6ec71fe0$c7a3580a@swcenter.sec.samsung.co.kr>
	<9C23CDD79DA20A479D4615857B2E2C476F2884@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C476F2884@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com, kmpark@infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Syed Mohammed, Khasim <x0khasim@ti.com> [070308 23:38]:
> Hi Kyungmin,
> 
> For OMAP2420 there are few MMC erratas,
> 
> 1. If MMC controller is configured for 4bit and if MMC CLK frequency is
> over 24Mhz it has as a diminishing impact on throughput. Hence, it is
> not recommended to use a clock over 24MHz for MMC 4 bits mode.

> >@@ -1096,7 +1098,10 @@ static int __init mmc_omap_probe(struct
> >platform_device *pdev)
> >
> > 	mmc->ops = &mmc_omap_ops;
> > 	mmc->f_min = 400000;
> >-	mmc->f_max = 24000000;
> >+	if (cpu_class_is_omap2())
> >+		mmc->f_max = 48000000;
> >+	else
> >+		mmc->f_max = 24000000;
> > 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> > 	mmc->caps = MMC_CAP_MULTIWRITE | MMC_CAP_BYTEBLOCK;

How about throwing a cpu_is_omap2420() in there to work around the
clock limitation above mentioned by Khasim?

Tony
