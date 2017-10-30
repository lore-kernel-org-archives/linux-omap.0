From: Tony Lindgren <tony@atomide.com>
Subject: Re: [bug report] ARM: OMAP2+: Populate legacy resources for dma and
 smartreflex
Date: Mon, 30 Oct 2017 10:10:37 -0700
Message-ID: <20171030171037.GB7339@atomide.com>
References: <20171027064440.i5zf4fwsdj3phwuy@mwanda>
 <20171027225048.GG21504@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171027225048.GG21504@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [171027 22:52]:
> * Dan Carpenter <dan.carpenter@oracle.com> [171026 23:46]:
> > Hello Tony Lindgren,
> > 
> > This is a semi-automatic email about new static checker warnings.
> > 
> > The patch d85a2d61432a: "ARM: OMAP2+: Populate legacy resources for 
> > dma and smartreflex" from Oct 10, 2017, leads to the following Smatch 
> > complaint:
> > 
> > arch/arm/mach-omap2/omap_device.c:453 omap_device_copy_resources()
> > 	 error: we previously assumed 'oh' could be null (see line 394)
> > 
> > arch/arm/mach-omap2/omap_device.c
> >    393	
> >    394		if (!oh || !oh->od || !oh->od->pdev) {
> >                     ^^^
> > Patch adds check for NULL.
> > 
> >    395			error = -EINVAL;
> >    396			goto error;
> >    397		}
> >    398	
> > 
> > [ snip ]
> > 
> >    448	
> >    449	free:
> >    450		kfree(res);
> >    451	
> >    452	error:
> >    453		WARN(error, "%s: %s device %s failed: %i\n",
> >    454		     __func__, oh->name, dev_name(&pdev->dev),
> >                                ^^^^^^^^
> > and the patch adds a dereference.
> > 
> >    455		     error);
> 
> Thanks, looks like we should just return early there. I'll send
> a fix for this.

And here's the patch to fix it.

Regards,

Tony

8< -------------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 30 Oct 2017 10:01:39 -0700
Subject: [PATCH] ARM: OMAP2+: Fix smatch found issue for omap_device

The patch d85a2d61432a: "ARM: OMAP2+: Populate legacy resources for
dma and smartreflex" from Oct 10, 2017, leads to the following Smatch
complaint:

arch/arm/mach-omap2/omap_device.c:453 omap_device_copy_resources()
         error: we previously assumed 'oh' could be null (see line 394)

Fixes: d85a2d61432a: ("ARM: OMAP2+: Populate legacy resources for dma
and smartreflex")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_device.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -391,10 +391,8 @@ omap_device_copy_resources(struct omap_hwmod *oh,
 	const char *name;
 	int error, irq = 0;
 
-	if (!oh || !oh->od || !oh->od->pdev) {
-		error = -EINVAL;
-		goto error;
-	}
+	if (!oh || !oh->od || !oh->od->pdev)
+		return -EINVAL;
 
 	np = oh->od->pdev->dev.of_node;
 	if (!np) {
-- 
2.14.3
