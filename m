From: Imre Deak <imre.deak@solidboot.com>
Subject: Re: TSC2101/2102
Date: Thu, 15 Mar 2007 12:23:25 +0200
Message-ID: <20070315102325.GA4555@bitbox.mine.nu>
References: <20070309140650.GC4399@bitbox.mine.nu>
	<fb249edb0703090623o367ec663h85dc581644cb258d@mail.gmail.com>
	<45F7F6D4.20203@gmail.com> <20070314170952.GB10230@bitbox.mine.nu>
	<002801c7669f$d0fe2be0$c7a3580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <002801c7669f$d0fe2be0$c7a3580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kmpark@infradead.org>
Cc: 'Linux OMAP ML' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Mar 15, 2007 at 10:18:14AM +0900, Kyungmin Park wrote:
> [...] 
>
> In the previous time, I implemented the tsc2101 on OMAP2 based on tsc2301.
> [1]

I needed only the basic register read / write interface to access the
TSC2101 GPIO lines. The TS part you wrote is still needed, it's
init function being called from the tsc2101.c probe, as it's done in
tsc2301-core.c.

> The current code only supports 16-bit tsc2101 for OMAP1.
> We have to consider OMAP2 tsc2101 for H4 and apollon.

Is the 32-bit interface some alternate interface configuration for the chip?
In the TSC2101 spec I found at least only a description of the 16-bit
protocoll. Could you point to a documentation for this?

--Imre

> 
> Here's simple changes.
> 
> +struct tsc2101_platform_data {
> +       int     (*init)(struct spi_device *spi);
> +       void    (*cleanup)(struct spi_device *spi);
> +       void    (*enable_mclk)(struct spi_device *spi);
> +       void    (*disable_mclk)(struct spi_device *spi);
> 
> +       int       bits_per_word;
> 
> +};
> 
> How about to add 'bits_per_word' to platform. So if the bits_per_word is
> empty. it assumes it will use 16-bit, otherwise we use it provided from
> platform.
> 
> +struct tsc2101_device {
> +       struct mutex            mutex;
> +       int                     mclk_enabled;
> +       struct clock            *mclk_ck;
> +       struct spi_message      message;
> +       struct spi_transfer     transfer[2];
> +       u16                     command;
> +       void                    (*enable_mclk)(struct spi_device *spi);
> +       void                    (*disable_mclk)(struct spi_device *spi);
> 
> +       int		32bit_shift;	/* 16 if 32-bit bus, otherwise 0 */
> 
> +};
> 
> Please change the command from u16 to u32. Umm, I'm not sure we have to
> change the parameter from u16 *data to u32 *data.
> 
> I will check it.
> 
> Thank you,
> Kyungmin Park
> 
> 1. http://linux.omap.com/pipermail/linux-omap-open-source/2007-
> January/008933.html
> 
