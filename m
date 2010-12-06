From: Ionut Nicu <ionut.nicu@mindbit.ro>
Subject: Re: [PATCH v3 00/12] staging: tidspbridge: various cleanups
Date: Tue, 07 Dec 2010 00:18:47 +0200
Message-ID: <1291673927.9508.13.camel@atlantis.mindbit.ro>
References: <1290336390-2581-1-git-send-email-ionut.nicu@mindbit.ro>
	 <AANLkTi=86Xum25jOhfW_2R-WH8Z57i5taJtteXvu89XM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.mindbit.ro ([80.86.127.26]:38757 "EHLO ns.mindbit.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658Ab0LFWTE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Dec 2010 17:19:04 -0500
In-Reply-To: <AANLkTi=86Xum25jOhfW_2R-WH8Z57i5taJtteXvu89XM@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Sapiens Rene <rene.sapiens@ti.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Omar,

On Mon, 2010-12-06 at 02:59 -0600, Ramirez Luna, Omar wrote:
> Hi Ionut,
> 
> On Sun, Nov 21, 2010 at 4:46 AM, Ionut Nicu <ionut.nicu@gmail.com> wrote:
> > This set of patches replaces some of the redundant components of
> > the tidspbridge driver, such as:
> >
> > * wrapper functions for kmalloc/kfree
> > * custom bitmap implementation
> > * custom linked list implementation (list_head wrapper)
> >
> > with the standard linux kernel interfaces.
> >
> > The patches also do some code reorganization for increasing readability.
> > Most of the changes reduce the code indentation level and simplify the code.
> > No functional changes were done.
> >
> > There are many places in this driver that need this kind of cleanup, but
> > these patches only fix the functions that were touched while converting
> > the code to use linux bitmap and list_head.
> 
> Thanks for your patches, I just fixed the style of some multiline
> comments before pushing, since these are very minor fixes I avoided
> the noise of resending the patches.
> 
> Please remember to follow the Coding Style for multi line comments
> whenever you insert back those lines (even if the code was that way).
> 

Thanks for your review. It's strange scripts/checkpatch.pl didn't
complain, so that's why I must have missed them.

> >  staging: tidspbridge: rmgr/node.c code cleanup
> 
> Changes requested
> 

I'll take care of the changes you requested in the other email and
resubmit it.

> >  staging: tidspbridge: rmgr code cleanup
> 
> Doesn't apply because of patch "staging: tidspbridge: rmgr/node.c code
> cleanup" was not pushed.
> 

I'll make a 2-patch series containing this one and the one above.

Thanks,
Ionut.

