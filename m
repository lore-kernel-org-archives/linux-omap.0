From: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH] [TWL4030 MADC] Fix ADC[3:6] readings
Date: Fri, 17 Jul 2015 11:42:47 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1507171136180.14972@pmeerw.net>
References: <1437085227-28845-1-git-send-email-adam.yh.lee@gmail.com> <1437085227-28845-2-git-send-email-adam.yh.lee@gmail.com> <20150717090039.GC9331@earth>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150717090039.GC9331@earth>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello,

adding linux-iio...

> To get a chance of this patch being considered for inclusion, you
> should send this to the maintainers of the phy and iio framework.
> There is a high chance, that none of them will see your mail.
> 
> On Thu, Jul 16, 2015 at 03:20:27PM -0700, Adam YH Lee wrote:
> > MADC[3:6] reads incorrect values without these two following changes:
> 
> uhm MADC[3:6] are externally available analog inputs. Your
> change will result in them being tied to the USB module.

change regarding TWL4030_USB_SEL_MADC_MCPC is necessary at 
least for some hardware revisions to get proper ADC values
 
> > - enable the 3v1 bias regulator for ADC[3:6]
> 
> The regulator is not required for correct MADC functionality, but
> for correct USB measureing. The regulator should not be requested
> by the madc module, but by the usb module, which is connected to
> the madc.

in my experience, the MADC exhibits several strange things, I wouldn't be 
surprised that this bias is somehow necessary for operation even if it is 
not what the spec says -- has this been tested?
 
> > - configure ADC[3:6] lines as input, not as USB
> 
> I don't think that should be done for all boards.
> 
> > [...]
> 
> -- Sebastian
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
