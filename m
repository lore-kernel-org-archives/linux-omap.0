From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 0/1] OMAP gptimer based event monitor driver for oprofile
Date: Thu, 8 Jan 2009 14:19:02 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036D4E62EE@dlee02.ent.ti.com>
References: <ESEBH1026QcqnWwAeRa000037d8@esebh102.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44244 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762456AbZAHUTU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 15:19:20 -0500
In-Reply-To: <ESEBH1026QcqnWwAeRa000037d8@esebh102.NOE.Nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: oprofile-list <oprofile-list@lists.sourceforge.net>

Hi,

> Current revisions of Cortex-A8 core have a hardware bug in performance
> monitoring unit, which makes it very unreliable in Oprofile.
>
> We discussed this problem offlist with Richard Woodruff some time ago and he
> suggested to use GPTIMER to get better event samples collection frequency,
> comparable to the one typically used with the hardware performance counters.
> The use of GPTIMER instead of a standard oprofile timer based backend makes
> the process of profiling applications less painful and more precise.

Cool.  This will help a lot.

I did get some more information from ARM on core bug which is now in their official errata.  As a future enhancement it should be possible to use PMNC event counters as long as they do not overflow.  This might allow a GPT - PMNC hybrid.  The 32bit counters can run for a good amount before rolling.

Additionally, the bug is greatly minimized in future stepping of CortexA8. It will be a while before that core goes into a production device.

Thanks,
Richard W.
