From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/6] OMAP: iommu: hwmod, reset handling and runtime
 PM
Date: Thu, 18 Oct 2012 16:52:46 -0700
Message-ID: <20121018235246.GK30550@atomide.com>
References: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
 <20121016172258.GT15569@atomide.com>
 <CALLhW=5Fmjhd+w57Dmm2BLmBoHuC7_jprJndkw1dHoVzVu4TOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALLhW=5Fmjhd+w57Dmm2BLmBoHuC7_jprJndkw1dHoVzVu4TOg@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Joerg Roedel <joerg.roedel@amd.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: linux-omap@vger.kernel.org

Omar,

* Omar Ramirez Luna <omar.luna@linaro.org> [121017 16:54]:
> On 16 October 2012 12:22, Tony Lindgren <tony@atomide.com> wrote:
>
> > These will need to be rebased on omap-for-v3.8/cleanup-headers-iommu
> > when I have that pushed out as that removes plat/*iommu*.h files.
> 
> Ok, will wait and rebase on top of it.

Thanks, the related patches are now posted in thread
"[PATCH v3 0/6] omap iommu changes to remove plat includes".

Also, can you please take a look at the "Updated status of the removal
of plat headers" thread?

I've tagged you to remove the omap plat/mailbox.h :) 

Regards,

Tony
