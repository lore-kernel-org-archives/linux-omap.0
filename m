From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/3] iio:adc: add iio driver for Palmas (twl6035/7)
 gpadc
Date: Mon, 5 Oct 2015 14:54:01 +0800
Message-ID: <201510051420.XEoCPVd3%fengguang.wu@intel.com>
References: <fba10a9902d88110569630da2a86ed4faf261e79.1444025628.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fba10a9902d88110569630da2a86ed4faf261e79.1444025628.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Marek Belisko <marek@goldelico.com>, Pradeep Goudagunta <pgoudagunta@nvidia.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>, gg@slimlogic.co.uk, jic23@jic23.retrosnub.co.uk, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Nikolaus,

[auto build test WARNING on v4.3-rc4 -- if it's inappropriate base, please ignore]


coccinelle warnings: (new ones prefixed by >>)

>> drivers/iio/adc/palmas_gpadc.c:798:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
