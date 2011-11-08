From: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH] arm: cpuidle34xx.c: Fix compile error
Date: Tue, 8 Nov 2011 18:43:08 +0100
Message-ID: <20111108174308.GG5182@amd.com>
References: <1320768665-9759-1-git-send-email-joerg.roedel@amd.com>
 <87hb2eqzwv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87hb2eqzwv.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 08, 2011 at 09:36:48AM -0800, Kevin Hilman wrote:
> Joerg Roedel <joerg.roedel@amd.com> writes:
> 
> > Add missing module.h include to provide THIS_MODULE.
> >
> > Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> 
> FYI...
> 
> Tony has already queued fix for this in his fixes branch.
> 
>      http://marc.info/?l=linux-arm-kernel&m=132071036621713&w=2

Great. I stumbled over it while compile-testing the iommu-tree for omap.

Thanks,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
