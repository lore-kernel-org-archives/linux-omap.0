From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [PATCH 2/3] McBSP: Provide functions for ASoC frame
	syncronization
Date: Tue, 13 Jan 2009 10:41:20 +0200
Message-ID: <1231836080.13843.122.camel@eenurkka-desktop>
References: <12318331352537-git-send-email-ext-eero.nurkkala@nokia.com>
	 <12318331373879-git-send-email-ext-eero.nurkkala@nokia.com>
	 <12318331393997-git-send-email-ext-eero.nurkkala@nokia.com>
	 <20090113102842.8fa93ecf.jarkko.nikula@nokia.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37680 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662AbZAMInm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 03:43:42 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0D8haDb004782
	for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 02:43:40 -0600
In-Reply-To: <20090113102842.8fa93ecf.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tue, 2009-01-13 at 10:28 +0200, Jarkko Nikula wrote:
> This doesn't fix problem on 2420. I assume when it works on 2420, the
> same fix will fix the 34xx as well. I fear the mcbsp initialization
> procedure in omap_mcbsp_start is not correct somewhat for 2420-34xx.

I somewhat disagree. I think this works OK, just fine.
The "feature" appears, especially if codec (aic) is a master.

One cannot say in which state the WCLK (provided by aic) is.
Aic is started prior to McBSP, right?
So when the DMA transfer starts, the WCLK may be about
(depending on CPU load etc) to transition down, and then the L
data goes into R data. As the BCLK clocks in the data. Right?

Of course I might be wrong.

