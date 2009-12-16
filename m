From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] OMAP: McBSP: Fix possible port lockout
Date: Wed, 16 Dec 2009 17:16:28 +0100
Message-ID: <200912161716.30041.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:43003 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934515AbZLPQQu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 11:16:50 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org

In its current form, the omap_mcbsp_request() function can return after=
=20
irq_request() failure without any cleanups, effectively locking out the=
 port=20
forever with clocks left running. Fix it.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
Wednesday 16 December 2009 09:12:55 Jarkko Nikula napisa=C5=82(a):
> On Tue, 15 Dec 2009 01:36:47 +0100
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
> > 3. In omap_mcbsp_free(), marking the port as free before deallocati=
ng the
> >    cache, could result in memory leak as well.
> >
> > I hope all are addressed correctly. Since releasing the port with
> >
> > 	mcbsp->free =3D 1;
> >
> > after kzalloc() failure should be atomic, I have assumed this doesn=
't
> > require locking.
>
> Good catch. One comment below.
>
> > @@ -471,6 +491,9 @@ void omap_mcbsp_free(unsigned int id)
> >  		free_irq(mcbsp->tx_irq, (void *)mcbsp);
> >  	}
> >
> > +	kfree(mcbsp->reg_cache);
> > +	mcbsp->reg_cache =3D NULL;
> > +
> >  	spin_lock(&mcbsp->lock);
> >  	if (mcbsp->free) {
> >  		dev_err(mcbsp->dev, "McBSP%d was not reserved\n",
>
> This is fine in current form but to play safe, lets do the kfree
> inside the spin_lock section where the mcbsp->free is set. Then there
> is no risk if some future code would use the mcbsp->free as a guard f=
or
> cache etc. access.

Jarkko,

More and more looking at this, I think that omap_mcbsp_request() should=
 be=20
cleaned up frist in respect of freeing resources on error before we put=
 any=20
new functionality there.

This patch could be either joined with patch 1/5 or introduced as extra=
 patch=20
1.5/5 into the McBSP caching set if not accepted as a separate fix.

I'm not sure if it is really required to revert any =20
mcbsp->pdata->ops->request() or omap34xx_mcbsp_request() applied change=
s by=20
calling mcbsp->pdata->ops->free() or omap34xx_mcbsp_free() from here.

Thanks,
Janusz


diff -upr git.orig/arch/arm/plat-omap/mcbsp.c git/arch/arm/plat-omap/mc=
bsp.c
--- git.orig/arch/arm/plat-omap/mcbsp.c	2009-12-16 16:33:16.000000000 +=
0100
+++ git/arch/arm/plat-omap/mcbsp.c	2009-12-16 16:32:50.000000000 +0100
@@ -436,7 +436,7 @@ int omap_mcbsp_request(unsigned int id)
 			dev_err(mcbsp->dev, "Unable to request TX IRQ %d "
 					"for McBSP%d\n", mcbsp->tx_irq,
 					mcbsp->id);
-			return err;
+			goto error;
 		}
=20
 		init_completion(&mcbsp->rx_irq_completion);
@@ -446,12 +446,26 @@ int omap_mcbsp_request(unsigned int id)
 			dev_err(mcbsp->dev, "Unable to request RX IRQ %d "
 					"for McBSP%d\n", mcbsp->rx_irq,
 					mcbsp->id);
-			free_irq(mcbsp->tx_irq, (void *)mcbsp);
-			return err;
+			goto tx_irq;
 		}
 	}
=20
 	return 0;
+tx_irq:
+	free_irq(mcbsp->tx_irq, (void *)mcbsp);
+error:
+	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
+			mcbsp->pdata->ops->free(id);
+
+	/* Do procedure specific to omap34xx arch, if applicable */
+	omap34xx_mcbsp_free(mcbsp);
+
+	clk_disable(mcbsp->fclk);
+	clk_disable(mcbsp->iclk);
+
+	mcbsp->free =3D 1;
+
+	return err;
 }
 EXPORT_SYMBOL(omap_mcbsp_request);
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
