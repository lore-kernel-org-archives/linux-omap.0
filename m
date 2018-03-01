From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600 on
 Droid 4
Date: Wed, 28 Feb 2018 19:47:13 -0800
Message-ID: <20180301034713.GD62820@atomide.com>
References: <20180217210723.7013-1-tony@atomide.com>
 <201802191503.yJma6SYG%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201802191503.yJma6SYG%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

* kbuild test robot <lkp@intel.com> [180219 07:47]:
>  > 354		if (reset_gpio >= 0)
>    355			gpiod_set_value_cansleep(reset_gpio, 1);

Thanks this test can be just dropped. Will send out an updated
version shortly.

Regards,

Tony
