From: Randy Dunlap <rdunlap@infradead.org>
Subject: linux-5.0-rc3, ti-soc-thermal: unmet dependencies Kconfig warning
Date: Fri, 25 Jan 2019 22:54:11 -0800
Message-ID: <8baafd04-eda0-778d-84d2-7ccc1d07db6b@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-omap@vger.kernel.org
Cc: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

FYI, I'm seeing this Kconfig warning in 5.0-rc3:

WARNING: unmet direct dependencies detected for TI_SOC_THERMAL
  Depends on [n]: THERMAL [=y] && (ARCH_HAS_BANDGAP || COMPILE_TEST [=n]) && HAS_IOMEM [=y]
  Selected by [m]:
  - MMC_SDHCI_OMAP [=m] && MMC [=m] && MMC_SDHCI_PLTFM [=m] && OF [=y]


Maybe there is already a patch for this?

thanks,
-- 
~Randy
