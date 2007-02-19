From: Ram <vshrirama@gmail.com>
Subject: I2C Timeout error OMAP2430
Date: Mon, 19 Feb 2007 16:54:05 +0530
Message-ID: <8bf247760702190324n7a5bb94u4c31b67b5ed0c677@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
   Im using OMAP 2430. Im using OMAP2430SDP 4.0.1 and OMAP2430SDP V 2.80.
   I have ported keypad driver, TWL drivers to linux 2.6.19.

   Im getting interrupts whenever i press a key. However after 3/4 key presses.
   Im getting I2C bus time out error.

   Im using the i2c-omap.c that comes with open source linux 2.6.19.
   I have also tried with i2c-omap.c (i2c bus driver) thats there on
the latest git tree.

   I have tried Bus speeds, 2600, 400, 100.

  But i get the same error. After trying a few reads, it terminates
twl4030_irq_thread
  saying "Maximum I2C error count exceeded.  Terminating twl4030_irq_thread"



  How does one recover from such an error?. is resetting the i2c
controller the only way?.

   Has anyone faced this problem?.

  Please Advice,


  Regards,
    sriram


  Some of my debug prints are as follows:
 <7>i2c_adapter i2c-0: master_xfer[0] W, addr=0x49, len=1
 <7>i2c_adapter i2c-0: master_xfer[1] R, addr=0x49, len=1
 <4>i2c_omap i2c_omap.2: timeout waiting for bus ready
  i2c_omap i2c_omap.2: timeout waiting for bus ready

  <4>I2C error -110 while reading TWL4030 PIH ISR register.
      I2C error -110 while reading TWL4030 PIH ISR register.


   <4>I2C error -110 while reading TWL4030 PIH ISR register.
        I2C error -110 while reading TWL4030 PIH ISR register.
<3>Maximum I2C error count exceeded.  Terminating twl4030_irq_thread.
Maximum I2C error count exceeded.  Terminating twl4030_irq_thread.
