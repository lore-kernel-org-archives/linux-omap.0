From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH] regulator: tps65217: fix build error if REGULATOR is
 not enabled
Date: Thu, 19 Jul 2012 12:35:24 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13E9F98DB@DBDE01.ent.ti.com>
References: <1342593663-23938-1-git-send-email-anilkumar@ti.com>
 <20120718094449.GA22739@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9F8BD7@DBDE01.ent.ti.com>
 <20120718100013.GC22739@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20120718100013.GC22739@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-next-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On Wed, Jul 18, 2012 at 15:30:13, Mark Brown wrote:
> On Wed, Jul 18, 2012 at 09:55:57AM +0000, AnilKumar, Chimata wrote:
> 
> > Regulators platform data is added to platform device in MFD driver, which we
> > need for regulator driver, of_regulator_match() is used to check the regulator
> > consumers if we pass DT data. If we do not enable CONFIG_REGULATOR then
> > of_regulator_match() is not exported, so we see this error.
> 
> Why are you doing that in the MFD driver?
> 

I got your point, I referred tps6586x driver while developing the initial driver.
Based on tps6586x MFD driver I added REGULATOR flag. I think tps6586x MFD driver
need to be cleaned up.

I will submit a patch to make tps65217 MFD driver independent of REGULATOR
framework.

Thanks
AnilKumar