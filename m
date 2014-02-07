From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v2 2/4] MFD: TPS65218: Add driver for the TPS65218 PMIC
Date: Fri, 7 Feb 2014 19:11:42 +0530
Message-ID: <52F4E296.1070205@ti.com>
References: <1391665814-18814-1-git-send-email-j-keerthy@ti.com> <1391665814-18814-3-git-send-email-j-keerthy@ti.com> <20140207111229.GN14727@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140207111229.GN14727@lee--X1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Keerthy <j-keerthy@ti.com>, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, sameo@linux.intel.com, grant.likely@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 07 February 2014 04:42 PM, Lee Jones wrote:
> On Thu, 06 Feb 2014, Keerthy wrote:
>
>> The TPS65218 chip is a power management IC for Portable Navigation Systems
>> and Tablet Computing devices. It contains the following components:
>>
>>   - Regulators.
>>   - Over Temperature warning and Shut down.
>>
>> This patch adds support for tps65218 mfd device. At this time only
>> the regulator functionality is made available.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   drivers/mfd/Kconfig          |   15 +++
>>   drivers/mfd/Makefile         |    1 +
>>   drivers/mfd/tps65218.c       |  281 +++++++++++++++++++++++++++++++++++++++++
>>   include/linux/mfd/tps65218.h |  284 ++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 581 insertions(+)
>>   create mode 100644 drivers/mfd/tps65218.c
>>   create mode 100644 include/linux/mfd/tps65218.h
> Applied, thanks.
>
Thanks Lee Jones!
