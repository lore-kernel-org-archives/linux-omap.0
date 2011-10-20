From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v7 21/21] OMAP2+: UART: Do not gate uart clocks if used
 for debug_prints
Date: Thu, 20 Oct 2011 15:17:30 +0530
Message-ID: <CAAL8m4wrWKndf3o9jN1R7+1MDgPwrJVA1qWcDPdU-d5wdWTu6Q@mail.gmail.com>
References: <1318952141-10697-1-git-send-email-govindraj.raja@ti.com>
 <1318952141-10697-2-git-send-email-govindraj.raja@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593032869342E@dbde02.ent.ti.com>
 <CAAL8m4wKu8w2iTBXmtekD09RaD200qFAG6jH=RgdmjJ2uuX8cA@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB5930328693855@dbde02.ent.ti.com>
 <CAAL8m4ztvsGiJz_2uPd8rtEYSsVv24oSPi4eK==U30k==75muA@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB5930328693C85@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930328693C85@dbde02.ent.ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "R, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 20, 2011 at 2:58 PM, Mohammed, Afzal <afzal@ti.com> wrote:
> Hi Govindraj,
>
> On Thu, Oct 20, 2011 at 14:09:22, Govindraj wrote:
>> Yes correct, I missed that part here is the updated patch [1]
>> Updated change-log for debug/loglevel and checked console_loglevel
>> in addition to debug in bootargs.
>
> Perhaps checking console_loglevel only is sufficient, if I am not
> missing anything, passing "debug" thr' bootargs only causes loglevel
> to be set to 10 and nothing else.

Agree, Updated [1]

--
Thanks,
Govindraj.R

[1]

https://gitorious.org/runtime_3-0/runtime_3-0/commit/4b04aa54e61540f1f358ef412f2aaa3bab8de7c1


diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 5e3bbce..4f41369 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -65,6 +65,7 @@ static LIST_HEAD(uart_list);
 static u8 num_uarts;
 static u8 console_uart_id = -1;
 static u8 no_console_suspend;
+static u8 uart_debug;

 #define DEFAULT_RXDMA_POLLRATE         1       /* RX DMA polling rate (us) */
 #define DEFAULT_RXDMA_BUFSIZE          4096    /* RX DMA buffer size */
@@ -310,6 +311,13 @@ static int __init omap_serial_early_init(void)
                if (cmdline_find_option(uart_name)) {
                        console_uart_id = uart->num;

+                       if (console_loglevel >= 10) {
+                               uart_debug = true;
+                               pr_info("%s used as console in debug mode"
+                                               " uart%d clocks will not be"
+                                               " gated", uart_name, uart->num);
+                       }
+
                        if (cmdline_find_option("no_console_suspend"))
                                no_console_suspend = true;

@@ -414,7 +422,8 @@ void __init omap_serial_init_port(struct
omap_board_data *bdata,

        oh->dev_attr = uart;

-       if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
+       if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
+                       && !uart_debug)
                device_init_wakeup(&pdev->dev, true);
 }
