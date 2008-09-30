From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP34xx vs OMAP 35xx
Date: Tue, 30 Sep 2008 09:29:59 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403DBFE664C@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301AFED5DFA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51946 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbYI3EAT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 00:00:19 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301AFED5DFA@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, twebb <taliaferro62@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>



Thanks,
Vaibhav Hiremath
Senior Software Engg.
Platform Support Products
Texas Instruments Inc
Ph: +91-80-25099927

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi,
> Sanjeev
> Sent: Monday, September 29, 2008 8:43 PM
> To: twebb
> Cc: linux-omap@vger.kernel.org Mailing List
> Subject: RE: OMAP34xx vs OMAP 35xx
> 
> > -----Original Message-----
> > From: twebb [mailto:taliaferro62@gmail.com]
> > Sent: Monday, September 29, 2008 7:22 PM
> > To: Premi, Sanjeev
> > Cc: linux-omap@vger.kernel.org Mailing List
> > Subject: Re: OMAP34xx vs OMAP 35xx
> >
> > >
> > > The "3" in OMAP3 stands for 3rd generation of OMAP devices
> > - both OMAP34x and OMAP35x.
> > >
> > > Besides the silicon technology differences (and minor
> > pin-outs) there are varied number of changes between these
> > processor families. One key difference is that OMAP35x family
> > comprises of OMAP3503 (ARM only device), OMAP3515 (ARM +
> > Graphics), OMAP3525 (ARM + C64x+ based IVA) and OMAP3530 (ARM
> > + Graphics + IVA). OMAP3430 will be more closer to OMAP3530.
> > > See
> > http://focus.ti.com/general/docs/gencontent.tsp?contentId=4672
> 5 for more details.
> > >
> > > As for OMAP3430SDP and OMAP3EVM, the differences are many.
> > They use cases for both these boards were quite different. It
> > translates to form-factor, on-board peripherals, ...
> > >
> >
> > Thanks for the response.  I understand the makeup of the
> > various OMAP35xx processors.  I guess my confusion centers
> > around specific support for the OMAP35x EVM platform.  I have
> > that platform, running the SDK v1.0.0 (from TI).  However, I
> > downloaded the 2.6.26
> > (tag=v2.6.26-omap2) kernel from the l-o git and had several
> > issues: a) omap3_evm_defconfig needed modifications to add
> > appropriate mtd support; b) no output on LCD.  Any ideas on
> > the display issue?
> 

As far as output on LCD is concern, the frame buffer driver is selected by default. To get the logo on LCD screen you have to enable the option 

CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_LOGO=y

Rest of the things will get set by default. Tag v2.6.26-omap2 has some issues with LCD color, to fix this use following patch

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg04955.html


> Yes. There are many changes 'overall' required to get OMAP35x working at this label. We have spend
> last few weeks fixing these issues. Patches will be coming soon on this list...
> 
> > (Perhaps I should submit this to the list under a new subject.)
> >
> > Does the linux-omap git support the OMAP35x EVM as a
> > platform?  I've gotten previous feedback from a few folks who
> > say omapzoom.git is the better place to start, but others say
> > that linux-omap.git is the better place.  Since neither works
> > straight out of the git it's difficult for me to judge which
> > is further along in it's support of 35x EVM.
> 
> I don't believe there would be many differences in the OMAP3EVM support on either trees. For SDP
> support omapzoom would be ahead in the curve.
> 
> >
> > Thanks,
> > twebb
> >
> > --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

