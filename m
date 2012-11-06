From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 15/15] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Tue, 6 Nov 2012 12:29:05 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC04FBA@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-16-git-send-email-vaibhav.bedia@ti.com>
 <87txt4aqyc.fsf@deeprootsystems.com> <50983510.80000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48504 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943Ab2KFM3h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 07:29:37 -0500
In-Reply-To: <50983510.80000@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

Hi Santosh, Kevin

On Tue, Nov 06, 2012 at 03:22:16, Shilimkar, Santosh wrote:
[...]

> >> +
> >> +/*
> >> + * This a subset of registers defined in drivers/memory/emif.h
> >> + * Move that to include/linux/?
> >> + */
> >
> > I'd probably suggest just moving the register definitions you
> > need into <plat/emif_plat.h> so they can be shared with the driver.
> >
> > Also, the EMIF stuff would benefit greatly from using symbolic defines
> > for the values being written.  Probably having those in
> > <plat/emif_plat.h> would also help out here.
> >
> > Or, maybe the EMIF driver can provide some self-contained stubs that can
> > be copied to OCP RAM for the functionality needed here?
> >
> > Santosh, what do you think of that?
> >
> Thats what I mentioned in my comment. I also don't know why such a bad
> hardware choice was made when we have perfectly working EMIF IP across
> low power states. Even the self refresh control is managed inside
> hardware upon idle.  My guess is DDR self-refresh might be the reason
> to use OCMC RAM.
> 
> In either case, Keeping EMIF changes separate as part of EMIF 
> driver/platform code is right way to go about it. May be the
> disable_selfrefresh() might need to kept in assembly files since it 
> needs to be running from SRAM but rest need not be part of
> PM code.
> 


In the suspend path we do lot of I/O manipulations to lower final power
number which must be done after the external memory has gone into
self-refresh. So, these steps will have to be done from code in OCMC RAM. 

Other than saving the EMIF configuration the other thing that we do during
suspend from assembly is to put the PLLs in bypass. We could possibly move
the DISP PLL bypass to C code. MPU PLL is another candidate but this might
add in more delays in the suspend and abort sequence (I don't have any
delay numbers to justify this right now)

The resume path undoes the I/O manipulations and then restores the EMIF
configuration all of which I think is necessary before we can jump back to
external memory.

So, I think we'll have just the EMIF context save and possibly the PLL
bypass for DISP PLL during suspend that we can move out of assembly.

Coming to point of sharing the EMIF register definitions, with the recent
changes to move around the header files out of plat-omap, is it ok to
add in the required offsets and related bit-field definitions from
the EMIF driver to plat-omap?

Regards,
Vaibhav
