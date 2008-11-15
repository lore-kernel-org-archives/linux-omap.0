From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: DVI output support for OMAP35x EVM
Date: Sat, 15 Nov 2008 13:58:17 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E5F2B758@dbde02.ent.ti.com>
References: <dbdb2ea60811141401l1ba052d4s26b726e461c17ac5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40172 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313AbYKOI23 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Nov 2008 03:28:29 -0500
In-Reply-To: <dbdb2ea60811141401l1ba052d4s26b726e461c17ac5@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: twebb [mailto:taliaferro62@gmail.com]
> Sent: Saturday, November 15, 2008 3:31 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org Mailing List
> Subject: Re: DVI output support for OMAP35x EVM
> 
> >> The SDK 1.0.0 kernel for OMAP35x EVM from TI included DVI support
> >> (480P and 720P) in the display driver.  Is there a patch that was
> >> submitted to the l-o git that includes that support?  I'm looking
> to
> >> add DVI support into the kernel I'm currently using, which is
> >> linux-omap-2.6 (tag = v2.6.27-omap1).
> >>
> > [Hiremath, Vaibhav] The l-o version of kernel doesn't support most
> of the features supported in SDK 1.0.0. We are working towards it.
> Below is link which will help you to understand where we are heading
> -
> >
> >
> http://markmail.org/message/p3aktfdgoumeludd#query:vaibhav%20DSS%20l
> ib+page:1+mid:nzjsnawvnmtqjfwa+state:results
> >
> 
> I'm not very familiar with the video and graphics subsystems, but
> was
> just looking for code that supported output on the DVI connector.
> So
> is the RFC by Hardik Shah at this link...
> http://lists-archives.org/video4linux/23648-omap3-display-driver-
> v4l2.html
> the best description of where TI is headed?  And is code  based on
> this only available in omapzoom git?  Also, I don't see mention of
> the
> DVI support in the RFC - am I missing something?
> 
[Hiremath, Vaibhav] This RFC was the initial plan and design from TII to support all the features and functionality available with OMAPZOOM kernel version. But recently Tomi (from Nokia) came with new design and implementation which we acknowledged and started using as a baseline for DSS development.
Please refer to the below link which will take you to latest patches for DSS from Nokia -
http://markmail.org/search/?q=Tomi+Valkeinen#query:Tomi%20Valkeinen%20from%3A%22Tomi%20Valkeinen%22+page:1+state:facets

This supports DVI output on FBDEV interface.

> Thanks,
> twebb

