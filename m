From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Mon, 18 Aug 2008 11:27:01 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E0B3121EE@dlee03.ent.ti.com>
References: <20080818.163519.194678809.Hiroshi.DOYU@nokia.com>
 <EBA93F3E4CB46947A4C5275F6308CF3E03434FF2@dlee15.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33074 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921AbYHRQ1T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 12:27:19 -0400
In-Reply-To: <EBA93F3E4CB46947A4C5275F6308CF3E03434FF2@dlee15.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pasam, Vijay" <vpasam@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "siarhei.siamashka@nokia.com" <siarhei.siamashka@nokia.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "tony@atomide.com" <tony@atomide.com>, "soni.trilok@gmail.com" <soni.trilok@gmail.com>

Hi,

> Some of the above items are being looked at like replacing CSL, isr etc..
> But there are no equivalent API's or functionality available in kernel for
> many of them. We should replace the API's with the avaolable kernel API's
> and the remaining need to be looked at from long term.
>

-- I agree with Vijay. We can remove the simple wrapper functions like the ones in CSL and ISR, but some of the other modules in the services provide more functionality than just being the wrappers. We don't want to compromise on any current debugging features that are provided by these modules at the expense of replacing the services functions with direct kernel calls. This would require careful analysis.

If any one has done any analysis on the services functions that can be removed without compromising the functionality and debugging feature, please share it on the mailing list. 

On the comment to remove clk.c, I don't agree with it. I think it provides an advantage of having a clk module in the DSP Bridge as all the calls to clock module are centralized in one location, which would aid in Bridge debugging.


Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Pasam, Vijay
> Sent: Monday, August 18, 2008 9:28 AM
> To: Hiroshi DOYU; linux-omap@vger.kernel.org
> Cc: Woodruff, Richard; felipe.contreras@gmail.com;
> siarhei.siamashka@nokia.com; Ramirez Luna, Omar; Gupta, Ramesh; Kanigeri,
> Hari; tony@atomide.com; soni.trilok@gmail.com
> Subject: RE: [RFC][DRAFT] TODO list for TI DSP BRIDGE
> 
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
> reowrking the code to adhere to the linux kernel coding style and most the
> changes should be available. If you have any specific comments, please let
> us know and we will look into it.
> 
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
> Some of the above items are being looked at like replacing CSL, isr etc..
> But there are no equivalent API's or functionality available in kernel for
> many of them. We should replace the API's with the avaolable kernel API's
> and the remaining need to be looked at from long term.
> 
> 
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
> 
> >
> > Use "arch/arm/plat-omap/mailbox.o" as generic mailbox operations
> > -----------------------------------------------------------------
> > The "dspgateway" has to be modified a little, too.
> 
> Agree. This is in TI roadmap for next silicon revision. We will send out
> the design for comments once it is ready.
> 
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
> require lot of effort and potentially impact the stability of the code if
> not properly tested. For example, moving doff loader to user land might be
> easy for static loading, but supporting dynamic loading would need access
> to Node interface in the kernel. This might either require part of the
> node functionality to user mode or have context switches to access this
> from kernel mode. We need to have some protoyping done and performance
> measurements done before making the call on design.
> 
> TI is committed to contribute Bridge to the open source community. We will
> continue to work closely to evolve bridge that is beneficial to all the
> users of Bridge.
> 
> Best Regards
> Vijay
> 

