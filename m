From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: igep00x0: Add SD card-detect.
Date: Thu, 12 May 2016 13:53:56 -0700
Message-ID: <20160512205356.GA5995@atomide.com>
References: <1462568554-7868-1-git-send-email-enric.balletbo@collabora.com>
 <CABxcv=nZ1hjVGnNG65eKDrxAYFBcavML+GjxXtfTcVO5N83xkA@mail.gmail.com>
 <572D0B10.60908@collabora.com>
 <CABxcv=nqdETAJBpO-akYipuHH6F6vy5wxHX+dOt9=0CKTTkt=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CABxcv=nqdETAJBpO-akYipuHH6F6vy5wxHX+dOt9=0CKTTkt=Q@mail.gmail.com>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Cc: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org> [160506 14:28]:
> Hello Enric,
> 
> On Fri, May 6, 2016 at 5:22 PM, Enric Balletbo i Serra
> <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org> wrote:
> > Hi Javier,
> >
> > On 06/05/16 23:07, Javier Martinez Canillas wrote:
> >> Hello Enric,
> >>
> >> On Fri, May 6, 2016 at 5:02 PM, Enric Balletbo i Serra
> >> <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org> wrote:
> >>> Fix SD card remove/insert detection by adding the correct card-detect
> >>> pin. All IGEP OMAP3 based boards use the same card-detect pin.
> >>>
> >>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> >>> Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> >>
> >> Shouldn't his be Suggested-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> instead?
> >>
> >> Or if the patch was originally from Ladis, then he should remain the
> >> author with your S-o-B after his.
> >>
> >
> > Well Ladis sent the same patch as I had in my local repository for long
> > time, so to be strict the correct is have two authors and two S-o-B. My bad
> > is not send the patch before.
> 
> Got it, then I think is correct to have both S-o-B. Thanks for the
> clarification.

OK thanks for checking, applying both into omap-for-v4.7/dt.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
