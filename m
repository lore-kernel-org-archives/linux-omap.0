From: Kevin Hilman <khilman@linaro.org>
Subject: Re: OMAP baseline test results for v3.10-rc1
Date: Tue, 21 May 2013 10:46:51 -0700
Message-ID: <874ndwmdis.fsf@linaro.org>
References: <alpine.DEB.2.00.1305192159080.2656@utopia.booyaka.com>
	<alpine.DEB.2.00.1305192219240.2656@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:51489 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754964Ab3EURqy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 May 2013 13:46:54 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so959680pab.34
        for <linux-omap@vger.kernel.org>; Tue, 21 May 2013 10:46:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1305192219240.2656@utopia.booyaka.com> (Paul
	Walmsley's message of "Sun, 19 May 2013 22:29:40 +0000 (UTC)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

[...]

> PM: chip retention via suspend:
>     FAIL ( 4/ 6): 2430sdp, 37xxevm, 4430es2panda, 4460pandaes
>     Pass ( 2/ 6): 3530es3beagle, 3730beaglexm

FYI...

I also just noticed that 3730beaglexm has stopped waking from suspend
via RTC (non-DT boot.)  Waking from UART console still works.

Worked fine on v3.9, so there's a regressions somewhere.

Kevin
