From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 5/5] drivers: bus: omap_l3: Change pr_crit() to
 dev_err() when IRQ request fails
Date: Wed, 12 Mar 2014 10:28:55 -0700
Message-ID: <20140312172854.GD30897@atomide.com>
References: <1393937293-6036-1-git-send-email-peter.ujfalusi@ti.com>
 <1393937293-6036-6-git-send-email-peter.ujfalusi@ti.com>
 <5315E522.9090606@ti.com>
 <5316CE17.6010201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19342 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbaCLR3C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2014 13:29:02 -0400
Content-Disposition: inline
In-Reply-To: <5316CE17.6010201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [140304 23:14]:
> On 03/04/2014 04:37 PM, Santosh Shilimkar wrote:
> > On Tuesday 04 March 2014 08:48 PM, Peter Ujfalusi wrote:
> >> Use dev_err() which will going to print the driver's name as well =
and the
> >> KERN_ERR level is sufficient in this case (we also print via dev_e=
rr when
> >> there is an error with the mem resources)
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> ---
> >>  drivers/bus/omap_l3_noc.c | 7 +++----
> >>  1 file changed, 3 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
> >> index 0eff48585ae3..972691a668a3 100644
> >> --- a/drivers/bus/omap_l3_noc.c
> >> +++ b/drivers/bus/omap_l3_noc.c
> >> @@ -158,8 +158,8 @@ static int omap4_l3_probe(struct platform_devi=
ce *pdev)
> >>  	ret =3D devm_request_irq(&pdev->dev, l3->debug_irq, l3_interrupt=
_handler,
> >>  			       IRQF_DISABLED, "l3-dbg-irq", l3);
> >>  	if (ret) {
> >> -		pr_crit("L3: request_irq failed to register for 0x%x\n",
> >> -						l3->debug_irq);
> >> +		dev_err(&pdev->dev, "request_irq failed for %d\n",
> >> +			l3->debug_irq);
> >>  		return ret;
> >>  	}
> >> =20
> >> @@ -167,8 +167,7 @@ static int omap4_l3_probe(struct platform_devi=
ce *pdev)
> >>  	ret =3D devm_request_irq(&pdev->dev, l3->app_irq, l3_interrupt_h=
andler,
> >>  			       IRQF_DISABLED, "l3-app-irq", l3);
> >>  	if (ret)
> >> -		pr_crit("L3: request_irq failed to register for 0x%x\n",
> >> -						l3->app_irq);
> >> +		dev_err(&pdev->dev, "request_irq failed for %d\n", l3->app_irq)=
;
> >> =20
> >>  	return ret;
> >>  }
> >>
> > So this one change in the log level. If I look at now, may be dev_e=
rr
> > is fine but the change is not same.
>=20
> Not sure what you mean by 'the change is not same'?
> I just picked the old series and rebased it on linux-next, the patch =
is the
> same as it was back in May 2013:
> https://lkml.org/lkml/2013/5/2/205
>=20
> And yes, I have shortened the texts in the print, but the meaning of =
the
> prints have not changed.

Santosh, got any more comments on this series?

Regards,

Tony
=20
> > Apart from above comment, rest of the series looks fine to me.
> > Feel free to add my ack...
>=20
> Thanks.
>=20
> --=20
> P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
