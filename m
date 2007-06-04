From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: Fwd: OMAP 2430 nand/nor booting
Date: Mon, 04 Jun 2007 06:22:30 -0500
Message-ID: <4663F5F6.6030609@gmail.com>
References: <78d6ed630706021205t3d8885afv5129f50f4da04548@mail.gmail.com>
	<78d6ed630706030702r1480faf5j3af7f1b5b64dd9ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <78d6ed630706030702r1480faf5j3af7f1b5b64dd9ce@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Amit Gupta <amit_jobs05@inbox.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Amit,
Amit Gupta stated on 6/3/2007 9:02 AM:
> While as per my documents study, it's clear that after reset the code is
> relocated from NOR to different location for execution . But why is
> this not
> happening automatically in my case.
>
Code relocation does not happen automatically. If ur boot code/sample
code desires to relocate itself to SDRAM or any other location. it needs
to be done by itself.
> I also heard that NAND flash also has some
> XIP region.
The 2430 SDP has two nands: one is a 16 bit Samsung SLC NAND and other
is a OneNAND device. The Onenand has limited XIP support, but the 16 bit
nand is not XIP.
> The logic is clear that NAND and (NOR image after reset) is not executing
> until and unless you have copy code to relocate it to SRAM or SDRAM( if
> SDRAM has already been initialized prior to relocation).
>
The code to relocate is part of your image. so it is upto your image to
decide how it should work.
> Kindly tell me that is my above understanding true or Boot ROM code does
> copy some part of code because even if we have copy section within the
> code,
> it needs to be executed before the copy actually takes place.
rom code behavior depends on the type of device:
in the case of NOR: instruction execution is given straight to the NOR
flash offset 0x0.
in the case of NAND: a limited number of pages is copied to SRAM and
execution commences in SRAM. note the fact of limited pages. the image
in those initial pages should be self sustaining and should be capable
of loading the rest of the image from nand and proceeding with
execution.. this is the role of X-Loader - a stripped down version of uboot.

Regards,
Nishanth Menon
