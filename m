From: Venu Byravarasu <vbyravarasu@nvidia.com>
Subject: Re: [PATCH] rtc: kconfig: fix RTC_INTF defaults connected to RTC_CLASS
Date: Wed, 10 Oct 2012 10:27:53 +0530
Message-ID: <50750051.10701@nvidia.com>
References: <1349827784-8646-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349827784-8646-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 10 October 2012 05:39 AM, Kevin Hilman wrote:
> From: Kevin Hilman <khilman@ti.com>
>
> commit 6b8029fab64164b5895d58d23229b75c82e3a6fc (rtc: kconfig: remove
> unnecessary dependencies) removed various 'depends on RTC_CLASS'
> dependencies but also removed a few 'default RTC_CLASS' statements,
> which actually changed default behavior.
>
> This resulted in the various RTC interfaces (sysfs, proc, dev) all
> being disabled by default, even when RTC_CLASS is enabled:
>
>     # CONFIG_RTC_INTF_SYSFS is not set
>     # CONFIG_RTC_INTF_PROC is not set
>     # CONFIG_RTC_INTF_DEV is not set
>
> which is different from previous behavior (all of these where enabled.)
>
> To fix, add back the 'default RTC_CLASS' statments to each of the
> RTC_INTF_* options.
Thanks for fixing this.
>   config RTC_INTF_DEV
>   	boolean "/dev/rtcN (character devices)"
> +	default RTC_CLASS
>   	help
>   	  Say yes here if you want to use your RTCs using the /dev
>   	  interfaces, which "udev" sets up as /dev/rtc0 through
Acked-by: Venu Byravarasu <vbyravarasu@nvidia.com>
