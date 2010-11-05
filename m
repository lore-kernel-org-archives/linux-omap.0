From: Ionut Nicu <ionut.nicu@mindbit.ro>
Subject: Re: [PATCH v2 00/12] staging: tidspbridge: various cleanups
Date: Fri, 05 Nov 2010 18:02:37 +0200
Message-ID: <1288972957.9931.9.camel@atlantis.mindbit.ro>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
	 <20101105154346.GB27991@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.mindbit.ro ([80.86.127.26]:40108 "EHLO ns.mindbit.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551Ab0KEQCq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Nov 2010 12:02:46 -0400
In-Reply-To: <20101105154346.GB27991@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Ionut Nicu <ionut.nicu@gmail.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sapiens Rene <rene.sapiens@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi,

On Fri, 2010-11-05 at 08:43 -0700, Greg KH wrote:
> On Fri, Nov 05, 2010 at 05:13:04PM +0200, Ionut Nicu wrote:
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
> This is for .38, right?
> 

Yes, the diff stat is quite big, so if they pass code review, they
should be considered for .38.

Thanks,
Ionut


