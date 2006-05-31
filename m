From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: OMAP5912 touchscreen irq not working
Date: Wed, 31 May 2006 17:44:12 +0200
Message-ID: <447DB9CC.2070808@gmail.com>
References: <4477F2BA.3080907@gmail.com>
	<200605270851.22051.david-b@pacbell.net>
	<1148760653.7041.19.camel@mammoth.research.nokia.com>
	<200605271514.53896.david-b@pacbell.net>
	<44793CF9.2050101@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <44793CF9.2050101@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Imre Deak <imre.deak@nokia.com>, ext David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

 >Imre Deak wrote:
>> ext David Brownell wrote:
>>Unlikely; it worked before, why would it stop working suddenly?
>>Including with the previous SPI clock... it's some other change
>>causing the breakage.
> 
> Yes, if it worked before with the wrong clock it's probably something else.

Had a look to it and added some debug printks to ads7846.c. 
One in ads7846_irq() and two in ads7846_rx(). There, one 
before check if samples to be thrown away, one behind (see 
below).

Looking at ads7846_irq(), while initalization, I get 
"ads7846 spi2.0: touchscreen + hwmon, irq 164"

With this irq, I only get two outputs of "ads_irq". The 
first directly while initialization (without touching the 
screen), the second at first screen touch. Then nothing, 
regardless how often I touch the screen again. This is 
reflected by /proc/interrupts as well: 164: 2   spi2.0. I 
think it's wrong to get ads7846_irq() called already while 
init without screen touched? And then this irq seems to be 
locked after first touch.

Looking at ads7846_rx, I permanently get "ads7846_rx 
called". But never "ads7846_rx valid sample". Is it correct 
to call ads7846_rx permanently? Shouldn't ads7846_rx() be 
called only while pen is down?

Please correct me if I'm wrong here, but with irq called at 
init without screen touched, then after one touch locked, 
and permanently called ads7846_rx() throwing away all 
samples, it seems to me that there is anything basically 
wrong with this new code? At least on OSK with mistral.

Best regards

Dirk

--- ./drivers/input/touchscreen/ads7846.c_orig  2006-05-31 
16:57:46.000000000 +0200
+++ ./drivers/input/touchscreen/ads7846.c       2006-05-31 
17:23:52.000000000 +0200
@@ -410,6 +410,8 @@ static void ads7846_rx(void *ads)
         } else
                 Rt = 0;

+               printk("### ads7846_rx called\n");
+
         /* Sample found inconsistent by debouncing or 
pressure is beyond
         * the maximum. Don't report it to user space, 
repeat at least
         * once more the measurement */
@@ -418,6 +420,8 @@ static void ads7846_rx(void *ads)
                 return;
         }

+       printk("### ads7846_rx valid sample\n");
+
         /* NOTE:  "pendown" is inferred from pressure; we 
don't rely on
          * being able to check nPENIRQ status, or 
"friendly" trigger modes
          * (both-edges is much better than just-falling or 
low-level).
@@ -543,6 +547,8 @@ static irqreturn_t ads7846_irq(int irq,
         struct ads7846 *ts = handle;
         unsigned long flags;

+       printk("ads_irq\n");
+
         spin_lock_irqsave(&ts->lock, flags);
         if (likely(ts->get_pendown_state())) {
                 if (!ts->irq_disabled) {
