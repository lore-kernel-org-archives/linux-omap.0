From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 00/32] Convert ARM to generic irq subsystem
Date: Fri, 28 Apr 2006 16:17:22 -0700
Message-ID: <4452A282.4050909@mvista.com>
References: <20060407095850.690110000@localhost.localdomain>	
	<20060426230543.GA28908@flint.arm.linux.org.uk>	
	<44529239.2060409@mvista.com>
	<1146263927.1322.640.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1146263927.1322.640.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: tglx@linutronix.de
Cc: linux-omap-open-source@linux.omap.com, LAK <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

Thomas Gleixner wrote:
> On Fri, 2006-04-28 at 15:07 -0700, Kevin Hilman wrote:
>> R am testing these on OMAP.
>>
>> First pass shows that smc91x interrupts are getting lost.  They are GPIO 
>> interrupts on most OMAP platforms and pass through a chained gpio handler.  I'm 
>> still investigating, but I'm guessing it as something to do with SA_TRIGGER_* 
>> flags used in the smc91x driver for OMAP.
>>
>> I don't see handling of SA_TRIGGER_* in the generic layer.  Is there a new way 
>> of handling these?
> 
> No. That chunk got lost unfortunately. Can you retry with the new patch
> against -rc3 please ?
> 
> http://www.tglx.de/projects/armirq/2.6.17-rc3/patch-2.6.17-rc3-armirq1.patches.tar.bz2
> 

ok, I tried with -rc3 and I still dont see any GPIO interrupts.

After looking closer at the IRQ_TYPE_* flags, I noticed that they didn't match 
the SA_TRIGGER_* flags for _FALLING or _RISING.  The following patch swaps the 
two and make OMAP happy.  It's now booting, and things seem sane.  Will do some 
more intensive testing

Kevin



Index: linux-omap-2.6/include/linux/irq.h
===================================================================
--- linux-omap-2.6.orig/include/linux/irq.h
+++ linux-omap-2.6/include/linux/irq.h
@@ -39,8 +39,8 @@
   * IRQ types, see also include/linux/interrupt.h
   */
  #define IRQ_TYPE_NONE		0x0000		/* Default, unspecified type */
-#define IRQ_TYPE_EDGE_FALLING	0x0001		/* Edge falling type */
-#define IRQ_TYPE_EDGE_RISING	0x0002		/* Edge rising type */
+#define IRQ_TYPE_EDGE_RISING	0x0001		/* Edge rising type */
+#define IRQ_TYPE_EDGE_FALLING	0x0002		/* Edge falling type */
  #define IRQ_TYPE_EDGE_BOTH (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING)
  #define IRQ_TYPE_LEVEL_HIGH	0x0004		/* Level high type */
  #define IRQ_TYPE_LEVEL_LOW	0x0008		/* Level low type */
