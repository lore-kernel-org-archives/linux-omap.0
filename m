From: "Li Weichen" <iaadoa@gmail.com>
Subject: RE: Basic question: how to flash omap system with ccs?
Date: Tue, 29 Nov 2005 11:07:03 +0800
Message-ID: <438bc5e0.2e7c37f8.74cb.7992@mx.gmail.com>
References: <C51F43ABFC95844490F0529B60753BF402A3AF75@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <C51F43ABFC95844490F0529B60753BF402A3AF75@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "'Hunter, Jon'" <jon-hunter@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thank you Jon, but I cannot follow the steps.

At first when I ran the "Setup CC Studio v3.1" I couldn't choose the factory
board osk5912.  If I choose it, there will be a popup says "One or more
resource is invalid. Check that device drivers actually exist. You may have
to remove bad resource to exit setup."  So I can only choose omap1610 via
xds560 emulator and selected the osk5912.gel in properties.  It seems that
CCS has connected to the board.  I loaded the file
restore/uboot/osk5912-uboot-1.1.1.out on the OSK5912 CD-ROM and pressed
"Run".  But I got the following errors:

FlashWriter Version 1.7a
Starting Download to NOR Flash
Image is 89464 bytes long
Reading Image from: 10010000
Writing Image to:  0C000000
No Flash devices have been found

I am quite confused why it tried to write image to 0c00000?  Does the flash
address start from 00000000?

p.s. Just now I downloaded the up-to-date OSK driver from SD, and after the
setup, the osk5912 can be selected in CCS but still have this address
errors.

Could you help me more?

Thanks and best regards!


Li Weichen
2005-11-29
> -----Original Message-----
> From: Hunter, Jon [mailto:jon-hunter@ti.com]
> Sent: Monday, November 28, 2005 11:45 PM
> To: Li Weichen
> Subject: RE: Basic question: how to flash omap system with ccs?
> 
> Hi Weichen,
> 
> >
> > Thank you for your reply.  But I cannot find how to download
> > a file to the board in CCS since I am quite unfamiliar with
> > this software.  Could you please be so kind to show me?
> >
> 
> From your previous emails my understanding is that you are using the TI
> PCI card XDS560 emulator. Exactly how far have you got with the
> emulator? Have you been able to setup CCS and connect to the device?
> 
> If you have gotten this far, then see "step 1: restoring uboot" on the
> below webpage. This will talk you through restoring uboot with CCS.
> Please note that although you don't have a Spectrum Digital emulator
> these steps are still valid.
> 
> http://omap.spectrumdigital.com/osk5912/factoryconfig/
> 
> 
> Hope this helps.
> 
> Regards,
> Jon
