From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: dt: allow driver to boot automatically
Date: Sat, 9 May 2015 07:59:51 +0530
Message-ID: <CAKohpom6s4FJ=BSZq388xszLDC6Pz876vSgTzyo_EHdaxkSGjw@mail.gmail.com>
References: <1431115050-23693-1-git-send-email-balbi@ti.com>
	<1431115050-23693-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1431115050-23693-2-git-send-email-balbi@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 9 May 2015 at 01:27, Felipe Balbi <balbi@ti.com> wrote:
> by adding the missing MODULE_ALIAS(), cpufreq-dt
> can be autoloaded by udev/systemd.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
