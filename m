From: "Li Weichen" <iaadoa@gmail.com>
Subject: RE: Basic question: how to flash omap system with ccs?
Date: Fri, 2 Dec 2005 09:36:17 +0800
Message-ID: <438fa51b.56e049f5.60f0.ffffe5d2@mx.gmail.com>
References: <C51F43ABFC95844490F0529B60753BF402B6B8D9@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <C51F43ABFC95844490F0529B60753BF402B6B8D9@dlee02.ent.ti.com>
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

Hi Jon,

I have tried your instructions in CCS3.1, but it seems that there is
something wrong.  When I use "Load Program..." command to load the file, I
usually get some error messages like "Data verification failed at address
0x10000000.Please verify target memory and memory map." and if I ignore this
and proceed to run, it seems that the u-boot is not flashed into the flash.
Does it mean that I still need a flash programmer as Olav said with CCS
loading the elf file?

p.s. I find that the CCS does not work steady and usually give me some
address error message.  What may the problem be?

Thanks again.

Regards,
Li Weichen

> -----Original Message-----
> From: Hunter, Jon [mailto:jon-hunter@ti.com]
> Sent: Thursday, December 01, 2005 10:02 PM
> To: Li Weichen
> Subject: RE: Basic question: how to flash omap system with ccs?
> 
> Hi Li,
> 
> The "Load Program..." is the correct method. However, you must have CCS
> v3.x. Earlier versions of CCS does not support ELF loading.
> 
> If possible, please post your questions to the linux-omap list and I
> will try to answer questions when I can.
> 
> Regards,
> Jon
> 
> 
> 
> > -----Original Message-----
> > From: Li Weichen [mailto:iaadoa@gmail.com]
> > Sent: Wednesday, November 30, 2005 7:47 PM
> > To: Hunter, Jon
> > Subject: RE: Basic question: how to flash omap system with ccs?
> >
> > Then how to download the elf file?  I have tried the "load
> > program" command but got a lot of error messages.  What
> > command should I use?
> >
> > Regards,
> > Li Weichen
> >
> > > -----Original Message-----
> > > From: Hunter, Jon [mailto:jon-hunter@ti.com]
> > > Sent: Thursday, December 01, 2005 1:51 AM
> > > To: Li Weichen
> > > Subject: RE: Basic question: how to flash omap system with ccs?
> > >
> > > Hi Li,
> > >
> > > The "u-boot" file is the ELF file. If you open this file
> > with a test
> > > editor you will see that it has the letters "ELF" as part
> > of the header.
> > >
> > >
> > > Regards,
> > > Jon
> > >
> > >
> > > > -----Original Message-----
> > > > From: Li Weichen [mailto:iaadoa@gmail.com]
> > > > Sent: Wednesday, November 30, 2005 11:31 AM
> > > > To: Hunter, Jon
> > > > Subject: RE: Basic question: how to flash omap system with ccs?
> > > >
> > > > Hi Jon,
> > > >
> > > > Firstly I'd like to thank you for your so quick reply.
> > > >
> > > > I didn't find the ELF file after compiling u-boot.  I got u-boot,
> > > > u-boot.bin, u-boot.map and u-boot.srec.  Where can I find the ELF
> > > > file?
> > > >
> > > > And if I finally got the ELF file, how to download it
> > using CCS?  I
> > > > am sorry but I am so unfamiliar with this software that I
> > can't find
> > > > the command to download the ELF file.
> > > >
> > > > Thanks again and still waiting for your reply.
> > > >
> > > >
> > > > Regards,
> > > >
> > > > Li Weichen
> > > > 2005-12-1
> > > >
> > > > > -----Original Message-----
> > > > > From: Hunter, Jon [mailto:jon-hunter@ti.com]
> > > > > Sent: Thursday, December 01, 2005 1:16 AM
> > > > > To: Li Weichen
> > > > > Subject: RE: Basic question: how to flash omap system with ccs?
> > > > >
> > > > > Hi Li,
> > > > >
> > > > > Unfortunately, there is no easy way to do this unless you
> > > > create a CCS
> > > > > project for uboot. I have tried in the past but this is not
> > > > trivial to
> > > > > do. However, the good news is that you really do not need
> > > > to do this.
> > > > > If you compile uboot with the gcc tools on a linux
> > machine it will
> > > > > generate an ELF formated file of the uboot executable and
> > > > CCS can be
> > > > > used to download this ELF file. Let me know if I am missing
> > > > something.
> > > > >
> > > > > Regards,
> > > > > Jon
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Li Weichen [mailto:iaadoa@gmail.com]
> > > > > > Sent: Wednesday, November 30, 2005 10:50 AM
> > > > > > To: Hunter, Jon
> > > > > > Subject: RE: Basic question: how to flash omap system
> > with ccs?
> > > > > >
> > > > > > Hi Jon,
> > > > > >
> > > > > > I can flash the factory osk5912 u-boot now, but what what
> > > > can I do
> > > > > > to generate my own u-boot.out?  I need to compile a
> > u-boot for
> > > > > > my custom board other than osk.  Could you please be so kind
> > > > to offer
> > > > > > me more information?
> > > > > >
> > > > > > Regars,
> > > > > > Li Weichen
> > > > > > 2005-12-1
> > > > > > > The flash device is connected to CS3 on the device which by
> > > > > > default is
> > > > > > > actually mapped to address 0x0c000000. The internal
> > boot-rom
> > > > > > > on the device is mapped to address 0x0. When the
> > device starts
> > > > > > > up
> > > > > > it always
> > > > > > > starts running code from the internal boot-rom.
> > However, one
> > > > > > > of the first things the boot-rom does is read gpio13. If
> > > > > > > gpio13 is
> > > > > > pulled low
> > > > > > > (JP3 in position 2-3) then the boot-rom will jump to CS3
> > > > > > and execute
> > > > > > > whatever is in the flash device when the device starts up.
> > > > > > >
> > > > > > > Did you have jumper JP3 in position 1-2 when you
> > > > downloaded u-boot
> > > > > > > with CCS?
> > > > > > >
> > > > > > > If you do, can you read address 0xfffecc0c on the
> > > > device using CCS.
> > > > > > > This is the address of the EMIFS_CONFIG register. Bit 1 in
> > > > > > > this register allows you to swap the physical mapping of CS0
> > > > and CS3.
> > > > > > > If bit 1 is 0 then CS0 is mapped to address 0x0 and CS3
> > > > is mapped
> > > > > > > to address 0x0c000000. Otherwise, if this bit is 1 then, CS0
> > > > > > is mapped to
> > > > > > > address 0x0c000000 and CS3 is mapped to address 0x0. If
> > > > > > this is set to
> > > > > > > 1 then you could manually try clearing this bit before you
> > > > > > > download and run u-boot.
> > > > > >
> > > > > >
> > > >
> > > >
> >
> >
