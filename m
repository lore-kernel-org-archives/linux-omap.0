From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 0/6] Move rest of omap-iommu to live in drivers/iommu
Date: Tue, 20 Nov 2012 12:00:53 -0800
Message-ID: <20121120200051.GN18567@atomide.com>
References: <20121102192221.4253.34303.stgit@muffinssi.local>
 <CAK=WgbYR8UMyDjySJLRC0tEbJO3FaFgjWxceNwMyVdMgEgwPig@mail.gmail.com>
 <CALLhW=5WNg8X0nX8U+AExocyNKW=wJ7oS36xg4ENMnfyJkX8RQ@mail.gmail.com>
 <20121112220033.GO6801@atomide.com>
 <20121117121021.GS25742@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121117121021.GS25742@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Omar Ramirez Luna <omar.luna@linaro.org>, Ohad Ben-Cohen <ohad@wizery.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Joerg Roedel <joro@8bytes.org> [121117 04:12]:
> On Mon, Nov 12, 2012 at 02:00:34PM -0800, Tony Lindgren wrote:
> > Assuming Joerg is OK with these changes, I can push them into
> > an immutable branch that Joerg can merge in as needed.
> > 
> > Further patches on top of this series can then be queued by
> > Joerg as arch/arm/*omap* and me are then out of the way of
> > iommu development.
> 
> Okay, from my side:
> 
> Acked-by: Joerg Roedel <joro@8bytes.org>
> 
> Please let me know which branch I need to pull into my tree when you
> merged these patches.

Thanks, I've pushed it out to omap-for-v3.8/cleanup-headers-iommu at
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
so you can merge it into the iommu tree.

Regards,

Tony
