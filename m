From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH] OMAP: hwmod: Set autoidle after smartidle during
 _sysc_enable
Date: Fri, 24 Sep 2010 15:57:49 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027863E1B9@dbde02.ent.ti.com>
References: <1285300039-6384-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53242 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab0IXK2C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 06:28:02 -0400
In-Reply-To: <1285300039-6384-1-git-send-email-hemahk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Basak, Partha" <p-basak2@ti.com>, "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Paul, 

>-----Original Message-----
>From: Kalliguddi, Hema 
>Sent: Friday, September 24, 2010 9:17 AM
>To: linux-omap@vger.kernel.org
>Cc: Kalliguddi, Hema; Basak, Partha; Balbi, Felipe; Tony 
>Lindgren; Kevin Hilman; Cousson, Benoit; Paul Walmsley
>Subject: [PATCH] OMAP: hwmod: Set autoidle after smartidle 
>during _sysc_enable
>
>OMAP USBOTG module has a requirement to set the autoidle bit only after
>setting smartidle bit. Modified the _sys_enable api to set the 
>smartidle
>first and then the autoidle bit. Setting this will not have 
>any impact on the
>other modules.
>
Review comments from Benoit and Sergie are fixed in this patch.
Benoit acked the older version of the patch and you had asked me re-post with
Review comments incorporated.

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35464.html

>Signed-off-by: Hema HK <hemahk@ti.com>
>Signed-off-by: Basak, Partha <p-basak2@ti.com>
>Cc: Felipe Balbi <balbi@ti.com>
>Cc: Tony Lindgren <tony@atomide.com>
>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>Cc: Cousson, Benoit <b-cousson@ti.com>
>Cc: Paul Walmsley <paul@pwsan.com>
>---
> arch/arm/mach-omap2/omap_hwmod.c |   18 ++++++++++++------
> 1 file changed, 12 insertions(+), 6 deletions(-)
>
>Index: linux-omap-pm/arch/arm/mach-omap2/omap_hwmod.c
>===================================================================
>--- linux-omap-pm.orig/arch/arm/mach-omap2/omap_hwmod.c
>+++ linux-omap-pm/arch/arm/mach-omap2/omap_hwmod.c
>@@ -654,12 +654,6 @@ static void _sysc_enable(struct omap_hwm
> 		_set_master_standbymode(oh, idlemode, &v);
> 	}
> 
>-	if (sf & SYSC_HAS_AUTOIDLE) {
>-		idlemode = (oh->flags & HWMOD_NO_OCP_AUTOIDLE) ?
>-			0 : 1;
>-		_set_module_autoidle(oh, idlemode, &v);
>-	}
>-
> 	/* XXX OCP ENAWAKEUP bit? */
> 
> 	/*
>@@ -672,6 +666,18 @@ static void _sysc_enable(struct omap_hwm
> 		_set_clockactivity(oh, oh->class->sysc->clockact, &v);
> 
> 	_write_sysconfig(v, oh);
>+
>+	/*
>+	 * Set the autoidle bit only after setting the smartidle bit
>+	 * as this is requirement for some modules like USBOTG.
>+	 * Setting this will not have any impact on the other modules.
>+	 */
>+	if (sf & SYSC_HAS_AUTOIDLE) {
>+		idlemode = (oh->flags & HWMOD_NO_OCP_AUTOIDLE) ?
>+			0 : 1;
>+		_set_module_autoidle(oh, idlemode, &v);
>+		_write_sysconfig(v, oh);
>+	}
> }
> 
> /**
>