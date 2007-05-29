From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 11/11] OMAP 3430 support in include/arm/arch-omap
Date: Tue, 29 May 2007 12:27:56 +0530
Message-ID: <5d5443650705282357w1e67ff00gdb6ac3158fb7d1bd@mail.gmail.com>
References: <9C23CDD79DA20A479D4615857B2E2C47FF0E37@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47FF0E37@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On 5/29/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
>
> Adding OMAP3430 support to include/asm-arm/arch-omap
>
> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
>
> Files Changed:
>  clock.h       |    1
>  cpu.h         |   28 +++++++++++++++++++++++
>  debug-macro.S |   12 ++++++++++
>  dma.h         |   68 +++++++++++++++++++++++++++++-----------------------------
>  entry-macro.S |    6 ++++-
>  hardware.h    |   12 +++++++++-
>  io.h          |   57 ++++++++++++++++++++++++++++++++++++++++++++++++
>  irqs.h        |   17 ++++++++++++++
>  mcbsp.h       |    2 -
>  memory.h      |    2 -
>  serial.h      |    5 ++++
>

...

> >
> diff -purN linux-omap/include/asm-arm/arch-omap/serial.h val_3430_GIT/include/asm-arm/arch-omap/serial.h
> --- linux-omap/include/asm-arm/arch-omap/serial.h       2006-11-20 21:56:59.000000000 -0600
> +++ val_3430_GIT/include/asm-arm/arch-omap/serial.h     2007-05-25 22:59:27.000000000 -0500
> @@ -20,6 +20,11 @@
>  #define OMAP_UART1_BASE                0x4806a000
>  #define OMAP_UART2_BASE                0x4806c000
>  #define OMAP_UART3_BASE                0x4806e000
> +#elif defined(CONFIG_ARCH_OMAP3)
> +/* OMAP3 serial ports */
> +#define OMAP_UART1_BASE                0x4806a000
> +#define OMAP_UART2_BASE                0x4806c000
> +#define OMAP_UART3_BASE                0x49020000
>  #endif

Why not just #ifdefing UART3, as it is the only differs in base address.?

-- 
--Trilok Soni
