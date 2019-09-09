From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: ti-cpufreq: Add support for AM3517
Date: Mon, 9 Sep 2019 13:17:29 -0500
Message-ID: <CAHCN7xLfOo7xsmDq5ZuPZsh02pjKx3w9FkJGN6AowJoHkRrWmg@mail.gmail.com>
References: <20190909154502.19804-1-aford173@gmail.com> <6081134F-AACD-412C-B36A-BF9463C9712B@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6081134F-AACD-412C-B36A-BF9463C9712B@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, =?UTF-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Andreas Kemnade <andreas@kemnade.info>, Tony Lindgren <tony@atomide.com>, Adam Ford <adam.ford@logicpd.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 9, 2019 at 1:13 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Hi Adam,
>
> > Am 09.09.2019 um 17:45 schrieb Adam Ford <aford173@gmail.com>:
> >
> > The AM3517 only lists 600MHz @ 1.2V, but the revister values for
>
> a small typo...
>
> s/revister/register/
>
> > 0x4830A204 = 1b86 802f, it seems like am3517 might be a derivative
> > of the omap36 which has OPPs would be OPP50 (300 MHz) and OPP100
> > (600 MHz).
> >
> > This patch simply enable adds the am3517 to the compatible table
> > using the omap3630 structure instead of the 3430.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> > index f2f58d689320..6b69fb1d6bdf 100644
> > --- a/drivers/cpufreq/ti-cpufreq.c
> > +++ b/drivers/cpufreq/ti-cpufreq.c
> > @@ -270,6 +270,7 @@ static int ti_cpufreq_setup_syscon_register(struct ti_cpufreq_data *opp_data)
> >
> > static const struct of_device_id ti_cpufreq_of_match[] = {
> >       { .compatible = "ti,am33xx", .data = &am3x_soc_data, },
> > +     { .compatible = "ti,am3517", .data = &omap36xx_soc_data, },
> >       { .compatible = "ti,am43", .data = &am4x_soc_data, },
> >       { .compatible = "ti,dra7", .data = &dra7_soc_data },
> >       { .compatible = "ti,omap34xx", .data = &omap34xx_soc_data, },
> > --
> > 2.17.1
> >
>
> Looks good to me.
>
> Should I include your two patches to my patch set (and resend)?
> Or should we keep them separated?

Go ahead and take credit for them.  I just did what you told me to do
and tested them.
Go ahead and mark it as Tested-by with my name.

adam
>
> BR and thanks,
> Nikolaus
>
