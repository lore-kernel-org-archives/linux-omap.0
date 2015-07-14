From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: dts: Fix frequency scaling on Gumstix Pepper.
Date: Mon, 13 Jul 2015 23:54:01 -0700
Message-ID: <20150714065400.GD17550@atomide.com>
References: <1433441299-18887-1-git-send-email-arun@gumstix.com>
 <1433441299-18887-4-git-send-email-arun@gumstix.com>
 <CAK8F28kxuk0zPetCBPLmU5skQcOb2E47veZe5s7YaeE-ZJNMew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAK8F28kxuk0zPetCBPLmU5skQcOb2E47veZe5s7YaeE-ZJNMew-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Arun Bharadwaj <arun-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [150609 08:47]:
> This works well for me--cpufreq seems much happier.
> 
> Tested-by: Ash Charles <ashcharles-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> On Thu, Jun 4, 2015 at 11:08 AM, Arun Bharadwaj <arun-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org> wrote:
> > The device tree for Gumstix Pepper has DCDC2 and
> > DCDC3 correctly labelled but the upper limit values
> > are wrong. The confusion is due to the hardware
> > quirk where the DCDC2 and DCDC3 wires are flipped
> > in Pepper.
> >
> > Signed-off-by: Arun Bharadwaj <arun-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org>

Applying into omap-for-v4.2/fixes thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
