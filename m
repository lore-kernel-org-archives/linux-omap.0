From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 01/23] serial: omap: define and use to_uart_omap_port()
Date: Fri, 24 Aug 2012 12:07:14 -0700
Message-ID: <20120824190713.GP11011@atomide.com>
References: <1345717983-18179-1-git-send-email-balbi@ti.com>
 <1345717983-18179-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1345717983-18179-2-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, alan@linux.intel.com
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [120823 03:37]:
> current code only works because struct uart_port
> is the first member on the uart_omap_port structure.
> 
> If, for whatever reason, someone puts another
> member as the first of the structure, that cast
> won't work anymore. In order to be safe, let's use
> a container_of() which, for now, gets optimized into
> a cast anyway.
> 
> Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/omap-serial.h |  2 ++
>  drivers/tty/serial/omap-serial.c              | 36 +++++++++++++--------------
>  2 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
> index 1a52725..f3b35d9 100644
> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> @@ -137,4 +137,6 @@ struct uart_omap_port {
>  	struct work_struct	qos_work;
>  };
>  
> +#define to_uart_omap_port(p)	((container_of((p), struct uart_omap_port, port)))
> +
>  #endif /* __OMAP_SERIAL_H__ */

For the arch/arm/*omap*/* parts:

Acked-by: Tony Lindgren <tony@atomide.com>

FYI, note that there are ARM SoC patches to move various header files to
live under include/linux/platform_data which may cause conflicts with these
changes.

Regards,

Tony
