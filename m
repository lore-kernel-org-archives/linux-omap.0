From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH v4 01/11] PWMSS: Add PWM Subsystem driver for
 parent<->child relationship
Date: Fri, 23 Nov 2012 10:34:01 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3E9EE987@DBDE01.ent.ti.com>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-2-git-send-email-avinashphilip@ti.com>
 <20121122204704.GA16716@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20121122204704.GA16716@avionic-0098.adnet.avionic-design.de>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Cousson, Benoit" <b-cousson@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "AnilKumar, Chimata" <anilkumar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 23, 2012 at 02:17:04, Thierry Reding wrote:
> On Wed, Nov 21, 2012 at 06:40:58PM +0530, Philip, Avinash wrote:
> [...]
> > +static const struct of_device_id pwmss_of_match[] = {
> > +	{
> > +		.compatible	= "ti,am33xx-pwmss",
> > +	},
> 
> For consistency with other drivers this should be all on one line.

Ok I will correct it.

> 
> > +static const struct dev_pm_ops pwmss_pm_ops = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(pwmss_suspend, pwmss_resume)
> > +};
> 
> This could be even shorter:
> 
> static SIMPLE_DEV_PM_OPS(pwmss_pm_ops, pwmss_suspend, pwmss_resume);

Ok I will correct it.

Thanks
Avinash

> 
> Thierry
> 

