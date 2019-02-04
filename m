From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 02/14] soc: ti: pruss: Add a platform driver for PRUSS
 in TI SoCs
Date: Mon, 4 Feb 2019 08:35:46 -0800
Message-ID: <20190204163546.GJ5720@atomide.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-3-git-send-email-rogerq@ti.com>
 <99a3717c-7eab-07d2-e73e-f302c3848b8a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <99a3717c-7eab-07d2-e73e-f302c3848b8a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [190204 14:52]:
> On 2/4/19 8:22 AM, Roger Quadros wrote:
> > From: Suman Anna <s-anna@ti.com>
> > +++ b/drivers/soc/ti/Kconfig
> > @@ -73,4 +73,16 @@ config TI_SCI_PM_DOMAINS
> >  	  called ti_sci_pm_domains. Note this is needed early in boot before
> >  	  rootfs may be available.
> >  
> > +config TI_PRUSS
> > +	tristate "TI PRU-ICSS Subsystem Platform drivers"
> > +	depends on SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX
> > +	select MFD_SYSCON
> > +	default n

Just a nitpick comment, we have n as the default already,
so default n can be dropped.

Regards,

Tony
