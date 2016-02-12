From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] arm: dts: AM57XX: Correct the thermal thresholds
Date: Fri, 12 Feb 2016 14:41:29 -0800
Message-ID: <20160212224129.GP19432@atomide.com>
References: <1454924705-8382-1-git-send-email-j-keerthy@ti.com>
 <20160209220901.GC28102@localhost.localdomain>
 <56BA6530.4030102@ti.com>
 <20160212222347.GO19432@atomide.com>
 <CAGo_u6r8-LJBWWrew0fV50Q+JnCxDj9PD57+9NoDm5TqCWL=jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGo_u6r8-LJBWWrew0fV50Q+JnCxDj9PD57+9NoDm5TqCWL=jw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dt list <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [160212 14:32]:
> On Fri, Feb 12, 2016 at 4:23 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > * Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [160209 14:17]:
> >> On 02/09/2016 04:09 PM, Eduardo Valentin wrote:
> >> > On Mon, Feb 08, 2016 at 03:15:05PM +0530, Keerthy wrote:
> >> >> The thermal threholds for am57xx are different from that of dra7.
> >> >> Correcting the thresholds for the same.
> >> >>
> >> >> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> >> >> ---
> >> >>
> >> >> Depends on: https://lkml.org/lkml/2016/2/8/90
> >> >>
> >> >>  arch/arm/boot/dts/am57xx-beagle-x15.dts | 24 ++++++++++++++++++++++++
> >> >>  1 file changed, 24 insertions(+)
> >> >>
> >> >> Index: linux/arch/arm/boot/dts/am57xx-beagle-x15.dts
> >> >> ===================================================================
> >> >> --- linux.orig/arch/arm/boot/dts/am57xx-beagle-x15.dts     2016-02-08 14:57:05.514959101 +0530
> >> >> +++ linux/arch/arm/boot/dts/am57xx-beagle-x15.dts  2016-02-08 14:57:05.510959168 +0530
> >> >
> >> > Sorry, did not bother to check, but is this the only user of am57xx?
> >>
> >> we will have AM57xx-IDK as well coming down the line. we already have
> >> arch/arm/boot/dts/am57xx-cl-som-am57x.dts
> >> arch/arm/boot/dts/am57xx-sbc-am57x.dts - not really sure what grade of
> >> silicon are used in cl-SOM and sbc boards.
> >
> > Hmm can this one wait for v4.6 or is it critical for v4.5-rc
> > cycle?
> 
> personally, I'd like to NAK this patch -> lack of reference
> documentation, and guidance for various AM57xx boards in a generic
> patch should probably be followed IMHO.

OK let's wait for that then.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
