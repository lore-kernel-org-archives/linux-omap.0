From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH v4 05/11] pwm: pwm-tiecap: pinctrl support
Date: Fri, 23 Nov 2012 10:34:02 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3E9EE991@DBDE01.ent.ti.com>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-6-git-send-email-avinashphilip@ti.com>
 <20121122205944.GC16716@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121122205944.GC16716@avionic-0098.adnet.avionic-design.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Cousson, Benoit" <b-cousson@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "AnilKumar, Chimata" <anilkumar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 23, 2012 at 02:29:44, Thierry Reding wrote:
> On Wed, Nov 21, 2012 at 06:41:02PM +0530, Philip, Avinash wrote:
> [...]
> > +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> > +	if (IS_ERR(pinctrl))
> > +		dev_warn(&pdev->dev, "failed to configure pins from driver\n");
> 
> I think we already discussed this, but shouldn't this be a fatal error?

I had checked relevant discussion and found this can be warning message.
This is because most boards don't have pinctrl implemented at this point,
or may never have.

https://lkml.org/lkml/2012/9/11/369

Any way I will change to
dev_warn(&pdev->dev, "unable to select pin group\n");
as in other drivers.

Thanks
Avinash

> 
> Thierry
> 
