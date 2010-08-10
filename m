From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: dspbridge and the omapl1x
Date: Tue, 10 Aug 2010 17:42:37 -0400
Message-ID: <AANLkTin7MAdSUmyja5=tp8TP+2mS53++yJT5T6+K27Lp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57490 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932367Ab0HJVmj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 17:42:39 -0400
Received: by ewy23 with SMTP id 23so4125364ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 14:42:38 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ErnestoRamos <ernesto@ti.com>, ArmandoUribe <x0095078@ti.com>, NishanthMenon <nm@ti.com>, KulikovVasiliy <segooon@gmail.com>, ReneSapiens <rene.sapiens@ti.com>, AndyShevchenko <andy.s>
Cc: linux-omap@vger.kernel.org

Hello authors of staging/tidspbridge patches,

We have been watching the progress in staging/dspbridge with great
excitement.  Unfortunately we are using the OMAPL138 which is a
davinci family member which has support for DSPLink not DSPBridge.

We are attracted to DSPBridge over DSPLink because it appears to have
better dynamic resource management and it is headed for mainline
(fingers crossed).

Is omapl1x support part of the roadmap for dspbridge?

Is there anything we can do to help?

Are there interfaces to which we can program that would insulate us
from changes during a future migration from DSPLink to DSPBridge?

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
