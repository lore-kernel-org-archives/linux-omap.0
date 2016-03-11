From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Tons of "no unit name" spam with make dtbs
Date: Thu, 10 Mar 2016 19:23:23 -0600
Message-ID: <CAL_JsqJswSBTf+5Vdv2gg05nUg1008vPeh5MYDO_7WHAc=Dndw@mail.gmail.com>
References: <20160310180745.GD9329@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160310180745.GD9329-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 10, 2016 at 12:07 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> Hey Rob,
>
> I'm seeing tons of dtc spam with make dtbs (about 23k lines
> with multi_v7_defconfig!) with commit fa38a82096a1 ("scripts/dtc:
> Update to upstream version 53bf130b1cdd").
>
> Introducing something like this few days with merge window
> about to open seems to be in the "a bit intrusive" category
> to me :)
>
> Probably some of these changes should be reverted?

It is in -next, but I'm not planning to send to Linus this cycle.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
