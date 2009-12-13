From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: ehci-omap: Build break on Linus' tree
Date: Sun, 13 Dec 2009 10:29:19 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4CB0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50598 "HELO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751050AbZLME7h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Dec 2009 23:59:37 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.net" <tony@atomide.net>

Tony,

We lost this patch on the way to mainline:
(it needs a small update - filename changed before
we can send it out)

http://patchwork.kernel.org/patch/58093/

Would you like me to rework it, or can you take care of this?


Without this, the omap3 defconfigs that build EHCI will
break (tested omap_3430sdp_defconfig for now).

- Anand
