From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 02/11] ARM: OMAP: expose control.h to mach area
Date: Fri, 1 Jun 2012 04:19:39 -0700
Message-ID: <20120601111938.GL12766@atomide.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-3-git-send-email-eduardo.valentin@ti.com>
 <CAMQu2gxbkFCtkK+NCVksC82-R4SAKKtK2w=zNbrNi9a10s1t1Q@mail.gmail.com>
 <CAGF5oy_R0xKsKQoqq2ReCjEP2tWC4UcawnAkTPU35thysnSj7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50376 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab2FALTq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 07:19:46 -0400
Content-Disposition: inline
In-Reply-To: <CAGF5oy_R0xKsKQoqq2ReCjEP2tWC4UcawnAkTPU35thysnSj7g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, b-cousson@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org

* Valentin, Eduardo <eduardo.valentin@ti.com> [120528 03:34]:
> Hello,
> 
> On Mon, May 28, 2012 at 12:25 PM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
> > On Fri, May 25, 2012 at 1:55 PM, Eduardo Valentin
> > <eduardo.valentin@ti.com> wrote:
> >> This patch exposes the definitions under control.h to
> >> drivers outside the machine code.
> >>
> >> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> >> ---
> > After second thought, this complete header movement needs to avoided.
> > Drivers should not anyway include something like <mach/control.h>
> >
> > May be split the control.h header file data into ..
> > - defines used by mach-omap2/* files which can remain in "control.h"
> > in existing location.
> 
> OK..
> 
> > - common functions/defines used across drivers/*, mach-omap2/*,
> > plat-omap/*, should
> > go to include/linux/omap_control.h
> 
> Right..
> 
> > - Driver specific defines like thermal, usb etc, should go to
> > respective drivers file.
> 
> Indeed.
> 
> >
> > What do you think ?
> 
> I think we are in line. And I believe I saw a similar comment by
> Benoit in other email thread.
> 
> Having a better thinking of this, it makes sense to have the
> definition specific to drivers in the driver scope only, as they are
> going to be used only there anyway.
> 
> I will drop this patch off and update the remaining changes
> accordingly (drop the change in control.h for thermal specific and
> move it to omap_bandgap.h).

Yes good, we should not expose these to the other drivers, that will
lead into misuse of these defines from various other drivers that we
may not notice until it's too late.

Regards,

Tony
