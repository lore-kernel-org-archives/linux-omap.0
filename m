From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP dts: Only build dtb if associated SoC is built
Date: Mon, 12 May 2014 09:03:04 -0700
Message-ID: <20140512160303.GI31772@atomide.com>
References: <1399162297-23527-1-git-send-email-pbrobinson@gmail.com>
 <20140506171827.GP18474@atomide.com>
 <CALeDE9PjS=zPzsUHiHLJc4Q9hYm_-49+1bRjqRO_a-r6_1LLQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50013 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752665AbaELQDI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 12:03:08 -0400
Content-Disposition: inline
In-Reply-To: <CALeDE9PjS=zPzsUHiHLJc4Q9hYm_-49+1bRjqRO_a-r6_1LLQw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Robinson <pbrobinson@gmail.com>
Cc: linux-omap@vger.kernel.org, arnd@arndb.de, robh+dt@kernel.org

* Peter Robinson <pbrobinson@gmail.com> [140509 14:28]:
> On Tue, May 6, 2014 at 6:18 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Peter Robinson <pbrobinson@gmail.com> [140503 17:12]:
> >> With ARCH_OMAP2PLUS being separated out into OMAP2/3/4/5 etc all the TI device
> >> tree blobs are built no matter the combination of SoCs that are enabled. This
> >> often causes a bunch of irrelevant .dts to be built on a multi platform kernel,
> >> this enables the building of just the ones relevant to the SoCs that are
> >> actually enabled. It also orders the dts file alphabetically.
> >
> > Sure, makes sense and grouping + sorting also helps to avoid trivial
> > merge conflicts.
> >
> > I've changed the ordering a bit as am335x is based on omap3, and
> > omap43x based on omap4. And 3517 is an omap3 with the faster
> > Ethernet and few other changes.
> 
> Makes sense.
> 
> > I'll apply the following patch into omap-for-v3.16/dt. BTW, looks
> > like you missed a Signed-off-by in your original patch.
> 
> Apologies, I was sure I added it but then I crafted the patch a couple
> of times as it's my first first upstream kernel patch so I must have
> missed it for the real one. Can I just ack it now with the below? If
> so...

No problem :) Would add it thanks..
 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

..but I had to apply it already already as I wanted to have it
applied before other patches adding things to the Makefile. Having
just my Signed-off-by should be just fine in this case as I had to
edit the patch anyways, and it's just sorting the Makefile and not
adding any new code.

Regards,

Tony
