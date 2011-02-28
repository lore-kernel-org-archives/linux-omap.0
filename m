From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v10 05/18] OMAP2,3 DSS2 Change driver name to
	omap_display
Date: Mon, 28 Feb 2011 12:13:21 +0000
Message-ID: <20110228121321.GB30781@n2100.arm.linux.org.uk>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com> <1295850125-21405-6-git-send-email-sumit.semwal@ti.com> <1298539643.16119.54.camel@deskari> <1298876015.2096.36.camel@deskari> <4D6B4A1A.9000304@ti.com> <1298877549.2096.47.camel@deskari> <4D6B88BB.5010200@ti.com> <1298895026.9809.27.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37543 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829Ab1B1MNg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 07:13:36 -0500
Content-Disposition: inline
In-Reply-To: <1298895026.9809.27.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Taneja, Archit" <archit@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Feb 28, 2011 at 02:10:26PM +0200, Tomi Valkeinen wrote:
> On Mon, 2011-02-28 at 05:36 -0600, Cousson, Benoit wrote:
> > Cannot you use a device hierarchy then to do that?
> >   omap_dss/core
> >   omap_dss/dsi
> >   omap_dss/venc
> > 
> > This is moreover the way the HW is done.
> 
> Hmm, how would that work? The devices are platform devices, and they
> have a unique global name, which is used to match the driver for the
> device.

And not forgetting that '/' is not permitted in device or driver names.
