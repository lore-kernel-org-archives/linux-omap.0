From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v7 21/21] OMAP2+: UART: Do not gate uart clocks if used
 for debug_prints
Date: Thu, 20 Oct 2011 14:09:22 +0530
Message-ID: <CAAL8m4ztvsGiJz_2uPd8rtEYSsVv24oSPi4eK==U30k==75muA@mail.gmail.com>
References: <1318952141-10697-1-git-send-email-govindraj.raja@ti.com>
 <1318952141-10697-2-git-send-email-govindraj.raja@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593032869342E@dbde02.ent.ti.com>
 <CAAL8m4wKu8w2iTBXmtekD09RaD200qFAG6jH=RgdmjJ2uuX8cA@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB5930328693855@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52972 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab1JTIjo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Oct 2011 04:39:44 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930328693855@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "R, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Oct 19, 2011 at 7:50 PM, Mohammed, Afzal <afzal@ti.com> wrote:
> Hi Govindraj,
>
> On Wed, Oct 19, 2011 at 18:22:58, Govindraj wrote:
>> On Wed, Oct 19, 2011 at 11:05 AM, Mohammed, Afzal <afzal@ti.com> wro=
te:
>> > Hi Govindraj,
>> >
>> > On Tue, Oct 18, 2011 at 21:05:41, R, Govindraj wrote:
>> >> If OMAP UART is used as console uart and debug is enabled,
>> >> avoid gating of uart clocks to print all debug prints.
>> > :
>> > :
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 console_uart_id =3D u=
art->num;
>> >>
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cmdline_find_option=
("debug")) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_de=
bug =3D true;
>> >
>> > Shouldn't "loglevel" also be checked?
>> >
>>
>> Might not be necessary,
>>
>> loglevel only sets the option in console driver how a printk should =
be handled
>> from vprintk so any printk should be to sent to console or to syslog=
d action
>> where it will be buffered to a file(var/log/messages).
>>
>> Any print's with any log level should be handled and printed to cons=
ole.
>>
>> consider below path below path
>>
>> uart->ops
>> =A0-> runtime_get_sync
>> =A0 =A0 =A0 -> omap_device_enable
>> =A0 =A0 =A0 =A0 =A0 -> clock_enable
>>
>> All the prints in given path are dev_dbgs for which we need debug to=
 be set from
>> command line argument.
>>
>> As stated in change log any dev_dbg prints from these path can be
>> redirect to uart->ops
>> so even before our clock was enabled we got redirected back to uart =
code.
>>
>> So for dev_dbg prints from above path we need debug to be set from c=
ommand-line
>> and we can prevent uart clock gating to this scenario.
>
> Isn't passing bootargs "loglevel=3D10" same as "debug"? (init/main.c)

Yes correct, I missed that part here is the updated patch [1]
Updated change-log for debug/loglevel and checked console_loglevel
in addition to debug in bootargs.

Same is updated in the branch hosted for v7_runtime:
https://gitorious.org/runtime_3-0/runtime_3-0/commit/3775d72f1205d218eb=
423a83ed87afe4c643ef38

git://gitorious.org/runtime_3-0/runtime_3-0.git v7_rc9_uart_runtime

--
Thanks,
Govindraj.R

[1]:

=46rom 3775d72f1205d218eb423a83ed87afe4c643ef38 Mon Sep 17 00:00:00 200=
1
=46rom: Govindraj.R <govindraj.raja@ti.com>
Date: Wed, 21 Sep 2011 16:54:12 +0530
Subject: [PATCH] OMAP2+: UART: Do not gate uart clocks if used for debu=
g_prints

If OMAP UART is used as console uart and debug is enabled,
avoid gating of uart clocks to print all debug prints.

If uart clocks are gated then the debug prints from omap_device
framework or hwmod framework can cause uart to enter recursive
pm_runtime calls, which can cause a deadlock over power lock usage.

=46or example: Say, uart clocks are cut and we get a print from
omap_device_disable stating disabling uart clocks. This print
calls omap_uart driver console_write which will call runtime API
get_sync which means we enter from runtime API put context to
runtime API get context.

--> runtime put (take power lock)
    --> print disabling uart clocks
        --> call uart console write
            --> call get_sync (try to take power lock)

Also any clock enable API call from uart driver should not call any uar=
t
operation until clocks are enabled back. Like get_sync having debug pri=
nt
calling uart console write even before clocks are enabled.

So to avoid these scenarios, identify from bootargs if OMAP_UART(ttyO) =
is used
in debug mode. If so, do not set device_may_wakeup. This will prevent
pm_runtime_enable in uart driver and will avoid uart clock gating.
Debug is enabled either by adding debug word in bootarg or by setting
loglevel=3D10

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.=
c
index 5e3bbce..b3d0086 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -65,6 +65,7 @@ static LIST_HEAD(uart_list);
 static u8 num_uarts;
 static u8 console_uart_id =3D -1;
 static u8 no_console_suspend;
+static u8 uart_debug;

 #define DEFAULT_RXDMA_POLLRATE		1	/* RX DMA polling rate (us) */
 #define DEFAULT_RXDMA_BUFSIZE		4096	/* RX DMA buffer size */
@@ -310,6 +311,14 @@ static int __init omap_serial_early_init(void)
 		if (cmdline_find_option(uart_name)) {
 			console_uart_id =3D uart->num;

+			if (cmdline_find_option("debug") ||
+						console_loglevel >=3D 10) {
+				uart_debug =3D true;
+				pr_info("%s used as console in debug mode"
+						" uart%d clocks will not be"
+						" gated", uart_name, uart->num);
+			}
+
 			if (cmdline_find_option("no_console_suspend"))
 				no_console_suspend =3D true;

@@ -414,7 +423,8 @@ void __init omap_serial_init_port(struct
omap_board_data *bdata,

 	oh->dev_attr =3D uart;

-	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
+	if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
+			&& !uart_debug)
 		device_init_wakeup(&pdev->dev, true);
 }

--=20
1.7.4.1
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
