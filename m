From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt-platdev: Add devices covered by ti-cpufreq to blacklist
Date: Tue, 19 Sep 2017 08:02:19 -0700
Message-ID: <CAKohpo=8BBdoxLEzBHqy=jtcxhfy_7SC4Ez-qjPNoQWz=pN4qA@mail.gmail.com>
References: <20170919145730.8981-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170919145730.8981-1-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 19 September 2017 at 07:57, Dave Gerlach <d-gerlach@ti.com> wrote:
> Commit edeec420de24 ("cpufreq: dt-platdev: Automatically create cpufreq
> device with OPP v2") causes a cpufreq-dt platform device to be
> automatically created for any platform with an OPP v2 node defined.
> However, ti-cpufreq registers the cpufreq-dt platdev at the end of probe
> in order to ensure the ti-cpufreq driver probes first and provides the
> necessary opp-supported-hw for cpufreq-dt. With this new patch now a
> dupluicate cpufreq-dt is created, which we do not want. To avoid this,
> add the platforms handled by ti-cpufreq to the blacklist provided in the
> aforementioned commit to allow ti-cpufreq to continue creating the
> cpufreq-dt platdev.
>
> This applies to am335x, am437x, dra7xx, and am57xx.
>
> Fixes: edeec420de24 ("cpufreq: dt-cpufreq: platdev Automatically create device with OPP v2")
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index a020da7940d6..c6f554ba9bb3 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -106,6 +106,10 @@ static const struct of_device_id whitelist[] __initconst = {
>   * platforms using "operating-points-v2" property.
>   */
>  static const struct of_device_id blacklist[] __initconst = {
> +       { .compatible = "ti,am33xx", },
> +       { .compatible = "ti,am43", },
> +       { .compatible = "ti,dra7", },
> +
>         { }
>  };

Perhaps you should ask Sunil to improve his patch.

https://marc.info/?l=linux-kernel&m=150576233031387&w=2
