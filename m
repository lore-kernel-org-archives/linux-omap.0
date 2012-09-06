From: Tim Nordell <tim.nordell@logicpd.com>
Subject: Resume crash: MUSB interrupt routine interactions with omap2430_musb_set_vbus()
Date: Thu, 06 Sep 2012 08:35:47 -0500
Message-ID: <5048A6B3.8030503@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34896 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753364Ab2IFNgL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Sep 2012 09:36:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1T9cFd-0005q6-LZ
	for linux-omap@vger.kernel.org; Thu, 06 Sep 2012 15:36:09 +0200
Received: from 66-162-60-14.static.twtelecom.net ([66.162.60.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 15:36:09 +0200
Received: from tim.nordell by 66-162-60-14.static.twtelecom.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 15:36:09 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

All -

We've been doing some suspend/resume testing and found that on occasion 
(on the order of 1 in 5000 cycles) the system would lock up.  The 
problem was traced into the MUSB subsystem.  Specifically, the interrupt 
requested inside musb_core.c is of the non-threaded type (e.g. it runs 
in the interrupt context).

...
         /* attach to the IRQ */
         if (request_irq(nIrq, musb->isr, 0, dev_name(dev), musb)) {
                 dev_err(dev, "request_irq %d failed!\n", nIrq);
                 status = -ENODEV;
                 goto fail3;
         }
...

Later inside the interrupt context of the routine musb_stage0_irq() it 
has the following call:

...
         /* see manual for the order of the tests */
         if (int_usb & MUSB_INTR_SESSREQ) {
...
                 musb_platform_set_vbus(musb, 1);
...
         }
...

which in turn calls

static void omap2430_musb_set_vbus(struct musb *musb, int is_on)
{
         struct usb_otg  *otg = musb->xceiv->otg;
         u8              devctl;
         unsigned long timeout = jiffies + msecs_to_jiffies(1000);
...
                         while (musb_readb(musb->mregs, MUSB_DEVCTL) & 
0x80) {

                                 cpu_relax();

                                 if (time_after(jiffies, timeout)) {
                                         dev_err(musb->controller,
                                         "configured as A device timeout");
                                         ret = -EINVAL;
                                         break;
                                 }
                         }
...

When the system is getting into that routine, it's a superfluous event. 
  E.g. there wasn't actually anything that should have triggered the 
interrupt (nothing is plugged into the USB port).  If the timeout were 
functional, it would have eventually timed out but jiffies are not 
incrementing in the given context.  Additionally, 1 second is a _long_ 
time to wait in an interrupt routine that is not threaded.

So the question becomes to those familiar with the subsystem:  What is 
the proper fix?  Before the patch that introduced the jiffy timeout 
(594632efbb usb: musb: Adding musb support for OMAP4430 - author Hema HK 
<hemahk@ti.com>), it seemed okay for the routine in question to not have 
a 1 second timeout in an interrupt context.

- Tim

