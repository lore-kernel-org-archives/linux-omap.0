From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 0/3] ARM: OMAP2+: wkup_m3_rproc support patches
Date: Thu, 9 Jul 2015 14:51:07 -0500
Message-ID: <559ED0AB.4020703@ti.com>
References: <1427917630-43961-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427917630-43961-1-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Tony,
On 04/01/2015 02:47 PM, Dave Gerlach wrote:
> This series adds the mach-omap2 code and DT nodes for v3 of the
> wkup_m3_rproc driver submitted here [1]. pdata-quirks patch requires
> the pdata added with patch 4 of the aforementioned series. Based on
> previous discussion here [2], the wkup_m3 DT node has been moved as a
> child of the l4_wkup as is done for l4_wkup components in Tero Kristo's
> series "PRCM+SCM cleanup against 4.0-rc1" found here [3]. Because of that,
> this series applies cleanly on top of that series in order to leverage the
> l4_wkup parent node introduced there.
> 
> In addition to the move of the wkup_m3 node for am33xx, a new patch
> has been added to introduce the wkup_m3 node in the same fashion for
> am43xx as both SoCs use the same configuration. With this change
> support was also added to pdata-quirks for passing reset handlers to
> the driver for the am43xx binding as was already done for am33xx.
> 
> I have pushed a branch containing all patches for am335x suspend
> here for a big picture view of how all patches fit together with
> these wkup_m3_rproc series [4].
> 
> v2->v3:
> -Change ti,am3353-wkup-m3 compat to ti,am3352-wkup-m3 to reflect
>  binding documentation change
> -Add ti,am4372-wkup-m3 node to am4372 SoC dt file
> -Add am4372 support to pdata-quirks for reset handlers

Now that Ohad has sent a pull request for the wkup_m3_rproc driver [1] and it
has been merged is it possible for this series with the DT nodes and pdata-quirk
to get picked up? Let me know and I can rebase and resend if you'd like.

Regards,
Dave

[1] https://lkml.org/lkml/2015/7/1/354

> 
> Regards,
> Dave
> 
> [1] https://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg115869.html
> [2] http://www.spinics.net/lists/linux-omap/msg116366.html
> [3] http://www.spinics.net/lists/arm-kernel/msg409842.html
> [4] https://github.com/dgerlach/linux-pm/tree/pm-v4.0-rc5-am335x-suspend
> 
> Dave Gerlach (1):
>   ARM: OMAP2+: Use pdata-quirks for wkup_m3 reset management
> 
> Suman Anna (2):
>   ARM: dts: AM33xx: Update and move wkup_m3 node to l4 node
>   ARM: dts: AM4372: Add the wkupm3 rproc node
> 
>  arch/arm/boot/dts/am33xx.dtsi      | 17 +++++++++--------
>  arch/arm/boot/dts/am4372.dtsi      |  9 +++++++++
>  arch/arm/mach-omap2/pdata-quirks.c | 15 +++++++++++++++
>  3 files changed, 33 insertions(+), 8 deletions(-)
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
