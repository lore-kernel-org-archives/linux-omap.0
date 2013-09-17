From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mailbox: remove unnecessary platform_set_drvdata()
Date: Tue, 17 Sep 2013 16:44:25 -0700
Message-ID: <20130917234424.GP9994@atomide.com>
References: <002201ce9edc$cdc3fb90$694bf2b0$%han@samsung.com>
 <52178FAD.7040402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52178FAD.7040402@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [130823 09:50]:
> + OMAP mailing list
> 
> Tony,
> Can you pick up this minor cleanup patch?
> 
> regards
> Suman
> 
> On 08/21/2013 09:10 PM, Jingoo Han wrote:
> > The driver core clears the driver data to NULL after device_release
> > or on probe failure. Thus, it is not needed to manually clear the
> > device driver data to NULL.
> > 
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> 
> Acked-by: Suman Anna <s-anna@ti.com>

OK applying into omap-for-v3.12/fixes thanks.

Regards,

Tony
 
> > ---
> >  drivers/mailbox/mailbox-omap2.c |    1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/mailbox/mailbox-omap2.c b/drivers/mailbox/mailbox-omap2.c
> > index eba380d..42d2b89 100644
> > --- a/drivers/mailbox/mailbox-omap2.c
> > +++ b/drivers/mailbox/mailbox-omap2.c
> > @@ -325,7 +325,6 @@ static int omap2_mbox_remove(struct platform_device *pdev)
> >  	kfree(privblk);
> >  	kfree(mboxblk);
> >  	kfree(list);
> > -	platform_set_drvdata(pdev, NULL);
> >  
> >  	return 0;
> >  }
> > 
> 
