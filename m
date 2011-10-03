From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 23/30] ARM: omap2: select twl4030 support on boards that
	need it
Date: Mon, 03 Oct 2011 10:49:10 +0530
Message-ID: <4E8945CE.6070800@ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-24-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317566760-25681-24-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> These three boards unconditionally use the twl4030 driver
> from the board-zoom-display.c file. Make sure that the driver
> is always there.
> We also need to select the I2C core so we are able to build
> that driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-omap2/Kconfig |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 57b66d5..4deeade 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -253,6 +253,8 @@ config MACH_OMAP_ZOOM2
>  	select SERIAL_CORE_CONSOLE
>  	select SERIAL_8250_CONSOLE
>  	select REGULATOR_FIXED_VOLTAGE
> +	select TWL4030_CORE
> +	select I2C
>  
Another option to ensure I2C is selected when
TWL* drivers are selected is let it depends
on I2C. That wat we can avoid patching every
machine entry with I2C option.
Not a strong opinion though.

Regards
Santosh
