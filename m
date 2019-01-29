From: Keerthy <j-keerthy@ti.com>
Subject: Re: linux-5.0-rc3, ti-soc-thermal: unmet dependencies Kconfig warning
Date: Tue, 29 Jan 2019 09:09:45 +0530
Message-ID: <6c970fca-35ea-f327-3f77-9b61c37554d5@ti.com>
References: <8baafd04-eda0-778d-84d2-7ccc1d07db6b@infradead.org>
 <20190128163433.GY5720@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128163433.GY5720@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-omap@vger.kernel.org

On 28/01/19 10:04 PM, Tony Lindgren wrote:
> Hi,
> 
> * Randy Dunlap <rdunlap@infradead.org> [190126 06:54]:
>> Hi,
>>
>> FYI, I'm seeing this Kconfig warning in 5.0-rc3:
> 
> Thanks for reporting it.
> 
>> WARNING: unmet direct dependencies detected for TI_SOC_THERMAL
>>   Depends on [n]: THERMAL [=y] && (ARCH_HAS_BANDGAP || COMPILE_TEST [=n]) && HAS_IOMEM [=y]
>>   Selected by [m]:
>>   - MMC_SDHCI_OMAP [=m] && MMC [=m] && MMC_SDHCI_PLTFM [=m] && OF [=y]
>>
>>
>> Maybe there is already a patch for this?
> 
> Keerthy can you please take a look at this issue?

https://lore.kernel.org/patchwork/patch/1030366/

This is fixed. It is in the linux-next already.

> 
> Regards,
> 
> Tony
> 
