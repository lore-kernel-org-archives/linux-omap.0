From: "sandeep prabhu" <sandeep.mitian@gmail.com>
Subject: HS USB gadget support on 2430 SDP
Date: Fri, 12 Oct 2007 14:22:02 +0530
Message-ID: <c04186510710120152x57f18b1ek587eec27b15d3e33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Could anyone able to bring-up the High Speed USB File backup storage gadget
using ISP1504 tranceiver,
on 2.6.19 kernel on OMAP2430 SDP ?

HS USB gadgets  are working in 2.6.14 V4 kernel. I am trying to port the
same to 2.6.19 kernel and  running  into some issues with power managment.

2.6.19 kernel we are using does not support PM. I have disabled all PM
features and
suspend/resume  functions and trying to test the USB gadget.
When I load the gadget driver, I am getting following Error messages

musb_stage0_irq 308: <== Power=f0, DevCtl=80, bIntrUSB=0x80
musb_stage0_irq 452: OTG STATE: B_idle
musb_stage0_irq 454: OTG STATE: A_idle
musb_stage0_irq 495: VBUS_ERROR in b_idle (81, <SessEnd), retry #1, port1
00000100

1. could anyone give me some pointers on what would be happening ?
2. Is Power Management, suspend/resume support is necessary for MUSB to work
?


Thanks In Advance,
Sandeep







-- 
Warm Regards,
Sandeep
