From: "Will Deacon" <will.deacon@arm.com>
Subject: RE: [PATCH 09/14] ARM: v6k: select generic atomic64 code according to
	V6	variants
Date: Tue, 18 Jan 2011 10:24:20 -0000
Message-ID: <24079.7136015773$1295346396@news.gmane.org>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1PeugN-0003Sp-0J@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1PeugN-0003Sp-0J@rmk-PC.arm.linux.org.uk>
Content-Language: en-gb
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> If CONFIG_CPU_V6 is enabled, avoid using the double-word exclusive
> instructions in the kernel's atomic implementations as these are not
> supported.  Fall back to the generic spinlock code instead.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 95ba92f..283d7b9 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -7,7 +7,7 @@ config ARM
>  	select HAVE_MEMBLOCK
>  	select RTC_LIB
>  	select SYS_SUPPORTS_APM_EMULATION
> -	select GENERIC_ATOMIC64 if (!CPU_32v6K || !AEABI)
> +	select GENERIC_ATOMIC64 if (CPU_V6 || !CPU_32v6K || !AEABI)
>  	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
>  	select HAVE_ARCH_KGDB
>  	select HAVE_KPROBES if (!XIP_KERNEL && !THUMB2_KERNEL)

Acked-by: Will Deacon <will.deacon@arm.com>

Thanks,

Will
