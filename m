From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: Convert printk(KERN_<LEVEL> to pr_<level>
Date: Wed, 6 Apr 2016 11:50:47 +0530
Message-ID: <20160406062047.GT20655@vireshk-i7>
References: <cover.1459887986.git.joe@perches.com>
 <d85c4c927332ecd07d44990b5cb09280a9889f97.1459887986.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d85c4c927332ecd07d44990b5cb09280a9889f97.1459887986.git.joe@perches.com>
Sender: linux-pm-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05-04-16, 13:28, Joe Perches wrote:
> Use the more common logging style.
> 
> Miscellanea:
> 
> o Coalesce formats
> o Realign arguments
> o Add a missing space between a coalesced format
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c            | 10 ++--
>  drivers/cpufreq/cpufreq-nforce2.c         | 24 ++++------
>  drivers/cpufreq/e_powersaver.c            | 60 ++++++++++-------------
>  drivers/cpufreq/elanfreq.c                |  2 +-
>  drivers/cpufreq/ia64-acpi-cpufreq.c       |  9 ++--
>  drivers/cpufreq/longhaul.c                | 80 +++++++++++++------------------
>  drivers/cpufreq/loongson2_cpufreq.c       |  2 +-
>  drivers/cpufreq/maple-cpufreq.c           |  9 ++--
>  drivers/cpufreq/omap-cpufreq.c            |  4 +-
>  drivers/cpufreq/p4-clockmod.c             | 15 ++----
>  drivers/cpufreq/pmac32-cpufreq.c          | 12 ++---
>  drivers/cpufreq/pmac64-cpufreq.c          | 43 ++++++++---------
>  drivers/cpufreq/powernow-k6.c             | 13 ++---
>  drivers/cpufreq/powernow-k7.c             | 65 ++++++++++---------------
>  drivers/cpufreq/pxa2xx-cpufreq.c          |  7 ++-
>  drivers/cpufreq/s3c2412-cpufreq.c         | 13 +++--
>  drivers/cpufreq/s3c2440-cpufreq.c         |  4 +-
>  drivers/cpufreq/s3c24xx-cpufreq-debugfs.c |  2 +-
>  drivers/cpufreq/s3c24xx-cpufreq.c         | 57 +++++++++++-----------
>  drivers/cpufreq/s5pv210-cpufreq.c         |  4 +-
>  drivers/cpufreq/sc520_freq.c              |  6 +--
>  drivers/cpufreq/speedstep-centrino.c      |  3 +-
>  drivers/cpufreq/speedstep-ich.c           |  6 +--
>  drivers/cpufreq/speedstep-lib.c           |  9 ++--
>  drivers/cpufreq/speedstep-smi.c           |  5 +-
>  25 files changed, 199 insertions(+), 265 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
