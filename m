From: Sebastien Jan <s-jan@ti.com>
Subject: Re: [RFC PATCH 0/9] MIPI HSI device support for OMAP platforms
Date: Fri, 30 Oct 2009 16:32:06 +0200
Message-ID: <200910301532.07042.s-jan@ti.com>
References: <1256896808-20152-1-git-send-email-s-jan@ti.com> <20091030125750.GL31472@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34201 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932128AbZJ3Oay (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Oct 2009 10:30:54 -0400
In-Reply-To: <20091030125750.GL31472@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 30 October 2009 13:57:50 Felipe Balbi wrote:
> On Fri, Oct 30, 2009 at 10:59:59AM +0100, ext Sebastien Jan wrote:
> > This is an RFC for a series of patch to add the support of MIPI HSI and
> > SSI devices to OMAP platforms.
> > The patch includes the HSI device driver and the device files for MIPI
> > HSI and SSI.
> >
> > The driver is made of 2 distinct modules:
> >  - omap_hsi: is the Low-Level Driver (or hardware driver). It provides a
> >    kernel functional interface, to be used by other kernel modules and
> >    abstracts the HW.
> >    This part of the patch is based on Nokia SSI driver, already submitted
> > as RFC by Carlos Chinea [1].
> >  - hsi-char: is a char device driver proposing a user-space interface for
> >    using the HSI and relies on omap_hsi.
> >    This part of the patch is based on a development from Andras Domokos.
> > The intent is to propose a single HSI driver that can support MIPI HSI
> > 1.1 as well as previous implementations (SSI) for OMAP platforms (OMAP3 /
> > OMAP4).
> >
> > The driver core functionalities are there and ready for review. The
> > following updates will come in the following weeks / months:
> >  - Clocks and Power Management support for OMAP4 platform (HSI device
> > file) - HSI-char interface documentation
> >
> > Validation: The driver is validated on 3430 SDP (with a HW loopback on
> > the SSI device), and is being validated on 4430 Virtio platform (MIPI HSI
> > device).
> >
> > [1] http://lwn.net/Articles/301918/
>
> pass all your drivers on checkpatch.pl --strict and to sparse as well.

Thanks to point this out: I forgot to mention that I did run checkpatch.pl -- 
strict and sparse on these patches.

