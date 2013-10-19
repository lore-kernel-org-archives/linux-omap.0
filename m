From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 08/11] ARM: OMAP3: control: add API for setting IVA
 bootmode
Date: Sat, 19 Oct 2013 17:18:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310191717540.11676@utopia.booyaka.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com> <1381508141-15244-9-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48968 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab3JSRSE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 13:18:04 -0400
In-Reply-To: <1381508141-15244-9-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@linaro.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Fri, 11 Oct 2013, Tero Kristo wrote:

> OMAP3 PM core requires IVA2 bootmode to be set to idle during init. Currently,
> a direct register write is used for this. Add a new ctrl API for this purpose
> instead.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Thanks, queued.


- Paul
