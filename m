From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [resend PATCH 0/3] Add DRA7xx CPSW Ethernet support in Device
 Tree
Date: Mon, 8 Sep 2014 14:34:40 -0500
Message-ID: <20140908193440.GC12150@kahuna>
References: <1410203998-8700-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410203998-8700-1-git-send-email-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 00:49-20140909, Mugunthan V N wrote:
> Adding device tree entry for CPSW to make it work in Dual EMAC mode.
> 
> These patches were tested with DRA7 hwmod patches on top of linux-next.
> The patches were already reviewed [1] and has been waiting for cross bar
> and hwmod to be pulled in. Now since all dependent patches has already
> pulled in, so reposting the patches again.
> 
> Patches are tested on linux-next, the boot logs on DRA7xx EVM [2]
> 
> [1] https://lkml.org/lkml/2014/5/13/89
> [2] http://slexy.org/view/s2YqO0Wj9b 

Sorry this is now blocked inside TI. could you explain the testing done
for sleep state? did you attempt sleep mode before testing this?

> 
> Mugunthan V N (3):
>   pinctrl: dra7: dt-bindings: add pin off modes for dra7 SoC
>   arm/dts: dra7xx: Add CPSW and MDIO module nodes for dra7xx
>   arm/dts: dra7xx: Enable CPSW and MDIO for dra7xx EVM
> 
>  arch/arm/boot/dts/dra7-evm.dts    | 107 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/dra7.dtsi       |  59 +++++++++++++++++++++
>  include/dt-bindings/pinctrl/dra.h |   8 +++
>  3 files changed, 174 insertions(+)
> 
-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
