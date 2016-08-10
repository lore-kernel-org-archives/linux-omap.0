From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] omapfb/dss: wait_for_completion_interruptible_timeout
 expects long
Date: Wed, 10 Aug 2016 10:30:19 +0000
Message-ID: <20160810103019.GA3842@osadl.at>
References: <1469466767-23352-1-git-send-email-hofrat@osadl.org>
 <cff34342-3574-d197-df08-dc5b9b6ced80@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cff34342-3574-d197-df08-dc5b9b6ced80@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Rob Clark <robdclark@gmail.com>, Dave Airlie <airlied@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Luis de Bethencourt <luisbg@osg.samsung.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 10, 2016 at 01:21:46PM +0300, Tomi Valkeinen wrote:
> On 25/07/16 20:12, Nicholas Mc Guire wrote:
> > wait_for_completion_timeout_interruptible returns long not unsigned long.
> > an appropriately typed variable is introduced and assignments fixed up.
> > 
> > Fixes: f76ee892a99e ("omapfb: copy omapdss & displays for omapfb")
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > ---
> > 
> > API non-compliance was located by coccinelle
> > 
> > This is mostly cosmetic since the returned value is only compared 
> > at present, however if remaining time (completion occurred) where ever 
> > used, then a signal received would be interpreted as a large remaining 
> > jiffies left, which would be wrong.
> > 
> > Compile tested with: omap2plus_defconfig (implies CONFIG_FB_OMAP2_DSS)
> > 
> > Patch is against 4.7.0-rc7 (localversion-next -next-20160724)
> > 
> >  drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Thanks, queued for v4.9. I dropped the "Fixes: " line, as that commit
> only does a copy of the files, so the commit didn't really introduce the
> bug.
>
sorry for the wrong fixes tag - did not notice that - and thanks for
fixing this.

thx!
hofrat
