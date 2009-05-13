From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: ARM: CONFIG_FRAME_POINTER
Date: Wed, 13 May 2009 10:55:27 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038BD5E23F@dlee02.ent.ti.com>
References: <7B4574D56E4ADF438756313E9A172A87396257F0@dlee01.ent.ti.com>
 <87zldhaoco.fsf@deeprootsystems.com>
 <13B9B4C6EF24D648824FF11BE8967162038BD5DEE0@dlee02.ent.ti.com>
 <7B4574D56E4ADF438756313E9A172A87396A1E18@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53352 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758176AbZEMPzc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 11:55:32 -0400
In-Reply-To: <7B4574D56E4ADF438756313E9A172A87396A1E18@dlee01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Jon,

> From: Hunter, Jon
> Sent: Wednesday, May 13, 2009 10:48 AM

> KBUILD_CFLAGS   += -fno-omit-frame-pointer -fno-optimize-sibling-calls

Ok so -fno-optimize-sibling-calls is busted in older compiler.

I wonder if there are other reasons for the exclusion of this optimization in kernel code.  Would be interesting to google and see.  There might be 3 other reasons it is needed in addition to one we tripped over.

Regards,
Richard W.
