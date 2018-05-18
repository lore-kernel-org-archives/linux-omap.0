From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/2] ti-cpufreq: minor fixes/cleanups
Date: Fri, 18 May 2018 22:19:58 +0200
Message-ID: <2808028.7H1yeuone6@aspire.rjw.lan>
References: <20180402164958.20057-1-s-anna@ti.com> <ffbb49c3-229b-df20-ca0d-c49822fcdaf2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ffbb49c3-229b-df20-ca0d-c49822fcdaf2@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday, May 18, 2018 5:07:12 PM CEST Suman Anna wrote:
> On 04/02/2018 11:49 AM, Suman Anna wrote:
> > Hi Viresh,
> > 
> > Please find the updated series replacing the previous patch [1] fixing
> > couple of issues in the TI CPUFreq driver. I have split up the patches
> > as per your comments on v1. Final code diff remains the same as before.
> > 
> > regards
> > Suman
> > 
> > [1] https://patchwork.kernel.org/patch/10308925/
> > 
> > Suman Anna (2):
> >   cpufreq: ti-cpufreq: Fix an incorrect error return value
> >   cpufreq: ti-cpufreq: Use devres managed API in probe()
> 
> Gentle reminder, I don't see these patches in -next. Who is picking up
> these patches?

You need to resend them I'm afraid, with any tags received so far.

And they won't be picked up if you don't CC linux-pm@vger.kernel.org on
the submission.

Thanks,
Rafael
