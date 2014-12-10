From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM: dts: dra7-evm: Regulator max voltage fixes
Date: Wed, 10 Dec 2014 08:47:35 -0800
Message-ID: <20141210164734.GE30437@atomide.com>
References: <1417608237-12258-1-git-send-email-rk@ti.com>
 <547F0A57.7040806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <547F0A57.7040806-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Ravikumar Kattekola <rk-l0cyMroinI0@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [141203 05:06]:
> On 12/03/2014 06:03 AM, Ravikumar Kattekola wrote:
> > Hi,
> > 
> > This set does a minor fix and an update:
> > 
> >    - Fix a typo in the max voltage property of smps6 (vdd_gpu) regulator node added by
> >      the patch : c56a831ca47e ("ARM: dts: DRA7: Add TPS659038 PMIC nodes")
> > 
> >    - Update max voltage property of smps7 (vdd_core) regulator node to align with the 
> >      latest Data Manual
> > 
> > Regards,
> > RK
> > 
> > Ravikumar Kattekola (2):
> >   ARM: dts: dra7-evm: Fix typo in SMPS6 (VDD_GPU) max voltage
> >   ARM: dts: dra7-evm: Update SMPS7 (VDD_CORE) max voltage to match DM
> > 
> >  arch/arm/boot/dts/dra7-evm.dts  |    4 ++--
> >  arch/arm/boot/dts/dra72-evm.dts |    2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> These apply to
> 
> https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v3.19/dt-v2
> 
> Acked-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

Applying both into omap-for-v3.19/fixes thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
