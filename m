From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/4] cpufreq: OMAP: if available, scale the iva coprocessor
Date: Wed, 7 Nov 2012 08:42:38 -0600
Message-ID: <509A735E.4080103@ti.com>
References: <1352252861-18384-1-git-send-email-jemele@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1352252861-18384-1-git-send-email-jemele@gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Joshua Emele <jemele@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 06 November 2012 07:47 PM, Joshua Emele wrote:
> The iva coprocessor, available on some omap platforms, shares a voltage domain
> with the mpu. If cpufreq is active and the mpu processor is scaled down, the iva
> coprocessor should also be scaled. The goal is to make sure we do not ramp down
> the voltage on the domain and affect clocking on the iva coprocessor leading to
> a dsp crash.
>
> I only have access to an omap3evm-ish device, so I do not know what the iva
> clock name is for omap24xx and omap44xx. This detail can be added later if the
> general approach is approved.
>
> I have tested a version of this patch against the linux-3.3 kernel, so this my
> attempt at a forward port against the current mainline. I have based my patch
> series against linux-omap-pm/pm-next.
>
How about making use of CPUFREQ notifiers to handle it. I don't like
this series since it adds multi-media co-processor scaling into the
CPUFreq driver.

Regards
Santosh
