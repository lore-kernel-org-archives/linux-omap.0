From: Stefano Babic <stefano.babic@babic.homelinux.org>
Subject: 1710 and USB Host
Date: Tue, 29 Aug 2006 16:03:21 +0200
Message-ID: <200608291603.21123.stefano.babic@babic.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

sometimes ago someone has already reported troubles to get USB Host working on 
OMAP 1710. I have now on a custom board the same problem and the same error 
messages that were previously reported:

ohci ohci: OMAP OHCI
ohci ohci: new USB bus registered, assigned bus number 1
ohci ohci: irq 38, io mem 0xfffba000
ohci ohci: init err (00000000 0000)
ohci ohci: can't start
ohci ohci: startup error -75
ohci ohci: USB bus 1 deregistered
ohci: probe of ohci failed with error -75

I have seen that the ohci-omap module cannot access the USB registers. A dump 
of all registers reports only zeros.

After some investigation I have found a couple of problems in the function 
otg_init (arch/arm/plat-omap/usb.c). At the start of the function it is still 
possible to access the registers, at the end even the revision register 
(0xFFFBA000) is zero. And this is not possible...

I found that the behavior is related to the values of two registers 
OTG_SYSCON_1 and OTG_SYSCON_2. 
In OTG_SYSCON_2 the bit UHOST_EN is set to zero and this disables the Host 
controller. The behavior of the processor seems correct because according to 
the manual it is not possible to access the USB memory area if UHOST_EN is 
disabled.

A second problem is related to OTG_SYSCON_1. In this register the bit 
OTG_IDLE_EN is set and this produces the same effect disallowing memory 
accesses.

I changed the two registers setting UHOST_EN and disabling OTG_IDLE_EN and now 
it is working. A USB stick is detected by the controller and I can read the 
filesystem, so it seems this is the solution.

Has someone seen the same problems ? In this case, how do you fixed the 
problem ? Do you agree with my conclusions ?

It seems this is a problem related only to the OMAP 1710 and not affecting 
other processors, or it didn't ever worked before. 

Thanks,
stefano

-- 
stefano <stefano.babic@babic.homelinux.org>
GPG Key: 0x55814DDE 
Fingerprint 4E85 2A66 4CBA 497A 2A7B D3BF 5973 F216 5581 4DDE
