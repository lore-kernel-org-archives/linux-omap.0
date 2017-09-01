From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/2] iommu/omap: Add support to program multiple iommus
Date: Fri, 1 Sep 2017 12:01:41 +0200
Message-ID: <20170901100141.2ooccy7ns2fwxceg@8bytes.org>
References: <20170831131402.29502-1-s-anna@ti.com>
 <20170831131402.29502-3-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170831131402.29502-3-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: iommu@lists.linux-foundation.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Suman,

On Thu, Aug 31, 2017 at 08:14:02AM -0500, Suman Anna wrote:
> The OMAP IOMMU driver has been enhanced to support allowing
> multiple IOMMUs to be programmed by a single client user. This
> support is being added mainly to handle the DSP subsystems on
> the DRA7xx SoCs, which have two MMUs within the same subsystem.
> These MMUs provide translations to a processor core port and
> an internal EDMA port. This support allows both the MMUs to
> be programmed together, but with each one retaining it's own
> internal state objects. The internal EDMA is managed by the
> software running on the DSPs, and this design provides on-par
> functionality with previous generation OMAP DSPs where the
> EDMA and the DSP core shared the same MMU.

I didn't get that from the review, so a question here: Do both MMUs show
show up in sysfs, means, do you register both of them the the core code?

Because I think with the solution implemented here, only a single,
combined MMU should be visible to iommu core code and in sysfs.


Regards,

	Joerg
