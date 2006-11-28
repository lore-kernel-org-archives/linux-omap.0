From: "Komal Shah" <komal.shah802003@gmail.com>
Subject: Re: [PATCH] TWL4030 CORE (I2C chip) driver for 2430 SDP
Date: Tue, 28 Nov 2006 17:44:52 +0200
Message-ID: <3a5b1be00611280744v31092e5bja999b12b391c9dff@mail.gmail.com>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE01F7EDC9@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE01F7EDC9@DLEE09.ent.ti.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

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
>          which modules are interrupting and then call the corresponding
>          handler
> 3. TWL4030 can work with HS I2C, I have not added the code for the same.
> I will take this on a separate thread.
>
> The attached patch is just a preliminary version. I didn't test this on
> board yet nor tried compiling. Please let me know if you find any issues
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

Are we using all the bitfields in the this file? _OR_ is it just for debugging ?

+/* ----- debug defines ----------------------------------------------- */
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

-- 
---Komal Shah
http://komalshah.blogspot.com
