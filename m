From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] usb: phy: twl4030-usb: Fix regressions to runtime PM on
 omaps
Date: Thu, 21 Aug 2014 10:21:08 -0700
Message-ID: <20140821172108.GC10066@atomide.com>
References: <20140821164346.GA10066@atomide.com>
 <20140821170615.GG11146@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140821170615.GG11146@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [140821 10:09]:
> On Thu, Aug 21, 2014 at 09:43:46AM -0700, Tony Lindgren wrote:
> > @@ -744,6 +778,9 @@ static int twl4030_usb_probe(struct platform_device *pdev)
> >  		return status;
> >  	}
> >  
> > +	pm_runtime_mark_last_busy(&pdev->dev);
> > +	pm_runtime_put(&pdev->dev);
> 
> don't you wanna do a put_autosuspend() here instead ?

Sure yeah makes sense as the twl4030_phy_init() usually
runs shortly after.
 
> Other than that
> 
> Acked-by: Felipe Balbi <balbi@ti.com>

Thanks,

Tony
