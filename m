From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: Enable addition power management
Date: Fri, 8 Nov 2019 15:23:32 -0600
Message-ID: <CAHCN7xL3h4r3eTmJj_+jEy0NPwkPfP8qjLpuNjjoKQkq9gqdow@mail.gmail.com>
References: <20191108205954.20136-1-aford173@gmail.com> <20191108211717.GR5610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191108211717.GR5610@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Adam Ford <adam.ford@logicpd.com>, Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@verdurent.com>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 8, 2019 at 3:17 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Adam Ford <aford173@gmail.com> [191108 21:00]:
> > +static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
> > +                               unsigned long cmd, void *v);
> >
> >  /***   Helper functions to access registers and their bitfields   ***/
> >
> > @@ -1025,6 +1033,9 @@ int ti_bandgap_probe(struct platform_device *pdev)
> >               }
> >       }
> >
> > +     bgp->nb.notifier_call = bandgap_omap_cpu_notifier;
> > +     cpu_pm_register_notifier(&bgp->nb);
> > +
>
> Hmm looks like you're missing the related call to
> cpu_pm_unregister_notifier(), right?

Good catch.  I'm new to this PM stuff.  :-)

>
> Other than that, it also works on droid4, so please
> feel free to add:

Awesome!

>
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Tony Lindgren <tony@atomide.com>

Thank you.  I have already resent V2

adam

>
