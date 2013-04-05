From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V3 2/2] cpufreq: OMAP: instantiate omap-cpufreq as a
 platform_driver
Date: Fri, 5 Apr 2013 16:36:15 -0500
Message-ID: <20130405213614.GA8594@kahuna>
References: <1364507576-19345-1-git-send-email-nm@ti.com>
 <1364507576-19345-3-git-send-email-nm@ti.com>
 <CAOh2x=mdzfyMoGuavrMFgkDgMt=ihxdxa_HG1T8ehfSa1W7j7Q@mail.gmail.com>
 <20130405170707.GA7361@kahuna>
 <871uaoll0h.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <871uaoll0h.fsf@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-omap@vger.kernel.org, Rob Herring <robherring2@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Keerthy <j-keerthy@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-omap@vger.kernel.org

On 14:34-20130405, Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
> > On 08:29-20130329, Viresh Kumar wrote:
> >> On Fri, Mar 29, 2013 at 3:22 AM, Nishanth Menon <nm@ti.com> wrote:
[...]
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Since this patch could be merged independently to help multi-platform
> > builds, While the omap community discusses:
> > http://marc.info/?t=136450773400004&r=1&w=2
> > http://marc.info/?t=136370325600009&r=1&w=2&n=7
> >
> > To enable cpufreq-cpu0 driver in DT mode, I wonder if we could queue this up
> > for 3.10.
> 
> Yes, I've queued this one for v3.10.  Working on getting some pull
> requests out to Tony today.
Thanks. I will hold off posting v4 of
https://patchwork.kernel.org/patch/2394591/ until the said discussions
on clock nodes are concluded in some form for 3.10 or so.
-- 
Regards,
Nishanth Menon
