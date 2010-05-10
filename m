From: Steve Sakoman <sakoman@gmail.com>
Subject: DSS2 on 36xx with 2.6.34-rc6
Date: Mon, 10 May 2010 08:24:14 -0700
Message-ID: <AANLkTiljBOjnB4QZ6Df2IRu3Tw79rIZaGX3pkZ3X91cB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f171.google.com ([209.85.210.171]:46022 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab0EJPYP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 11:24:15 -0400
Received: by yxe1 with SMTP id 1so2637236yxe.33
        for <linux-omap@vger.kernel.org>; Mon, 10 May 2010 08:24:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Has anyone had success with DSS2 on a 36xx platform using the current
l-o top of tree?

I've been working with a Beagle xM prototype and have applied the
"OMAP3630: DSS2: Updating MAX divider value" patch from Tomi's repo as
well as Koen's Beagle DSS2 support patch.

The image works as expected on a 35xx based Beagle, but when run on
the Beagle xM results in a "HDMI: Out of Range" error from my monitor.
 Sadly the monitor won't give me the erroneous timing parameters.

I suspect that there are still issues in clock setup (or perhaps in
CPU type/revision detection).

Anyone else working in this area?

Steve
