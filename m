From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/1] ARM: dts: dra72x-evm: Enable CPSW and MDIO
Date: Mon, 10 Nov 2014 14:33:51 -0800
Message-ID: <20141110223351.GZ31454@atomide.com>
References: <1415008693-28552-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415008693-28552-1-git-send-email-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org> [141103 01:59]:
> Adding CPSW phy-id, CPSW and MDIO pinmux configuration for active and
> sleep states and enable them in board evm dts file.
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
> ---
> 
> Adding device tree entry for CPSW to make it work in Switch mode.
> Patches are tested on top of Nishanth's PM tree for v3.17 [1] and pushed
> my tree to [2].
> 
> Did a boot test with CPSW and ping test with suspend/resume, the boot logs
> on DRA72x EVM are posted at [3]
> 
> This patch depends on the DRA7xx CPSW support patch series [4] and one driver
> patch (47276fc drivers: net:cpsw: fix probe_dt when only slave 1 is pinned out)
> which is already present in linux-next

Applying into omap-for-v3.19/dt thanks.

Tony
 
> [1] git://github.com/nmenon/linux-2.6-playground.git testing/v3.17/cpu-idle-suspend-dra7-omap5-framework
> [2] git://git.ti.com/~mugunthanvnm/ti-linux-kernel/linux.git for-v3.19/dra72-evm-cpsw
> [3] http://pastebin.ubuntu.com/8800549/
> [4] http://comments.gmane.org/gmane.linux.kernel/1810171
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
