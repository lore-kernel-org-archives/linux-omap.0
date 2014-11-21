From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 3/6] mfd: ti_am335x_tscadc: Remove unwanted reg_se_cache
 save
Date: Fri, 21 Nov 2014 17:40:12 +0530
Message-ID: <546F2BA4.4000808@ti.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com> <1415941651-28962-4-git-send-email-vigneshr@ti.com> <20141118143005.GF24004@x1> <20141118171240.GB3003@dtor-ws> <546DF2F0.9080405@ti.com> <20141120144028.GB5809@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141120144028.GB5809-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Cochran <richardcochran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>, Sanjeev Sharma <sanjeev_sharma-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Jan Kardell <jan.kardell-KSZdJiTw9mzQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel@vg
List-Id: linux-omap@vger.kernel.org

On Thursday 20 November 2014 08:10 PM, Richard Cochran wrote:
> On Thu, Nov 20, 2014 at 07:26:00PM +0530, Sekhar Nori wrote:
>> I tested this using lcd7 cape connected to beaglebone black. The latest
>> kernel I could find on this board was a TI BSP based v3.14 kernel. So I
>> had to port these patches to that kernel. Cc Robert Nelson to see if he
>> knows about a more recent kernel supporting that cape.
> 
> What is missing from mainline for the black?
> 
> (I thought it was fully supported by now.)

Black is supported, but LCD7 cape is not.

>  
>> I did not see any breakage with these patches applied although I did not
>> see any noticeable performance improvement as well.
> 
> So, the jumping on pen-up persists, right?  That means the patch
> series does not provide a general fix for that issue.

Not sure how to reproduce the jumping on pen-up. I was able to draw
circles, sign my name and actually today I wrote up the whole English
alphabet on the screen. Picture here.

https://drive.google.com/file/d/0ByWLwvGx8MeyVF9CTlhHU0FHMFk/view?usp=sharing

Is there any particular pattern you want me to test with?

I would still like to test with a more recent kernel on LCD7 cape. So,
if anyone has ideas (other than I porting the LCD7 support) please let
me know.

Thanks,
Sekhar
