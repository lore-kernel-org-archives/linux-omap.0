From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 1/4] ARM: omap2: avoid section mismatch warning
Date: Mon, 10 Dec 2018 18:11:30 -0800
Message-ID: <b660e44c-c446-a408-c766-1d67a62d6fd7@oracle.com>
References: <20181210215856.2238253-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210215856.2238253-1-arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, arm@kernel.org, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/10/2018 1:58 PM, Arnd Bergmann wrote:
> WARNING: vmlinux.o(.text+0x27530): Section mismatch in reference from the function am43xx_suspend_init() to the function .init.text:am43xx_map_scu()
> The function am43xx_suspend_init() references
> the function __init am43xx_map_scu().
> This is often because am43xx_suspend_init lacks a __init
> annotation or the annotation of am43xx_map_scu is wrong.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
