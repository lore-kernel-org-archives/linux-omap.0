From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 2/5] ARM: OMAP: omap_device: add a method to set iommu
 private archdata
Date: Tue, 4 Oct 2011 21:54:44 +0200
Message-ID: <CAK=WgbYaEPBUz_J11+f+W+G9uUG3E6aQ-5=X9bj2nRhij-w-Sw@mail.gmail.com>
References: <1316948337-7924-1-git-send-email-ohad@wizery.com>
 <1316948337-7924-3-git-send-email-ohad@wizery.com> <87sjni9aql.fsf@ti.com>
 <CAK=WgbZhz8LcAYZEY3qqRkX4E_wtspWp09Eq9G=5VdpoMMF1FQ@mail.gmail.com> <87botwk4gw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87botwk4gw.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Cousson Benoit <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 4, 2011 at 8:15 PM, Kevin Hilman <khilman@ti.com> wrote:
> The approach is OK with me, but I'm a bit torn about whether or not to
> merge this since the need for this should go away when converting to DT.

I guess it will still take some time until our boards are fully
functional with DT, so I think we should regard this as an interim
solution. Without this patch, a huge deal of code consolidation and
generalization is gated (namely - generic iommu and dma api, and
everything that depends on it, e.g. rpmsg/remoteproc).

> Is anyone working on IOMMU DT description?

Unless Benoit is, I'll happily pick this up.

> I guess if I do merge this, we can also clean this up significantly
> after all devices are converted to DT.

Sure.

> Unless it has other dependencies on Benoit's further DT patches, you can
> base this on my for_3.2/omap_device-2 branch which includes Benoit's
> alloc changes.

Ok, thanks a lot !
Ohad.
