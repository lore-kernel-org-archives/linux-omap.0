From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v2 0/2] ti-cpufreq: minor fixes/cleanups
Date: Fri, 18 May 2018 10:07:12 -0500
Message-ID: <ffbb49c3-229b-df20-ca0d-c49822fcdaf2@ti.com>
References: <20180402164958.20057-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180402164958.20057-1-s-anna@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/02/2018 11:49 AM, Suman Anna wrote:
> Hi Viresh,
> 
> Please find the updated series replacing the previous patch [1] fixing
> couple of issues in the TI CPUFreq driver. I have split up the patches
> as per your comments on v1. Final code diff remains the same as before.
> 
> regards
> Suman
> 
> [1] https://patchwork.kernel.org/patch/10308925/
> 
> Suman Anna (2):
>   cpufreq: ti-cpufreq: Fix an incorrect error return value
>   cpufreq: ti-cpufreq: Use devres managed API in probe()

Gentle reminder, I don't see these patches in -next. Who is picking up
these patches?

regards
Suman

> 
>  drivers/cpufreq/ti-cpufreq.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
