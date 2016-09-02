From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: am57xx-beagle-x15: Add support for rev B1
Date: Fri, 2 Sep 2016 08:06:49 -0700
Message-ID: <20160902150648.lgbhxvyapo4p3lg3@atomide.com>
References: <20160902090600.27262-1-nm@ti.com>
 <20160902090600.27262-3-nm@ti.com>
 <dd74f5e1-304f-661e-7fd9-f5f81bcfc55e@ti.com>
 <CAOCHtYiFjB-cuABmCiw96spc-De+qNNQYGrjp-MmNDuH2mJ9Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOCHtYiFjB-cuABmCiw96spc-De+qNNQYGrjp-MmNDuH2mJ9Bw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160902 06:52]:
> On Fri, Sep 2, 2016 at 5:41 AM, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org> wrote:
> > Instead, it seems to be easier for maintenance and safer overall if the
> > older version has a file of its own which can be kept alone.
> >
> > Also, how about renaming the existing dts to am57xx-beagle-x15-reva2.dts
> > and let the production version be called am57xx-beagle-x15.dts? Surely
> > this will cause some inconvenience to A2 users. But there are few users
> > of those and it might be more intuitive for the majority users if the
> > file for production version is without a specific version string
> > attached. Just a thought though, not sure about it myself either.
> 
> Nak, let's NOT do that to A2 users.
> 
> The am57xx-beagle-x15.dts went mainline in v3.19, u-boot installed on
> devices would need to be updated and this would make bisecting a pain.
> ;)

I agree, let's keep things working without forcing people to update
their u-boot enviroment for the dtb name.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
