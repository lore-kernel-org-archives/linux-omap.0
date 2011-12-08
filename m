From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap: fix iva and mailbox hwmods for OMAP 3
Date: Thu, 8 Dec 2011 12:22:08 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112081221560.6289@utopia.booyaka.com>
References: <1323109246-1458-1-git-send-email-felipe.contreras@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52224 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab1LHTWJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 14:22:09 -0500
In-Reply-To: <1323109246-1458-1-git-send-email-felipe.contreras@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Abhilash K V <abhilash.kv@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>

On Mon, 5 Dec 2011, Felipe Contreras wrote:

> From: Felipe Contreras <felipe.contreras@gmail.com>
> 
> Seems the commit 7e89098 was overly aggressive in adding iva and mailbox
> hwmods so now they are registered twice.

Thanks Felipe, queued for 3.2-rc fixes.


- Paul
