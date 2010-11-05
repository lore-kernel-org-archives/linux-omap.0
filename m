From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2 00/12] staging: tidspbridge: various cleanups
Date: Fri, 5 Nov 2010 08:43:46 -0700
Message-ID: <20101105154346.GB27991@kroah.com>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:42780 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753Ab0KEPw4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Nov 2010 11:52:56 -0400
Content-Disposition: inline
In-Reply-To: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@gmail.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sapiens Rene <rene.sapiens@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

On Fri, Nov 05, 2010 at 05:13:04PM +0200, Ionut Nicu wrote:
> This set of patches replaces some of the redundant components of
> the tidspbridge driver, such as:
> 
> * wrapper functions for kmalloc/kfree
> * custom bitmap implementation
> * custom linked list implementation (list_head wrapper)
> 
> with the standard linux kernel interfaces.
> 
> The patches also do some code reorganization for increasing readability.
> Most of the changes reduce the code indentation level and simplify the code.
> No functional changes were done.
> 
> There are many places in this driver that need this kind of cleanup, but
> these patches only fix the functions that were touched while converting
> the code to use linux bitmap and list_head.

This is for .38, right?

thanks,

greg k-h
