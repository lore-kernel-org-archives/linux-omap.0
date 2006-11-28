From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH] TWL4030 CORE (I2C chip) driver for 2430 SDP
Date: Tue, 28 Nov 2006 10:44:29 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE01FF0356@DLEE09.ent.ti.com>
References: <3a5b1be00611280744v31092e5bja999b12b391c9dff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <3a5b1be00611280744v31092e5bja999b12b391c9dff@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal.shah802003@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Komal,

Many thanks for the review. I will incorporate the suggested changes.

>> Also, can't we use menelaus chip like implementation in the current
>> -omap git tree?

For TWL the actual need was,
1) Register read/write: through I2C.
2) Interrupt handling: as TWL reads/writes are based on I2C cannot
execute from interrupt context. So we need a thread/work-item to service
the same.
3) Power Management: Voltage scaling modules, Enabling/Disabling Power
to other devices (VAUX handling) etc.

Though requirement looks similar to Menelaus, we had to change our
design to address issues related to TWL interrupt handling, I2C stack
etc.

1) Kthread is used to service interrupts.
We cannot go for a schedule_work (as in Menelaus). The simple reason is
to service many TWL interrupt sources and reduce interrupt latency. I
can explain more (if required).
2) I2C stack doesn't support High Speed, we had to add some code in I2C
core and modify client structure.=20
3) Menelaus uses i2c_smbus calls, due to above change we preferred using
i2c_transfer.
4) Power code is missing in this patch, actually we have that in a
separate file, I thought of discussing this on a separate thread.

Overall, due to many design constraints it's difficult to follow
menealus, though we still take this as a baseline.

Let me know if you need more inputs.=20

Regards,
Khasim
-----Original Message-----
From: Komal Shah [mailto:komal.shah802003@gmail.com]=20
Sent: Tuesday, November 28, 2006 9:45 AM
To: Syed Mohammed, Khasim
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: [PATCH] TWL4030 CORE (I2C chip) driver for 2430 SDP

On 11/28/06, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
> Hi,
>
> Please find the attached patch for TWL4030 core driver. The TWL4030 is
> an integrated power-management/audio CODEC device.
>
> Few important features of TWL4030 chip are as listed below
> 1. Power (step down converters, LDOs, SmarReflex compliant dynamic
> voltage management, etc).
> 2. Audio (PCM - I2S, carkit, etc)
> 3. Charger
> 4. USB (high speed transceivers OTG compliant)
> 5. LED driver, RTC module, Keypad.
>
> Features of TWL - Core driver,
> 1. Introduces API's to read and write from TWL4030 registers using I2C
> bus 2
> 2. Centralized interrupt handling mechanism,
>       (a)Supports de-muxing of TWL4030 interrupts (from different
> modules).
>       (b)Kernel threads are used to query TWL interrupt controller to
> see
>          which modules are interrupting and then call the
corresponding
>          handler
> 3. TWL4030 can work with HS I2C, I have not added the code for the
same.
> I will take this on a separate thread.
>
> The attached patch is just a preliminary version. I didn't test this
on
> board yet nor tried compiling. Please let me know if you find any
issues
> with the same, I will re-submit the patch after testing and
> incorporating review comments (if any).

Few comments then...

+/*
+ * drivers/i2c/chips/twl4030_core.c

prefer not writing the path, as directory / file path/name keeps
changing and it is hard to maintain later.

+ * HISTORY:
+ * --------
+ * 27 Nov 2006   Syed Khasim     Re-organized code for OMAP tree

This comment of "re-orgnazation" only applicable if you have some
other tree, from which you re-organized for OMAP tree. So this comment
has no meaning when you publish it.

+/*** Includes */
+#include <linux/config.h>

Yes #include means "includes" and config.h is not required now :)

/**** BitField Definitions */
+
+/* PIH_ISR_P1 Fields */
+#define BIT_PIH_ISR_P1_PIH_ISR0	(0x000)

Are we using all the bitfields in the this file? _OR_ is it just for
debugging ?

+/* ----- debug defines -----------------------------------------------
*/
+/* Debug - four macros:
+ * FN_IN, FN_OUT(value),D1,D2,D3 enabled based on log level
+ */
+
+/* Log level standard used here:
+ * Log level 3 all messages
+ * Log level 2 all entry-exit points
+ * Log level 1 major messages
+ * Log level 0 no messages
+ */
+#define TWL4030_LOG_LEVEL		0
+/* detail - 0 - no detail
+ *          1 - function name
+ *          2 - function name, line number
+ * prefix is added to every log message

I better suggest that you use internal debugging functions, dev_dbg ?
it generally gets refused by upstream maintainers.

+static void do_twl4030_irq(unsigned int irq, struct irqdesc *desc,
+			   struct pt_regs *regs);

Also remove struct pt_regs.

+	}
+	down(&(client->xfer_lock));

mutex apis?

Also, can't we use menelaus chip like implementation in the current
-omap git tree?

--=20
---Komal Shah
http://komalshah.blogspot.com
