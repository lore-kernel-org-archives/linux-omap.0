From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Latest build results - errors/warnings - lots of them
Date: Thu, 2 May 2013 20:03:26 +0200
Message-ID: <201305022003.27037.arnd@arndb.de>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk> <20130502153834.GR28721@atomide.com> <51829D65.7040109@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:50586 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213Ab3EBSEA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 May 2013 14:04:00 -0400
In-Reply-To: <51829D65.7040109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Neil Brown <neilb@suse.de>, Nicolas Pitre <nico@fluxnic.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Durgadoss R <durgadoss.r@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

On Thursday 02 May 2013, Eduardo Valentin wrote:
> index e3c0ae9..e3f3cba 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -250,12 +250,6 @@ void thermal_unregister_governor(struct
> thermal_governor *);
>  #ifdef CONFIG_NET
>  extern int thermal_generate_netlink_event(struct thermal_zone_device *tz,
>                                                 enum events event);
> -#else
> -static int thermal_generate_netlink_event(struct thermal_zone_device *tz,
> -                                               enum events event)
> -{
> -       return 0;
> -}
>  #endif

Actually it seems this bug is already fixed in linux-next:

commit f8b587055a793c7719f0d4f41b7b4aeeef43aa2d
Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Date:   Wed Mar 20 21:38:07 2013 +0000

    thermal: Fix compiler warning
    
    The following warning is obtained when CONFIG_NET is not defined:
    
    In file included from drivers/thermal/mvebu_thermal.c:27:0:
    include/linux/thermal.h:254:12: warning: 'thermal_generate_netlink_event'
    defined but not used [-Wunused-function]
    
    This patch fixes the warning by properly inlining
    thermal_generate_netlink_event().
    
    Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index f0bd7f9..fd7b8f3 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -251,7 +251,7 @@ void thermal_unregister_governor(struct thermal_governor *);
 extern int thermal_generate_netlink_event(struct thermal_zone_device *tz,
                                                enum events event);
 #else
-static int thermal_generate_netlink_event(struct thermal_zone_device *tz,
+static inline int thermal_generate_netlink_event(struct thermal_zone_device *tz,
                                                enum events event)
 {
        return 0;


Your patch also seems correct, but it would conflict with Ezequiel's.
The problem was apparently that you removed the 'inline' keyword
in 8ab3e6a08a "thermal: Use thermal zone device id in netlink messages",
I assume by accident, since defining a non-inline function in a header
file is obviously wrong.

	Arnd
