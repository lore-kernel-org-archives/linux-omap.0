From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 2/2] OMAP3BEAGLE: Add support for mt9p031 sensor driver.
Date: Mon, 23 May 2011 09:47:15 +0200
Message-ID: <201105230947.15775.laurent.pinchart@ideasonboard.com>
References: <1305899272-31839-1-git-send-email-javier.martin@vista-silicon.com> <4DD9146B.2050408@compulab.co.il> <BANLkTi=sqZpAKFxeCbwqpU_7+WZABGa4=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <BANLkTi=sqZpAKFxeCbwqpU_7+WZABGa4=w@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-media@vger.kernel.org, beagleboard@googlegroups.com, carlighting@yahoo.co.nz, g.liakhovetski@gmx.de, linux-arm-kernel@lists.infradead.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Javier,

On Monday 23 May 2011 09:25:01 javier Martin wrote:
> On 22 May 2011 15:49, Igor Grinberg <grinberg@compulab.co.il> wrote:

[snip]

> >> @@ -309,6 +357,15 @@ static int beagle_twl_gpio_setup(struct device
> >> *dev, pr_err("%s: unable to configure EHCI_nOC\n", __func__); }
> >> 
> >> +     if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
> >> +             /*
> >> +              * Power on camera interface - only on pre-production, not
> >> +              * needed on production boards
> >> +              */
> >> +             gpio_request(gpio + 2, "CAM_EN");
> >> +             gpio_direction_output(gpio + 2, 1);
> > 
> > Why not gpio_request_one()?
> 
> Just to follow the same approach as in the rest of the code.
> Maybe a further patch could change all "gpio_request()" uses to
> "gpio_request_one()".

Please do it the other way around. Replace calls to gpio_request() + 
gpio_direction_output() with a call to gpio_request_one(), and then modify 
this patch to use gpio_request_one().

If you want to learn how to use coccinelle (http://coccinelle.lip6.fr/), now 
would be a good time. You could use it to replace gpio_request() + 
gpio_direction_output() through the whole kernel.

-- 
Regards,

Laurent Pinchart
