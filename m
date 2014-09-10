From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [GIT PULL] ARM: dts: OMAP5 / DRA7: pinctrl updates
Date: Wed, 10 Sep 2014 02:29:49 +0000
Message-ID: <20140910022949.GB1058@atomide.com>
References: <1410271178-28336-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410271178-28336-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Beno??t Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [140909 14:00]:
> 
> Hi Tony,
> 
> Please pull this series was posted[1] and based on the previous pulls
> [2] [3], updating the dts to enable the relevant feature.
> 
> NOTE: I have dropped patch #1 of the series based on [4].
> 
> These could go to your branch omap-for-v3.18/dt
> 
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>   https://github.com/nmenon/linux-2.6-playground.git pull/v3.18/for-dt-pinctrl-updates
> 
> for you to fetch changes up to 66b0436977e2c62388d48836ff784f1fedb49c4f:
> 
>   ARM: dts: dra7-evm: Mark uart1 rxd as wakeup capable (2014-09-09 08:33:29 -0500)

Thanks pulling into omap-for-v3.18/dt.

Tony
 
> ----------------------------------------------------------------
> Nishanth Menon (5):
>       ARM: dts: OMAP5: switch to compatible pinctrl
>       ARM: dts: DRA7: switch to compatible pinctrl
>       ARM: dts: AM437x: switch to compatible pinctrl
>       ARM: dts: OMAP5 / DRA7: switch over to interrupts-extended property for UART
>       ARM: dts: dra7-evm: Mark uart1 rxd as wakeup capable
> 
>  arch/arm/boot/dts/am4372.dtsi  |    4 +++-
>  arch/arm/boot/dts/dra7-evm.dts |    2 ++
>  arch/arm/boot/dts/dra7.dtsi    |   24 +++++++++++++-----------
>  arch/arm/boot/dts/omap5.dtsi   |   20 ++++++++++++--------
>  4 files changed, 30 insertions(+), 20 deletions(-)
> 
> [1] http://marc.info/?l=linux-kernel&m=140871681606779&w=2
> [2] http://marc.info/?l=linux-kernel&m=141019565513129&w=2
> [3] http://marc.info/?l=linux-kernel&m=141019566913133&w=2
> [4] http://marc.info/?l=linux-omap&m=141022429924564&w=2
> 
> Regards,
> Nishanth Menon
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
