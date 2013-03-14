From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: [PATCH RESEND 0/1] omap4: control: Add the CONTROL_SMART2IO_PADCONF_2 register definition
Date: Thu, 14 Mar 2013 02:11:47 +0200
Message-ID: <1363219908-32007-1-git-send-email-ruslan.bilovol@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:38152 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755630Ab3CNALz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Mar 2013 20:11:55 -0400
Received: by mail-la0-f54.google.com with SMTP id gw10so1779100lab.41
        for <linux-omap@vger.kernel.org>; Wed, 13 Mar 2013 17:11:54 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hello guys,

This is a resend of my quite old patch
( https://patchwork.kernel.org/patch/1130991/ ) that
was submitted 9 months ago but I suddenly found that
it is still not picked up in the mainline.
It will be needed for OMAP USB Host HW errata (i687)
implementation that will be sent in a separate patch later

Regards,
Ruslan

Ruslan Bilovol (1):
  omap4: control: Add the CONTROL_SMART2IO_PADCONF_2 register
    definition

 arch/arm/mach-omap2/ctrl_module_pad_core_44xx.h |   45 +++++++++++++++++++++++
 1 file changed, 45 insertions(+)

-- 
1.7.9.5

