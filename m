From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 3/7] drivers:input:tsc2007: add iio interface to read external ADC input, temperature and raw conversion values
Date: Fri, 6 Nov 2015 17:22:24 +0100
Message-ID: <5E2F70F1-DE42-4FF8-8779-FC0D0CB51A07@goldelico.com>
References: <201511070011.QT9QlGfe%fengguang.wu@intel.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201511070011.QT9QlGfe%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, gta04-owner@goldelico.com
List-Id: linux-omap@vger.kernel.org


Am 06.11.2015 um 17:08 schrieb kbuild test robot <lkp@intel.com>:

> Hi Nikolaus,
> 
> [auto build test ERROR on input/next]
> [also build test ERROR on v4.3 next-20151106]
> 
> url:    https://github.com/0day-ci/linux/commits/H-Nikolaus-Schaller/drivers-touchscreen-tsc2007-and-ads7846-tsc2046-improvements-use-common-touchscreen-bindings-pre-calibration-spi-fix-and-provide-iio-raw-values/20151106-231936
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> config: x86_64-randconfig-s2-11062316 (attached as .config)
> reproduce:
>        # save the attached .config to linux build tree
>        make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>   drivers/built-in.o: In function `tsc2007_remove':
>>> tsc2007.c:(.text+0x23a2a6): undefined reference to `iio_device_unregister'
>   drivers/built-in.o: In function `tsc2007_probe':
>>> tsc2007.c:(.text+0x23a3bf): undefined reference to `devm_iio_device_alloc'
>>> tsc2007.c:(.text+0x23a436): undefined reference to `iio_device_register'

Ok, that is a missing dependency on CONFIG_IIO.

Has been noted for V2.
