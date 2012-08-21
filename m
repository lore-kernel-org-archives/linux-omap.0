From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC/PATCH 00/13] OMAP UART patches
Date: Tue, 21 Aug 2012 16:13:59 +0530
Message-ID: <CAMQu2gxJqpJG0LbhbJ-YKOEpR=2_ogu2SpdUtvafn2kBXWudyg@mail.gmail.com>
References: <1345540555-24359-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1345540555-24359-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: alan@linux.intel.com, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shubhrajyoti Datta <shubhrajyoti@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 21, 2012 at 2:45 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi guys,
>
> here's a series of cleanup patches to the OMAP serial
> driver. A later series could be made re-implementing
> DMA using the DMA Engine API. Note that for RX DMA
> we could be using RX Timeout IRQ as a hint that we better
> use PIO instead ;-)
>
> All patches were tested on my pandaboard, but I'd really
> like to receive Tested-by on other platforms.
>
> After this goes in, I'll probably try to get UART wakeup
> working again and only after that look at DMA.
>
> cheers
>
> Felipe Balbi (13):
>   serial: omap: define and use to_uart_omap_port()
>   serial: omap: always return IRQ_HANDLED
>   serial: omap: define helpers for pdata function pointers
>   serial: omap: don't access the platform_device
>   serial: omap: drop DMA support
>   serial: add OMAP-specific defines
>   serial: omap: simplify IRQ handling
>   serial: omap: refactor receive_chars() into rdi/rlsi handlers
>   serial: omap: move THRE check to transmit_chars()
>   serial: omap: stick to put_autosuspend
>   serial: omap: set dev->drvdata before enabling pm_runtime
>   serial: omap: drop unnecessary check from remove
>   serial: omap: make sure to suspend device before remove
>
Apart from that one question on last patch, rest of the clean-up
is really good. Nice work.

FWIW,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
