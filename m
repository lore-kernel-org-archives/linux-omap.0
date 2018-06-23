From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: drivers/net: Convert random_ether_addr to
 eth_random_addr
Date: Sat, 23 Jun 2018 10:50:55 +0900 (KST)
Message-ID: <20180623.105055.470247977870986966.davem@davemloft.net>
References: <c558b59181756dfe647bcdeaf659c386701c0948.1529689773.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c558b59181756dfe647bcdeaf659c386701c0948.1529689773.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joe@perches.com
Cc: derek.chickles@caviumnetworks.com, satananda.burla@caviumnetworks.com, felix.manlunas@caviumnetworks.com, raghu.vatsavayi@caviumnetworks.com, ulli.kroll@googlemail.com, linus.walleij@linaro.org, yisen.zhuang@huawei.com, salil.mehta@huawei.com, jeffrey.t.kirsher@intel.com, bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com, harish.patil@cavium.com, manish.chopra@cavium.com, Dept-GELinuxNICDev@cavium.com, linux-net-drivers@solarflare.com, ecree@solarflare.com, bkenward@solarflare.com, grygorii.strashko@ti.com, w-kwok2@ti.com, m-karicheri2@ti.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, woojung.huh@microchip.com, ath9k-devel@qca.qualcomm.com, mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, kvalo@codeaurora.org, netdev@vger.kernel.o
List-Id: linux-omap@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Fri, 22 Jun 2018 10:51:00 -0700

> random_ether_addr is a #define for eth_random_addr which is
> generally preferred in kernel code by ~3:1
> 
> Convert the uses of random_ether_addr to enable removing the #define
> 
> Miscellanea:
> 
> o Convert &vfmac[0] to equivalent vfmac and avoid unnecessary line wrap
> 
> Signed-off-by: Joe Perches <joe@perches.com>

I'll apply this to net-next, thanks Joe.
