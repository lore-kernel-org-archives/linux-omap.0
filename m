From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] omap: tidspbridge: fix build failure on MEMBLOCK_REAL_LIMIT
Date: Tue, 2 Nov 2010 16:05:47 +0200
Message-ID: <AANLkTi=fGA__ZXHOUz-VH5dhq7jWG7ZuPOzPdrN7xBM+@mail.gmail.com>
References: <1288704660-21683-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62438 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab0KBOFu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 10:05:50 -0400
Received: by bwz11 with SMTP id 11so5557930bwz.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Nov 2010 07:05:49 -0700 (PDT)
In-Reply-To: <1288704660-21683-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Lindgren <tony@atomide.com>

On Tue, Nov 2, 2010 at 3:31 PM, Anand Gadiyar <gadiyar@ti.com> wrote:
> MEMBLOCK_REAL_LIMIT symbol was removed by the commit e63075a3c937
> (memblock: Introduce default allocation limit and use it to replace
> explicit ones). This breaks build as below when CONFIG_TIDSPBRIDGE
> is selected. Fix this.

I would rather apply this:
http://article.gmane.org/gmane.linux.ports.arm.omap/45076

-- 
Felipe Contreras
