From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/4] pinctrl: Introduce generic #pinctrl-cells and
 pinctrl_parse_index_with_args
Date: Tue, 8 Nov 2016 07:44:49 -0700
Message-ID: <20161108144449.GI2428@atomide.com>
References: <20161103163550.27330-1-tony@atomide.com>
 <20161103163550.27330-2-tony@atomide.com>
 <CACRpkdaCF4Jc7QY+L44obce=V_W4xgVbPXfuiE7bXJs7ud9q9A@mail.gmail.com>
 <20161107152613.GA2428@atomide.com>
 <CACRpkdbdfM8qtMSE1O-VEsnOHGbVuMDhOFtELvqoYuE1JJ=GRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbdfM8qtMSE1O-VEsnOHGbVuMDhOFtELvqoYuE1JJ=GRg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [161108 03:32]:
> On Mon, Nov 7, 2016 at 4:26 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > * Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [161104 14:50]:
> 
> >> +struct of_phandle_args;
> >> +
> >>  #ifdef CONFIG_OF
> >>
> >> Let's see if it works!
> >
> > OK so do we know now? It seems there was one more email
> > about it but it may have been without it.
> 
> I haven't seen anything, I think it JustWorks(TM).

OK good to to hear :)

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
