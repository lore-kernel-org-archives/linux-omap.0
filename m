From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Reading OMAP3 CONTROL_RAND_KEY_0 register hangs
Date: Thu, 15 Jan 2009 13:43:46 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036D63FEB7@dlee02.ent.ti.com>
References: <496F6310.30104@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51219 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758072AbZAOTnx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 14:43:53 -0500
In-Reply-To: <496F6310.30104@googlemail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> With OMAP3530 on BeagleBoard we like to read OMAP3's
> CONTROL_RAND_KEY_0 (0x4800 2318) register with something like
>
> printf ("attempting cpu_uid read\n");
> u32 cpu_uid = *((u32 *) 0x48002318);
> /* u32 cpu_uid = readl(&ctrl_base->randkey_0); */
> printf ("cpu_uid read done\n");

This address is not accessible out side of secure mode along with some other qualifiers.

Trying to access is futile and will result in an abort.  The control register range is full of readable and aborting addresses.

Regards,
Richard W.

