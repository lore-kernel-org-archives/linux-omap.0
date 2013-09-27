From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 0/9] omap hwspinlock dt support
Date: Fri, 27 Sep 2013 10:48:26 -0500
Message-ID: <5245A8CA.4020805@ti.com>
References: <cover.1379445653.git.s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1379445653.git.s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09/17/2013 02:30 PM, Suman Anna wrote:
> Hi,
> 
> This is an updated series for adding the device tree support to
> the OMAP hwspinlock driver. The series is based on 3.12-rc1, and
> includes patches on hwspinlock driver, OMAP hwmod data files and
> OMAP DTS files. The updated series adds new patches to enable the
> hwspinlock driver on OMAP5 and AM335x SoCs as well.
> 
> Tested this on Panda4, BeagleBone Black and OMAP5 uEVM (with
> out-of-tree clock patches from Tero).

Ohad, Benoit,
A gentle reminder - can you please provide your review comments on these
patches. I am hoping that this series can make it to 3.13.

Paul,
The hwmod data patches needs to be merged only after the respective DT
node patches are merged, without which the hwmod entry will not have a
base address while enabling and idling (using sysc) the hwmod during
hwmod initialization.

regards
Suman

> 
> Changes new in v2:
> - Added a new common DT binding documentation and OF helpers (Patch1),
>   addressing the review comments from v1 [2]. The MSM support [1] needs
>   to be reworked on top of this common patch. 
> - Revised OMAP DT parse support to use the new OF helper (Patch2)
> - OMAP5 hwspinlock support including the hwmod entry and DT node (Patches 4, 5)
> - Add AM335x support to OMAP hwspinlock driver, including a fix
>   needed in driver given that AM335 spinlock module requires s/w wakeup
>   (Patches 6, 7)
> - AM335 DT node for spinlock, and a hwmod change to enable smart-idle
>   for AM335 (Patches 8, 9). The sysc patch is not essential for AM335
>   spinlock functionality, but is needed for smart-idling the IP when
>   the module is enabled.
> - OMAP4 DT node patch is unchanged (Patch 3)
> 
> v1:
> - Add DT parse support to OMAP hwspinlock driver
> - Add OMAP4 DT node and bindings information
> http://marc.info/?l=linux-omap&m=137823082308009&w=2
> 
> [1] https://lkml.org/lkml/2013/8/14/528
> [2] http://marc.info/?t=137823090300005&r=1&w=2
> 
> 
> Suman Anna (9):
>   hwspinlock/core: add common dt bindings and OF helpers
>   hwspinlock/omap: add support for dt nodes
>   ARM: dts: OMAP4: Add hwspinlock node
>   ARM: OMAP5: hwmod data: Add spinlock data
>   ARM: dts: OMAP5: Add hwspinlock node
>   hwspinlock/omap: support AM33xx
>   hwspinlock/omap: enable module before reading SYSSTATUS register
>   ARM: dts: AM33XX: Add hwspinlock node
>   ARM: AM33xx: hwmod_data: add the sysc configuration for spinlock
> 
>  .../devicetree/bindings/hwlock/hwlock.txt          | 26 +++++++++
>  .../devicetree/bindings/hwlock/omap-hwspinlock.txt | 31 +++++++++++
>  arch/arm/boot/dts/am33xx.dtsi                      |  6 +++
>  arch/arm/boot/dts/omap4.dtsi                       |  6 +++
>  arch/arm/boot/dts/omap5.dtsi                       |  6 +++
>  arch/arm/mach-omap2/Makefile                       |  3 --
>  arch/arm/mach-omap2/hwspinlock.c                   | 60 ---------------------
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c         | 13 +++++
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c         | 44 ++++++++++++++++
>  drivers/hwspinlock/Kconfig                         |  2 +-
>  drivers/hwspinlock/hwspinlock_core.c               | 61 +++++++++++++++++++++-
>  drivers/hwspinlock/omap_hwspinlock.c               | 44 ++++++++++++----
>  include/linux/hwspinlock.h                         | 11 ++--
>  13 files changed, 233 insertions(+), 80 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwlock/hwlock.txt
>  create mode 100644 Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
>  delete mode 100644 arch/arm/mach-omap2/hwspinlock.c
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
