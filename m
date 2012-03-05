From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap3_beagle: Init only uart3 used for console
Date: Mon, 05 Mar 2012 12:00:16 -0800
Message-ID: <87399mkecv.fsf@ti.com>
References: <1330945952-14714-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1330945952-14714-1-git-send-email-govindraj.raja@ti.com>
 (Govindraj R.'s message of "Mon, 5 Mar 2012 16:42:32 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> From: "Govindraj.R" <govindraj.raja@ti.com>
>
> On beagle some of uart mux lines are used for other
> purpose so init only uart3.

OK, but you should also be clear that this patch is effectively
disabling all UARTS (except UART3) by defatul, which I'm not sure all
Beagle users will be happy about.

> Uart2 rx line clashes with gpio_147 used for usb ehci
> phy reset. Initializing uart2 pad_mux lines can break
> ehci module on beagle xm.
> (gpio_147 is available on uart2_rx in mode4 reference 
> mux34xx.c -> uart2_rx.gpio_147)

As Koen mentioned, this conflict only exists on certain boards, so
you should be clear that this is just an example.

> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Tested-by: Robert Nelson <robertcnelson@gmail.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

[...]

> +
> +static inline void board_serial_init(void)

Should be __init

[...]

> +static inline void board_serial_init(void)

here too.

Kevin
