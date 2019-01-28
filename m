From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-5.0-rc3, ti-soc-thermal: unmet dependencies Kconfig warning
Date: Mon, 28 Jan 2019 08:34:33 -0800
Message-ID: <20190128163433.GY5720@atomide.com>
References: <8baafd04-eda0-778d-84d2-7ccc1d07db6b@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8baafd04-eda0-778d-84d2-7ccc1d07db6b@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, Keerthy <j-keerthy@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Randy Dunlap <rdunlap@infradead.org> [190126 06:54]:
> Hi,
> 
> FYI, I'm seeing this Kconfig warning in 5.0-rc3:

Thanks for reporting it.

> WARNING: unmet direct dependencies detected for TI_SOC_THERMAL
>   Depends on [n]: THERMAL [=y] && (ARCH_HAS_BANDGAP || COMPILE_TEST [=n]) && HAS_IOMEM [=y]
>   Selected by [m]:
>   - MMC_SDHCI_OMAP [=m] && MMC [=m] && MMC_SDHCI_PLTFM [=m] && OF [=y]
> 
> 
> Maybe there is already a patch for this?

Keerthy can you please take a look at this issue?

Regards,

Tony
