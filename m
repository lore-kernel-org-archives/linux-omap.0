From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V6 00/15] ARM: OMAP3+: support cpufreq-cpu0 for device
 tree boot
Date: Wed, 9 Oct 2013 18:31:44 -0500
Message-ID: <5255E760.8010104@ti.com>
References: <1381354144-7134-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381354144-7134-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@linaro.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/09/2013 04:28 PM, Nishanth Menon wrote:
> Hi,
> 
> The series is based on Tero's V8 of patches[1] - enables the use of
> cpufreq-cpu0 generic driver for all OMAP and related derivatives.
> 
> I will stop copy pasting the series complete history and point at [2].
> 
> Main changes since V5:
> - no more clock driver as part of this series[3] - instead depend on clock
>   conversion[1].
> - added DRA7/OMAP5
> 

I am having all kind of problems with my git mail setup atm -
apologies if any patches have arrived twice/in weird sequence :(


-- 
Regards,
Nishanth Menon
