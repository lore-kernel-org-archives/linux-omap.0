From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH 06/10] OMAP: PM debug: Add PRCM register dump support
Date: Thu, 13 Aug 2009 13:39:48 -0500
Message-ID: <A24693684029E5489D1D202277BE89444A78397F@dlee02.ent.ti.com>
References: <1250182359-18830-1-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-2-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-3-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-4-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-5-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-6-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-7-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32830 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453AbZHMSgV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 14:36:21 -0400
In-Reply-To: <1250182359-18830-7-git-send-email-khilman@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-arm@vger.kernel.org" <linux-arm@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tero Kristo <tero.kristo@nokia.com>

Kevin,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Thursday, August 13, 2009 11:53 AM
> To: linux-arm-kernel@lists.arm.linux.org.uk; linux-arm@vger.kernel.org
> Cc: linux-omap@vger.kernel.org; Tero Kristo
> Subject: [PATCH 06/10] OMAP: PM debug: Add PRCM register dump support
> 
> From: Tero Kristo <tero.kristo@nokia.com>
> 
> Allows dumping out current register contents from the debug filesystem,
> and
> also allows user to add arbitrary register save points into code. Current
> register contents are available under debugfs at:
> 
> [debugfs]/pm_debug/registers/current
> 
> To add a save point, do following:
> 
> From module init (or somewhere before the save call, called only once):
>   pm_dbg_init_regset(n); // n=1..4, allocates memory for dump area #n
> 
> From arbitrary code location:
>   pm_dbg_regset_save(n); // n=1..4, saves registers to dump area #n
> 
> After this, the register dump can be seen under
> [debugfs]/pm_debug/registers/n
> 
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/pm-debug.c |  208
> ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm.h       |    4 +
>  2 files changed, 212 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 arch/arm/mach-omap2/pm-debug.c
>  mode change 100644 => 100755 arch/arm/mach-omap2/pm.h

I guess these 755 mode changes weren't intentional... :)

Regards,
Sergio
