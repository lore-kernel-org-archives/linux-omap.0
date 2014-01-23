From: Jingoo Han <jg1.han@samsung.com>
Subject: RE: [PATCH 1/4] power_supply: Add inlmt,iterm, min/max temp props
Date: Thu, 23 Jan 2014 18:00:55 +0900
Message-ID: <000101cf1819$a0321700$e0964500$%han@samsung.com>
References: <1390411194-21410-1-git-send-email-jenny.tc@intel.com>
 <1390411194-21410-2-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1390411194-21410-2-git-send-email-jenny.tc@intel.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jenny TC' <jenny.tc@intel.com>, linux-kernel@vger.kernel.org, 'Dmitry Eremin-Solenikov' <dbaryshkov@gmail.com>
Cc: 'Anton Vorontsov' <cbouatmailru@gmail.com>, 'Anton Vorontsov' <anton.vorontsov@linaro.org>, 'Kim Milo' <Milo.Kim@ti.com>, 'Lee Jones' <lee.jones@linaro.org>, 'Chanwoo Choi' <cw00.choi@samsung.com>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Rupesh Kumar' <rupesh.kumar@stericsson.com>, 'Lars-Peter Clausen' <lars@metafoo.de>, =?utf-8?Q?'Pali_Roh=C3=A1r'?= <pali.rohar@gmail.com>, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Rhyland Klein' <rklein@nvidia.com>, 'Pavel Machek' <pavel@ucw.cz>, 'David Woodhouse' <dwmw2@infradead.org>, 'Tony Lindgren' <tony@atomide.com>, 'Russell King' <linux@arm.linux.org.uk>, 'Sebastian Reichel' <sre@ring0.de>, aaro.koskinen@iki.fi, freemangordon@abv.bg, linux-omap@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-omap@vger.kernel.org

On Thursday, January 23, 2014 2:20 AM, Jenny TC wrote:
> 
> Add new power supply properties for input current, charge termination
> current, min and max temperature
> 
> POWER_SUPPLY_PROP_TEMP_MIN - minimum operatable temperature
> POWER_SUPPLY_PROP_TEMP_MAX - maximum operatable temperature
> 
> POWER_SUPPLY_PROP_INLMT - input current limit programmed by charger. Indicates
> the input current for a charging source.
> 
> POWER_SUPPLY_PROP_CHARGE_TERM_CUR - Charge termination current used to detect
> the end of charge condition
> 
> Change-Id: Ifb40662bbfa24387ac7493ffa7ce01c6fae7e800

Please remove this 'Change-Id' from the commit message.

Best regards,
Jingoo Han

> Signed-off-by: Jenny TC <jenny.tc@intel.com>
> ---
>  Documentation/power/power_supply_class.txt |    6 ++++++
>  drivers/power/power_supply_sysfs.c         |    4 ++++
>  include/linux/power_supply.h               |    4 ++++
>  3 files changed, 14 insertions(+)
