From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: ARM: CONFIG_FRAME_POINTER
Date: Wed, 13 May 2009 11:06:30 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A87396A1E87@dlee01.ent.ti.com>
References: <7B4574D56E4ADF438756313E9A172A87396257F0@dlee01.ent.ti.com>
 <87zldhaoco.fsf@deeprootsystems.com>
 <13B9B4C6EF24D648824FF11BE8967162038BD5DEE0@dlee02.ent.ti.com>
 <7B4574D56E4ADF438756313E9A172A87396A1E18@dlee01.ent.ti.com>
 <13B9B4C6EF24D648824FF11BE8967162038BD5E23F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43749 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758358AbZEMQGh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 12:06:37 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162038BD5E23F@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Richard,

> Ok so -fno-optimize-sibling-calls is busted in older compiler.

I am not sure that -fno-optimize-sibling-calls is busted as it appears that with this option it worked with the old compiler. 

However, I should note that I never confirmed if the issue was caused by having -fno-omit-frame-pointer versus -fomit-frame-pointer or the omission of the option -fno-optimize-sibling-calls. 

So basically, I am saying that having the following allows it to work.

KBUILD_CFLAGS   += -fno-omit-frame-pointer -fno-optimize-sibling-calls

Cheers
Jon
