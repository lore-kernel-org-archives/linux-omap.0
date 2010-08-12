From: "Premi, Sanjeev" <premi@ti.com>
Subject: omap3630: cpu revision bits are different
Date: Thu, 12 Aug 2010 18:18:59 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E81471BE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34803 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879Ab0HLMtD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 08:49:03 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o7CCn0YL000712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 12 Aug 2010 07:49:02 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o7CCmxJk011387
	for <linux-omap@vger.kernel.org>; Thu, 12 Aug 2010 18:18:59 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

While re working on the cpu revision patch, I came
across these definitions:

#define OMAP3630_REV_ES1_0      0x36300034
#define OMAP3630_REV_ES1_1      0x36300134
#define OMAP3630_REV_ES1_2      0x36300234

Contrast this with:

#define OMAP3430_REV_ES1_0      0x34300034
#define OMAP3430_REV_ES2_0      0x34301034
#define OMAP3430_REV_ES2_1      0x34302034

I may have missed the discussion on this list, but
wanted to quickly check if the difference in intended
OR accidental.

I do recognize that definitions for 3630 start at lower
nibble, so they appear to be better choice.

Best regards,
Sanjeev
