From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [RFC 1/5] ARM: P2V: separate PHYS_OFFSET from platform definitions
Date: Wed, 5 Jan 2011 11:04:43 -0600
Message-ID: <0D753D10438DA54287A00B027084269764C3FB5B87@AUSP01VMBX24.collaborationhost.net>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>
Cc: Viresh Kumar <viresh.kumar@st.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Kevin Hilman <khilman@deeprootsystems.com>, Anton Vorontsov <avorontsov@mvista.com>, Lennert Buytenhek <kernel@wantstofly.org>, Kukjin Kim <kgene.kim@samsung.com>, Erik Gilling <konkers@android.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Vincent Sanders <support@simtec.co.uk>, "Hans J.
	Koch" <hjk@linutronix.de>, Magnus Damm <magnus.damm@gmail.com>, Marc Singer <elf@buici.com>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, Alessandro Rubini <rubini@unipv.it>, Jiandong Zheng <jdzheng@broadcom.com>, Wan ZongShun <mcuos.com@gmail.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Ryan Mallon <ryan@bluewatersys.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Ben
List-Id: linux-omap@vger.kernel.org

On Tuesday, January 04, 2011 1:22 PM, Russell King wrote:
> This uncouple PHYS_OFFSET from the platform definitions, thereby
> facilitating run-time computation of the physical memory offset.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> diff --git a/arch/arm/mach-ep93xx/include/mach/memory.h b/arch/arm/mach-ep93xx/include/mach/memory.h
> index 554064e..c9400cf 100644
> --- a/arch/arm/mach-ep93xx/include/mach/memory.h
> +++ b/arch/arm/mach-ep93xx/include/mach/memory.h
> @@ -6,15 +6,15 @@
>  #define __ASM_ARCH_MEMORY_H
>  
>  #if defined(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)
> -#define PHYS_OFFSET		UL(0x00000000)
> +#define PLAT_PHYS_OFFSET		UL(0x00000000)
>  #elif defined(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)
> -#define PHYS_OFFSET		UL(0xc0000000)
> +#define PLAT_PHYS_OFFSET		UL(0xc0000000)
>  #elif defined(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)
> -#define PHYS_OFFSET		UL(0xd0000000)
> +#define PLAT_PHYS_OFFSET		UL(0xd0000000)
>  #elif defined(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)
> -#define PHYS_OFFSET		UL(0xe0000000)
> +#define PLAT_PHYS_OFFSET		UL(0xe0000000)
>  #elif defined(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)
> -#define PHYS_OFFSET		UL(0xf0000000)
> +#define PLAT_PHYS_OFFSET		UL(0xf0000000)
>  #else
>  #error "Kconfig bug: No EP93xx PHYS_OFFSET set"
>  #endif

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
