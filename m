From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/PATCH 3/3] omap3-iommu: remote registration
Date: Mon, 18 May 2009 14:02:33 +0100
Message-ID: <20090518130233.GD3067@n2100.arm.linux.org.uk>
References: <1242468350-23190-1-git-send-email-felipe.contreras@gmail.com> <1242468350-23190-2-git-send-email-felipe.contreras@gmail.com> <1242468350-23190-3-git-send-email-felipe.contreras@gmail.com> <1242468350-23190-4-git-send-email-felipe.contreras@gmail.com> <20090518121113.GB3067@n2100.arm.linux.org.uk> <94a0d4530905180546p47c887afj109b3b60cdd24a00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56382 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbZERNCp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 09:02:45 -0400
Content-Disposition: inline
In-Reply-To: <94a0d4530905180546p47c887afj109b3b60cdd24a00@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk

On Mon, May 18, 2009 at 03:46:07PM +0300, Felipe Contreras wrote:
> On Mon, May 18, 2009 at 3:11 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > The real problem here seems to be the TI DSP bridge code, and if th=
at's
> > the case why can't we just avoid registering IVA2 if the TI DSP bri=
dge
> > code is enabled. =A0That solves your stated problem without creatin=
g
> > additional management issues.
>=20
> The bridgedriver is expected to move and use iommu eventually, but no=
t
> right now, so I guess the iva2 device should be registered only if
> MPU_BRIDGE_IOMMU is defined.
>=20
> But then what's the point of having the isp iommu device if the camer=
a
> driver is disabled? Wouldn't that be wasting resources? Then if CAMER=
A
> is not defined the isp device should not be registered either.

So have something like:

config OMAP_IOMMU
	tristate

and then have both MPU_BRIDGE_IOMMU and the camera support (and whateve=
r
else) select it.  That way, you only end up with the IOMMU support code
built into the kernel if you have users of it.

These low-level internal services drivers really don't need to be
publically visible in the configuration system.

As for the run-time size, that's truely minimal.

> And finally if none of the two are enabled then you don't really
> iommu. By having omap_iommu_add all the dependencies would be handled
> automatically, right? 'modprobe bridgedriver' would load iommu.

Think about it - the dependencies _already_ have to be there to use
the iommu services.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
