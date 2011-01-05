From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [RFC 1/5] ARM: P2V: separate PHYS_OFFSET from platform definitions
Date: Wed, 5 Jan 2011 08:58:56 +0530
Message-ID: <4D23E578.7030108@st.com>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>, Kevin Hilman <khilman@deeprootsystems.com>, Anton Vorontsov <avorontsov@mvista.com>, Lennert Buytenhek <kernel@wantstofly.org>, Kukjin Kim <kgene.kim@samsung.com>, Erik Gilling <konkers@android.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Vincent Sanders <support@simtec.co.uk>, "Hans J. Koch" <hjk@linutronix.de>, Magnus Damm <magnus.damm@gmail.com>, Marc Singer <elf@buici.com>, Tony Lindgren <tony@atomide.com>, David Brown <davidb@codeaurora.org>, Alessandro Rubini <rubini@unipv.it>, Jiandong Zheng <jdzheng@broadcom.com>, Wan ZongShun <mcuos.com@gmail.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Ryan Mallon <ryan@bluewatersys.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, linux-t
List-Id: linux-omap@vger.kernel.org

On 01/05/2011 01:52 AM, Russell King - ARM Linux wrote:
> This uncouple PHYS_OFFSET from the platform definitions, thereby
> facilitating run-time computation of the physical memory offset.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> diff --git a/arch/arm/plat-spear/include/plat/memory.h b/arch/arm/plat-spear/include/plat/memory.h
> index 27a4aba..7e3599e 100644
> --- a/arch/arm/plat-spear/include/plat/memory.h
> +++ b/arch/arm/plat-spear/include/plat/memory.h
> @@ -15,6 +15,6 @@
>  #define __PLAT_MEMORY_H
> 
>  /* Physical DRAM offset */
> -#define PHYS_OFFSET            UL(0x00000000)
> +#define PLAT_PHYS_OFFSET               UL(0x00000000)
> 
>  #endif /* __PLAT_MEMORY_H */

Acked-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
