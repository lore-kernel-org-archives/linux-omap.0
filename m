From: Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCHv4 4/7] hwspinlock/core: add common OF helpers
Date: Thu, 13 Mar 2014 11:43:15 -0500
Message-ID: <20140313164315.GQ18529@joshc.qualcomm.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
 <1389658764-39199-5-git-send-email-s-anna@ti.com>
 <CAJAp7Oi7wD+VsMAd37gT04yZ4TH4ygXFmheDhvmWuanUjpBmVQ@mail.gmail.com>
 <52F92524.3080402@ti.com>
 <CAK=WgbY0wDtGCm71E8VXi2g5+VcGogHEy8jdekTRg8xtp6-3rQ@mail.gmail.com>
 <CAJAp7Ohf43hbKatCwS5Y1+OfEkJYWOkuhZhW-E_=t_9mfM+UaA@mail.gmail.com>
 <53160F8F.9060405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53160F8F.9060405-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 04, 2014 at 11:38:23AM -0600, Suman Anna wrote:
> Hi Ohad,
> 
> On 03/02/2014 02:19 PM, Bjorn Andersson wrote:
> >On Sat, Mar 1, 2014 at 9:14 PM, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org> wrote:
> >>On Mon, Feb 10, 2014 at 9:14 PM, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> wrote:
> >>>On 02/07/2014 04:49 PM, Bjorn Andersson wrote:
> >>>Ohad,
> >>>Do you have any objections to the return code convention change?
> >>
> >>Unless strictly needed, I prefer we don't switch to the ERR_PTR code
> >>convention, as it reduces code readability and increases chances of
> >>user bugs.
> >>
> >>In our case, switching to ERR_PTR and friends seems only to optimize a
> >>few error paths, and I'm not sure it's a big win over simplicity.
> >
> >When introducing the ability to reference a hwspin lock via a phandle
> >in device tree it makes a big difference to be able to differ between
> >the case of "initialization failed" or "device not yet probed"; so
> >that the client knows if it should fail or retry later.
> >
> 
> Can you confirm the changes you want me to make, so that I can refresh and
> post a v5 for 3.15?

What's the status on this?  I'm assuming this is going to miss 3.15?
Having DT support in the core will be useful to move the Qualcomm
hwspinlock driver forward as well.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
