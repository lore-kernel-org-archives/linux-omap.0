From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Mon, 18 Aug 2008 18:08:29 +0300 (EEST)
Message-ID: <20080818.180829.145776296.Hiroshi.DOYU@nokia.com>
References: <20080818.163519.194678809.Hiroshi.DOYU@nokia.com>
	<EBA93F3E4CB46947A4C5275F6308CF3E03434FF2@dlee15.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48627 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbYHRPIx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 11:08:53 -0400
In-Reply-To: <EBA93F3E4CB46947A4C5275F6308CF3E03434FF2@dlee15.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vpasam@ti.com
Cc: linux-omap@vger.kernel.org, r-woodruff2@ti.com, felipe.contreras@gmail.com, siarhei.siamashka@nokia.com, x00omar@ti.com, grgupta@ti.com, h-kanigeri2@ti.com, tony@atomide.com, soni.trilok@gmail.com

Vijay, Thank you for your quick reply.

From: "ext Pasam, Vijay" <vpasam@ti.com>
Subject: RE: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Mon, 18 Aug 2008 09:28:00 -0500

> Hi Hiroshi:
> 
> > Small cleanups
> > --------------
> > There are still quite lots of trivial things, naming 
> > convention, etc. In detail, please check:
> > 
> > - Documentation/CodingStyle
> > - Documentation/SubmitChecklist
> > - Documentation/SubmittingPatches
> > 
> > This can be cleaned up along with the other changes gradually.
> 
> I would say this is #1 priority task. We did spend lot of time in
> reowrking the code to adhere to the linux kernel coding style and most
> the changes should be available. If you have any specific comments,
> please let us know and we will look into it.

The following is just an example, "CodingStyle" says,
....
		Chapter 4: Naming

C is a Spartan language, and so should your naming be.  Unlike Modula-2
and Pascal programmers, C programmers do not use cute names like
ThisVariableIsATemporaryCounter.  A C programmer would call that
variable "tmp", which is much easier to write, and not the least more
difficult to understand.

HOWEVER, while mixed-case names are frowned upon, descriptive names for
global variables are a must.  To call a global function "foo" is a
shooting offense.
......

But these are too trivial, then fix it occasionally along with other
important fixes. You can find lots of too trivial examples on like
this the above document. I won't explain one by one, though....


> > Replace home-brewed APIs by native kernel APIs
> > ----------------------------------------------
> > 
> > Most of the files under "drivers/dsp/bridge/services" and 
> > "drivers/dsp/bridge/gen" seem just to provide the almost same 
> > basic in-OS functionalities as Linux in-kernel APIs provided, 
> > like "list", "ISR", "softIRQ", "Notifier", "locking", 
> > "bitmap", "clk" and so on with some bridge specific debug 
> > tracing feature. The fundamental kernel APIs should be 
> > covered by native Linux kernel APIs.
> > 
> > In-kernel APIs(ex: PRCM) should be used, instead of direct 
> > access for registers.
> > 
> > I expect that this task would reduces the code size quite a lot.
> 
> Some of the above items are being looked at like replacing CSL, isr
> etc.. But there are no equivalent API's or functionality available in
> kernel for many of them. We should replace the API's with the avaolable
> kernel API's and the remaining need to be looked at from long term.

I think that this may be relatively an easier part. Just implementing
the same functionality by using native kernel APIs. So I guess that it
can be in short term actually.


> > Use "arch/arm/plat-omap/mmu.o" as generic mmu operations
> > ---------------------------------------------------------
> > The "dspgateway" has to be modified a little, too. IVA[1,2],  
> > C5x and Camera can use the same algorithm with this driver.
> >
> 
> I remember you mentioning gateway doesn't support OMAP3. Lot of MMU code
> is bridge is OMAP3 specific and also it uses TWL feature for dynamic
> memory mapping. I am not sure what do we gain by separating the generic
> MMU operations if gateway doesn't use MMU the same way as Bridge.

Yes, "dspgateway" won't support OMAP3 but if I remember correctly that
TWL is already in OMAP2? and also does Camera use the same mechanism
of this MMU? This may be benefit or a must, I guess..


> > Use "arch/arm/plat-omap/mailbox.o" as generic mailbox operations
> > -----------------------------------------------------------------
> > The "dspgateway" has to be modified a little, too.
> 
> Agree. This is in TI roadmap for next silicon revision. We will send out
> the design for comments once it is ready.
> 
> > Make communication "protocol" more independent
> > -----------------------------------------------
> > <TBD>
> > The communication which "shared memory" and "interrupt based mailbox"
> > provide shouldn't impose any operation policies on the above 
> > "mmu" and "mailbox" drivers.
> > 
> > 
> > Push out some components into userland
> > ---------------------------------------
> > At least, The "doff loader" should be pushed out because it 
> > reads files from in-kernel. There's already sample 
> > implementation which Trilok has done before. Need to evaluate 
> > the performance again.
> >
> > Define bridge Interfaces
> > ------------------------
> > <TBD>
> > This was already described in the following thread:
> > http://linux.omap.com/pipermail/linux-omap-open-source/2007-Ap
> ril/009540.html
> > I think that this is also tightly related to TI's roadmap, 
> > support plan and so on.....
> 
> I agree these should be looked from a longer term standpoint. As Richard
> stated earlier, providing a stable bridge version is one our top
> requirement as this is being used by several TI users.  We need to pick
> the ones that helps us most and focus efforts on them. Probably we can
> pick 1 or 2 tops items and focus on them.  Note that these changes would
> require lot of effort and potentially impact the stability of the code
> if not properly tested. For example, moving doff loader to user land
> might be easy for static loading, but supporting dynamic loading would
> need access to Node interface in the kernel. This might either require
> part of the node functionality to user mode or have context switches to
> access this from kernel mode. We need to have some protoyping done and
> performance measurements done before making the call on design.

Agreed. Need more investigation and prototype actually.

> TI is committed to contribute Bridge to the open source community. We
> will continue to work closely to evolve bridge that is beneficial to all
> the users of Bridge.

I think it would be nice if you sends bridge paches against "l-o", and
also this would be beneficial for "omapzoom", too. As for "bridge",
"omapzoom" repository just git-pull from "l-o" and it will get the
latest bridge code automatically, as is.

       Hiroshi DOYU

