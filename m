From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 0/6] Move rest of omap-iommu to live in drivers/iommu
Date: Mon, 12 Nov 2012 14:00:34 -0800
Message-ID: <20121112220033.GO6801@atomide.com>
References: <20121102192221.4253.34303.stgit@muffinssi.local>
 <CAK=WgbYR8UMyDjySJLRC0tEbJO3FaFgjWxceNwMyVdMgEgwPig@mail.gmail.com>
 <CALLhW=5WNg8X0nX8U+AExocyNKW=wJ7oS36xg4ENMnfyJkX8RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALLhW=5WNg8X0nX8U+AExocyNKW=wJ7oS36xg4ENMnfyJkX8RQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Joerg Roedel <joro@8bytes.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Omar Ramirez Luna <omar.luna@linaro.org> [121112 10:42]:
> Hi,
> 
> On 11 November 2012 03:39, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > On Fri, Nov 2, 2012 at 9:23 PM, Tony Lindgren <tony@atomide.com> wrote:
> >> We need to move the iommu code to live under drivers
> >> for arm common zImage support.
> >
> > For the iommu changes in the entire series:
> >
> > Acked-by: Ohad Ben-Cohen <ohad@wizery.com>
> >
> > Joerg, it might relieve some pain if this will go through Tony's tree,
> > as there are some OMAP platform iommu changes coming in from Omar as
> > well (part of which might have already been merged in the omap
> > branches). Hope it's ok with both of you guys?
> >
> > Omar, do you still have any iommu changes coming in ?
> 
> Yes, I have the hwmod and runtime pm changes for iommu, I was waiting
> for Tony to publish a branch with these changes to submit (as per
> Tony's suggestion), but I already have the patches rebased onto these.
> 
> I will submit them.

Assuming Joerg is OK with these changes, I can push them into
an immutable branch that Joerg can merge in as needed.

Further patches on top of this series can then be queued by
Joerg as arch/arm/*omap* and me are then out of the way of
iommu development.

Regards,

Tony
