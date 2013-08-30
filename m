From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 02/10] cpufreq: OMAP: Add SMP support for OMAP4+
Date: Fri, 30 Aug 2013 09:26:12 -0400
Message-ID: <52209D74.1050308@ti.com>
References: <1316725648-26710-1-git-send-email-khilman@ti.com> <1316725648-26710-3-git-send-email-khilman@ti.com> <CAOh2x=k11EivJoy5-PMXnE5JGDc=DcJKhae7qoh6tNc4L63VnA@mail.gmail.com> <521F4E88.1000709@ti.com> <CAKohpokqz0cQNS12hZS-YOCd8KSOtCy9_TbGdqFzCYz8NyeamQ@mail.gmail.com> <521F4FBB.3080002@ti.com> <CAKohpomco=TodaosVbvAhFSxrth9aZ1gh+VOHftG1w6nYWBsPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomco=TodaosVbvAhFSxrth9aZ1gh+VOHftG1w6nYWBsPg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@linaro.org>, Russell King <linux@arm.linux.org.uk>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Dave Jones <davej@redhat.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

> From: Viresh Kumar <viresh.kumar@linaro.org <mailto:viresh.kumar@linaro.org>>
> Date: Wed, 21 Aug 2013 19:05:05 +0530
> Subject: [PATCH] cpufreq: omap: use cpufreq_generic_init() routine
> 
> Use generic cpufreq_generic_init() routine instead of replicating the same code
> here.
> 
> This also rearranges the code a bit to make it more sensible. Also removes some
> unnecessary checks.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org <mailto:viresh.kumar@linaro.org>>
> ---
>  drivers/cpufreq/omap-cpufreq.c | 41 +++++++++++------------------------------
>  1 file changed, 11 insertions(+), 30 deletions(-)
>
I haven't tested it but looks straightforward so..
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

