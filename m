From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/2] Add DRA7xx CPSW Ethernet support in Device Tree
Date: Wed, 10 Sep 2014 09:01:24 -0500
Message-ID: <541059B4.50205@ti.com>
References: <1410356247-25925-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410356247-25925-1-git-send-email-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09/10/2014 08:37 AM, Mugunthan V N wrote:
> Adding device tree entry for CPSW to make it work in Dual EMAC mode.
> These patches were tested with DRA7 hwmod patches on top of linux-next.
> Patches are tested on top of Nishanth's PM tree for v3.17 [1] and pushed
> my tree to [2].
> 
> Did a boot test with CPSW and ping test with suspend/resume, the boot logs
> on DRA7xx EVM are posted at [3]
> 
> [1] git://github.com/nmenon/linux-2.6-playground.git testing/v3.17/cpu-idle-suspend-dra7-omap5-framework
> [2] git://git.ti.com/~mugunthanvnm/ti-linux-kernel/linux.git v3.17/dra7-evm-cpsw
> [3] http://pastebin.ubuntu.com/8309289/
> 
> Changes from initial version:
> * Dropped patch for pinoff states
> * Changed pinoff state to mode15
> 
> Mugunthan V N (2):
>   ARM: dts: dra7: Add CPSW and MDIO module nodes for dra7
>   ARM: dts: dra7-evm: Enable CPSW and MDIO for dra7xx EVM
> 
>  arch/arm/boot/dts/dra7-evm.dts | 107 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/dra7.dtsi    |  59 +++++++++++++++++++++++
>  2 files changed, 166 insertions(+)
> 
I did apply these on Tony's
"omap-for-v3.18/dt 6e55426 Merge branch .."
they do apply.

However: why are we not sending dra72-evm.dts changes in the same
series since we claim it to be dra7xx support?

Also, in your tests (http://pastebin.ubuntu.com/8309289/)
echo -n "20">/sys/kernel/debug/pm_debug/wakeup_timer_seconds
ping 172.24.188.1  & (or even better do a transfer of large file in
background)
echo mem > /sys/power/state

transfer/ping should resume seamlessly. (only thing you should be
careful is that the server should not timeout for 20 second inactivity)..

It is a valid test to verify peripheral activity after resume, BUT,
equally important is to verify suspend-resume in the middle of activity.

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
