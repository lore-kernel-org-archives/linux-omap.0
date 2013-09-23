From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 5/5] dma: cppi41: add support for suspend and resume
Date: Mon, 23 Sep 2013 15:30:13 +0530
Message-ID: <20130923100013.GE17188@intel.com>
References: <1379861404-8250-1-git-send-email-zonque@gmail.com>
 <1379861404-8250-6-git-send-email-zonque@gmail.com>
 <20130923040947.GV17188@intel.com>
 <523FD747.8060304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24714 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314Ab3IWKvA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Sep 2013 06:51:00 -0400
Content-Disposition: inline
In-Reply-To: <523FD747.8060304@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, sergei.shtylyov@cogentembedded.com, dan.j.williams@intel.com, balbi@ti.com, gregkh@linuxfoundation.org

On Mon, Sep 23, 2013 at 07:53:11AM +0200, Daniel Mack wrote:
> On 23.09.2013 06:09, Vinod Koul wrote:
> > On Sun, Sep 22, 2013 at 04:50:04PM +0200, Daniel Mack wrote:
>=20
> >> +#ifdef CONFIG_PM_SLEEP
> > ahhhh
> >=20
> >> +static int cppi41_suspend(struct device *dev)
> >> +{
> >> +	struct cppi41_dd *cdd =3D dev_get_drvdata(dev);
> >> +
> >> +	cppi_writel(0, cdd->usbss_mem + USBSS_IRQ_CLEARR);
> >> +	disable_sched(cdd);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int cppi41_resume(struct device *dev)
> >> +{
> >> +	struct cppi41_dd *cdd =3D dev_get_drvdata(dev);
> >> +	int i;
> >> +
> >> +	for (i =3D 0; i < DESCS_AREAS; i++)
> >> +		cppi_writel(cdd->descs_phys, cdd->qmgr_mem + QMGR_MEMBASE(i));
> >> +
> >> +	init_sched(cdd);
> >> +	cppi_writel(USBSS_IRQ_PD_COMP, cdd->usbss_mem + USBSS_IRQ_ENABLE=
R);
> >> +
> >> +	return 0;
> >> +}
> >> +#endif
> >> +
> >> +static SIMPLE_DEV_PM_OPS(cppi41_pm_ops, cppi41_suspend, cppi41_re=
sume);
> > Here is the macro in pm.h
>=20
> [...]
>=20
> > Now since you are using the macro there should be no need to wrap i=
fdef around
> > your code, the macro will take care of it.
>=20
> Well yes, which is why I put the macro itself *outside* of the #ifdef
> block. Without that #ifdef, however, and with CONFIG_PM_SLEEP unset, =
I get:
>=20
> drivers/dma/cppi41.c:1043:12: warning: =E2=80=98cppi41_suspend=E2=80=99=
 defined but not
> used [-Wunused-function]
>  static int cppi41_suspend(struct device *dev)
>             ^
> drivers/dma/cppi41.c:1053:12: warning: =E2=80=98cppi41_resume=E2=80=99=
 defined but not
> used [-Wunused-function]
>  static int cppi41_resume(struct device *dev)
>             ^
>=20
> ... which doesn't surprise me much. Or do I still not get your point?
And this is what i had expected... I was thinking we should ignore this=
, but
this is better too, so I will try to apply this now

~Vinod

--=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
