From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/3] Adding DT support for TI HECC module
Date: Thu, 12 Jan 2017 07:44:23 -0800
Message-ID: <20170112154423.GB2630@atomide.com>
References: <1484143521-4898-1-git-send-email-yegorslists@googlemail.com>
 <CAGm1_kvWXfZ_f3PPL1VJj8AhBf59Pax_GFHDVdejuMBRDu9y6Q@mail.gmail.com>
 <20170112004757.GZ2630@atomide.com>
 <CAGm1_kvNcmpayN-=mMmkCn1=wXaykhENUrHK2-MVmZLC+Cca0Q@mail.gmail.com>
 <CAGm1_ksOZ591TQHVo5u0MHP_H5fzPX3ip5Jf3eunfT2OOW7fZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGm1_ksOZ591TQHVo5u0MHP_H5fzPX3ip5Jf3eunfT2OOW7fZw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Andrey Skvortsov <andrej.skvortzov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, hs-ynQEQJNshbs@public.gmane.org, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> [170112 07:33]:
> On Thu, Jan 12, 2017 at 8:59 AM, Yegor Yefremov
> <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
> > On Thu, Jan 12, 2017 at 1:47 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> >> * Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> [170111 13:52]:
> >>> On Wed, Jan 11, 2017 at 3:05 PM,  <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
> >>> > From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> >>> >
> >>> > This is an attempt to revive DT support for TI HECC that was started in 2015.
> >>> >
> >>> > I haven't changed much because not all questions could be fully answered:
> >>> >
> >>> > * Should HECC use "am3505" as compatible?
> >>>
> >>> I mean "ti,am3505-hecc"
> >>
> >> Yeah it should use the device name for the driver.
> 
> I've looked at drivers/net/ethernet/ti/davinci_emac.c and there
> "ti,am3517-emac" will be used. Should we stick to am3517? am3505 won't
> be used in any dts[i] file.

If they are the same, then usually the earliest hardware naming can be
used for later versions too. I don't know which was first am3517 or
3505. If you think "ti,am3517-hecc" makes sense I'm fine with that.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
