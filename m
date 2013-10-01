From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/7] DRA7: DT thermal support
Date: Tue, 1 Oct 2013 17:58:48 -0500
Message-ID: <20131001225848.GA12365@kahuna>
References: <1380652344-18819-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380652344-18819-1-git-send-email-eduardo.valentin-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 14:32-20131001, Eduardo Valentin wrote:
> Hello all,
> 
> This is a complementary patch series with themal DT support for DRA7.
> 
> Although this work depends on the thermal dt parser work [1], I decided
> to share it before hand. It also depends on DRA7 DT base port support,
> which I fetched from Rajendra's tree [2].
> 
> This patch series has been runtime tested on DRA7-evm.
> 
> All best,
> 
> [1] - https://lkml.org/lkml/2013/9/26/787
> [2] - git://github.com/rrnayak/linux.git out-of-tree/dra-integrated-v3
> 
> Eduardo Valentin (7):
>   arm: dts: add dra7 DSPEVE thermal data
>   arm: dts: add dra7 IVA thermal data
>   arm: dts: dra7: add bandgap entry
>   arm: dts: add cooling properties on dra7 cpu node
>   arm: dts: dra7: add thermal data
>   arm: dts: add tmp102 i2c sensor node on dra7-evm
>   arm: dts: add thermal zones info on tmp102 for DRA7-EVM
> 
>  arch/arm/boot/dts/dra7-dspeve-thermal.dtsi | 28 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/dra7-evm.dts             | 23 +++++++++++++++++++++++
>  arch/arm/boot/dts/dra7-iva-thermal.dtsi    | 28 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/dra7.dtsi                | 27 ++++++++++++++++++++++++++-
>  4 files changed, 105 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
>  create mode 100644 arch/arm/boot/dts/dra7-iva-thermal.dtsi

+Benoit, Tony, Linux-omap.
Ref: http://marc.info/?l=linux-pm&m=138065243027014&w=2

Tony, Benoit,
The following diff[1] is probably needed to ensure that right audience
is addressed.

Eduardo,
could you send an updated series with Tony,
Benoit and linux-omap in the loop?

[1]
diff --git a/MAINTAINERS b/MAINTAINERS
index 284969f..3442671 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5969,6 +5969,7 @@ M:	Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
 L:	linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 L:	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
+F:	arch/arm/boot/dts/*dra7*
 F:	arch/arm/boot/dts/*omap*
 F:	arch/arm/boot/dts/*am3*
 
-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
