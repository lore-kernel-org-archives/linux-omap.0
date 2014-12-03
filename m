From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM: dts: dra7-evm: Regulator max voltage fixes
Date: Wed, 3 Dec 2014 07:04:23 -0600
Message-ID: <547F0A57.7040806@ti.com>
References: <1417608237-12258-1-git-send-email-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417608237-12258-1-git-send-email-rk-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ravikumar Kattekola <rk-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 12/03/2014 06:03 AM, Ravikumar Kattekola wrote:
> Hi,
> 
> This set does a minor fix and an update:
> 
>    - Fix a typo in the max voltage property of smps6 (vdd_gpu) regulator node added by
>      the patch : c56a831ca47e ("ARM: dts: DRA7: Add TPS659038 PMIC nodes")
> 
>    - Update max voltage property of smps7 (vdd_core) regulator node to align with the 
>      latest Data Manual
> 
> Regards,
> RK
> 
> Ravikumar Kattekola (2):
>   ARM: dts: dra7-evm: Fix typo in SMPS6 (VDD_GPU) max voltage
>   ARM: dts: dra7-evm: Update SMPS7 (VDD_CORE) max voltage to match DM
> 
>  arch/arm/boot/dts/dra7-evm.dts  |    4 ++--
>  arch/arm/boot/dts/dra72-evm.dts |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
These apply to

https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v3.19/dt-v2

Acked-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
