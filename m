From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: context_loss_count error value
Date: Wed, 18 May 2011 10:40:52 +0300
Message-ID: <1305704452.1834.12.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:34051 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754755Ab1ERHlD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 03:41:03 -0400
Received: by mail-ww0-f53.google.com with SMTP id 40so1169200wwj.22
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:40:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-omap@vger.kernel.org

Hi Kevin,

I was fixing DSS context loss handling which is a bit broken, and while
testing on OMAP3 Overo, with -rc7 and omap2plus_defconfig, I noticed
that get_context_loss_count() seems to always return 0.

0 should be returned when an error happens, and as far as I see in
pwrdm_get_context_loss_count(), no error is happening but the DSS
context has just never been lost and the returned count is thus 0.

Is this correct? And what happens when the count wraps and goes back to
zero, does the function return 0 in that case?

 Tomi


