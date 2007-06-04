From: "Amit Gupta" <amit_jobs05@inbox.com>
Subject: Re: Fwd: OMAP 2430 nand/nor booting
Date: Mon, 4 Jun 2007 23:36:38 +0530
Message-ID: <78d6ed630706041106m24955647q2269b2001191f4e6@mail.gmail.com>
References: <78d6ed630706021205t3d8885afv5129f50f4da04548@mail.gmail.com>
	<78d6ed630706030702r1480faf5j3af7f1b5b64dd9ce@mail.gmail.com>
	<4663F5F6.6030609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4663F5F6.6030609@gmail.com>
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
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello

Thanks for your reply.

But i am sure that after reset of processor with NOR settings the
reset address is not that of NOR. Its different because NOR shares its
switch settings with mDOC and some other device.

So after reset it does not executes from NOR location,so it does relocate
the
NOR code and there is an offset I suppose.

Now this is logical since my processor is sharing its switch settings with
other memory regions so my processsor wont be knowing that my image does
exists
in NOR or mDOC.

And  I dont think I need to relocate my NOR source code to this offset
location
since this should be carried out by boot ROM code.

Small Example which I carried out :-

I had writtten small LCD program which I downloaded through CSST in
NOR at addresss at location 0x04000000 and I ticked execute after download
at location 0x04000000 and the LCD got correct vaoue and hence image
executed sucessfully but
when I reset the processor, the image did not executed and the LCD did not
changed

This makes sure that even with NOR settings the PC does not jumps to NOR
strating location of 0X04000000 but rather it moves at an offset which is at
location
0x08000000 i suppose( which I saw in case of sample image)
Now in the Linux uboot and xload  code there have been some aprtial SRAM and
full SRAM configurations
happening which tells that some code executed in SRAM and part in SDRAM and
in the other case completely
in SDRAM. Do i need to do it explicitly for making the image execute after
reset but
still what is important to know is the reset address and how the boot loader
copies from NOR to that address.

With the NAND image is not at all executing, I dont understand why but I
suppose I will get the clue once I get answer to this.

Thanks & Regards

Aman


On 6/4/07, Nishanth Menon <menon.nishanth@gmail.com> wrote:
>
> Hi Amit,
> Amit Gupta stated on 6/3/2007 9:02 AM:
> > While as per my documents study, it's clear that after reset the code is
> > relocated from NOR to different location for execution . But why is
> > this not
> > happening automatically in my case.
> >
> Code relocation does not happen automatically. If ur boot code/sample
> code desires to relocate itself to SDRAM or any other location. it needs
> to be done by itself.
> > I also heard that NAND flash also has some
> > XIP region.
> The 2430 SDP has two nands: one is a 16 bit Samsung SLC NAND and other
> is a OneNAND device. The Onenand has limited XIP support, but the 16 bit
> nand is not XIP.
> > The logic is clear that NAND and (NOR image after reset) is not
> executing
> > until and unless you have copy code to relocate it to SRAM or SDRAM( if
> > SDRAM has already been initialized prior to relocation).
> >
> The code to relocate is part of your image. so it is upto your image to
> decide how it should work.
> > Kindly tell me that is my above understanding true or Boot ROM code does
> > copy some part of code because even if we have copy section within the
> > code,
> > it needs to be executed before the copy actually takes place.
> rom code behavior depends on the type of device:
> in the case of NOR: instruction execution is given straight to the NOR
> flash offset 0x0.
> in the case of NAND: a limited number of pages is copied to SRAM and
> execution commences in SRAM. note the fact of limited pages. the image
> in those initial pages should be self sustaining and should be capable
> of loading the rest of the image from nand and proceeding with
> execution.. this is the role of X-Loader - a stripped down version of
> uboot.
>
> Regards,
> Nishanth Menon
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
