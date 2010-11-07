From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/5] omap: dsp: fixes for 2.6.37-rc1
Date: Mon, 8 Nov 2010 00:48:10 +0200
Message-ID: <AANLkTin=reP=SJvo19=bPjYY2Owxa7a9EPKk-Jui97B4@mail.gmail.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
	<1289166209-32251-1-git-send-email-felipe.contreras@gmail.com>
	<20101107220213.GB21070@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44469 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab0KGWsM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Nov 2010 17:48:12 -0500
Received: by bwz11 with SMTP id 11so4283342bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 14:48:11 -0800 (PST)
In-Reply-To: <20101107220213.GB21070@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>

On Mon, Nov 8, 2010 at 12:02 AM, Greg KH <greg@kroah.com> wrote:
> On Sun, Nov 07, 2010 at 11:43:24PM +0200, Felipe Contreras wrote:
>> Paul already sent these, but I did some minor modifications, mostly to minimize
>> the amount of changes.
>>
>> Also, I'm re-sending my memblock patch so that the driver can actually be
>> compiled.
>>
>> With these, and reverting the iommu patches[1], the driver should be working. I
>> don't see a more straight-forward way to achieve that.
>
> I can't take these through the staging tree unless I get an ack from the
> omap maintainers.
>
> And as you are adding new infrastructure to the core kernel, this really
> needed to be there before .37-rc1, I don't think it's acceptable to
> merge this late in the development cycle.

Isn't that up to omap maintainers to decide?

Anyway, there's an alternative that doesn't require omap to ack:

--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -23,7 +23,6 @@
 #include <dspbridge/host_os.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
-#include <plat/control.h>

 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/dbdefs.h>
@@ -74,6 +73,18 @@
 #define PAGES_II_LVL_TABLE   512
 #define PHYS_TO_PAGE(phys)      pfn_to_page((phys) >> PAGE_SHIFT)

+/*
+ * This is a totally ugly layer violation, but needed until
+ * omap_ctrl_set_dsp_boot*() are provided.
+ */
+#define OMAP3_IVA2_BOOTMOD_IDLE 1
+#define OMAP2_CONTROL_GENERAL 0x270
+#define OMAP343X_CONTROL_IVA2_BOOTADDR (OMAP2_CONTROL_GENERAL + 0x0190)
+#define OMAP343X_CONTROL_IVA2_BOOTMOD (OMAP2_CONTROL_GENERAL + 0x0194)
+
+#define OMAP343X_CTRL_REGADDR(reg) \
+       OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+
 /* Forward Declarations: */
 static int bridge_brd_monitor(struct bridge_dev_context *dev_ctxt);
 static int bridge_brd_read(struct bridge_dev_context *dev_ctxt,

-- 
Felipe Contreras
