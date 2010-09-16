From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] omap3: Prevent SDRC deadlock when L3 is changing
 frequency
Date: Thu, 16 Sep 2010 01:05:38 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE896716203D6E954B9@dlee02.ent.ti.com>
References: <1279728155-2643-1-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1009151300190.458@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34369 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083Ab0IPGFn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 02:05:43 -0400
In-Reply-To: <alpine.DEB.2.00.1009151300190.458@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Hunter, Jon" <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tony@atomide.com" <tony@atomide.com>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Wednesday, September 15, 2010 2:15 PM

> > This patch fixes this problem by ensuring the branch prediction logic is
> > disabled while changing the L3 clock frequency. The branch prediction logic
> > is disabled by clearing the Z-bit in the ARM AUX CTRL register.

Small correction, Z bit is in CR register. AUX CTRL figures in with the ASA feature.

> Really nice changelog.  I wish every patch had a description this good.
> Patch looks really good, too.  Queued for 2.6.37.

It is system specific if this change is required. It is probably safer to have it than not.

If the AUX CTRL register has the ASA bit/feature active to allow speculative accesses to propagate past the L2 boundary the Z bit should be cleared as in the patch.

However, if ASA bit is not activated then Z bit clearing should not be necessary as speculation will be squashed if there is no L2 hit (so no DDR request will be generated).

It is not recommended to enable ASA bit as it is known to cause some issues on EMU/HS devices. It was also projected as loosing more than it gained across some benchmarks.

Early boot loaders used to set the ASA.  It was removed long back.  Some kernels kept the value and opened up the lockup window.  I don't recall the linux-omap open kernel having the issue. Some vendor ones did over time.

Regards,
Richard W.

