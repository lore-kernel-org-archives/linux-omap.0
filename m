From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/3] ARM: OMAP5+: pdata quirks for pinctrl
Date: Mon, 8 Sep 2014 11:32:29 -0500
Message-ID: <540DDA1D.9070903@ti.com>
References: <1408715725-25919-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408715725-25919-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On 08/22/2014 08:55 AM, Nishanth Menon wrote:
> The following series are various fixes and improvements for daisychain
> support in OMAP5+ using pinctrl framework similar to that done for
> OMAP3+
> 
> This is part 3/6 series which eventually enables framework for
> suspend-to-ram and cpuidle for OMAP5 and DRA7
> 
> Each of series is based on v3.17-rc1 and this specific series is available:
> weblink: https://github.com/nmenon/linux-2.6-playground/commits/push/v3.17/prm-pdata-quirks
> 
> git repo: https://github.com/nmenon/linux-2.6-playground.git push/v3.17/prm-pdata-quirks
> 
> An complete integrated branch is available here: https://github.com/nmenon/linux-2.6-playground/commits/testing/v3.17/cpu-idle-suspend-dra7-omap5-framework
> 
> Minor note: thanks to existing style in pdata-quirks, new entries
> continue to possess 'over 80 character' checkpatch warnings
> 
> Keerthy (1):
>   ARM: AM437x: use pdata quirks for pinctrl information
> 
> Nishanth Menon (2):
>   ARM: OMAP5: use pdata quirks for pinctrl information
>   ARM: DRA7: use pdata quirks for pinctrl information
> 
>  arch/arm/mach-omap2/pdata-quirks.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Since there are no further comments (and the pinctrl side of the fixes
were accepted by Linus W[1], will send this for merge to Tony.


[1] http://marc.info/?l=linux-kernel&m=140871666506706&w=2 (acked by
Tony, picked by Linus)

-- 
Regards,
Nishanth Menon
