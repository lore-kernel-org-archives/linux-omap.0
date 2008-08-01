From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: off mode and smartreflex
Date: Fri, 1 Aug 2008 09:49:01 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620361E3890B@dlee02.ent.ti.com>
References: <20080801100024.GB8857@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48727 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbYHAOtK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Aug 2008 10:49:10 -0400
In-Reply-To: <20080801100024.GB8857@codecarver.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Peter,

> Using Rajendra's cpuidle and offmode patches + the patches I posted to
> configure triton2 and set the correct off mode polarity, I noticed the
> system does not go to off mode when smartreflex is enabled. At least
> sysoffmode is not deasserted and the VDD1 and VDD2 voltages do not
> drop
> to 0V. Should smartreflex be disabled by sw before the wfi is issued ?
> Any other idea on why this would happen ?

SR does need to be disabled before an OPP change and re-enabled after the change when using the bypass method.

Yes, I do think you also need to disable SR before idle.  Also, this is in CDP code and functionally validated.

Regards,
Richard W.

