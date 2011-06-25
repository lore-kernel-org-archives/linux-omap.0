From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 08/12] Serial: OMAP2+: Make the RX_TIMEOUT for DMA configurable for each UART
Date: Fri, 24 Jun 2011 17:16:47 -0700
Message-ID: <87liwqrci8.fsf@ti.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
	<1307532194-13039-9-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1307532194-13039-9-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Wed, 8 Jun 2011 16:53:10 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jon Hunter <jon-hunter@ti.com>
List-Id: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> From: Jon Hunter <jon-hunter@ti.com>
>
> When using DMA there are two timeouts defined. The first timeout,
> rx_timeout, is really a polling rate in which software polls the
> DMA status to see if the DMA has finished. This is necessary for
> the RX side because we do not know how much data we will receive.
> The secound timeout, RX_TIMEOUT, is a timeout after which the
> DMA will be stopped if no more data is received. To make this
> clearer, rename rx_timeout as rx_poll_rate and rename the
> function serial_omap_rx_timeout() to serial_omap_rxdma_poll().
>
> The OMAP-Serial driver defines an RX_TIMEOUT of 3 seconds that is
> used to indicate when the DMA for UART can be stopped if no more
> data is received. The value is a global definition that is applied
> to all instances of the UART.
>
> Each UART may be used for a different purpose and so the timeout
> required may differ. Make this value configurable for each UART so
> that this value can be optimised for power savings.
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>

Jon, thanks (again) for the well-written, descriptive changelog.

Kevin


