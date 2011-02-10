From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP2/3: PM: remove unnecessary wakeup/sleep dependency
 clear
Date: Thu, 10 Feb 2011 16:17:43 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102101617200.21991@utopia.booyaka.com>
References: <alpine.DEB.2.00.1101270252010.16671@utopia.booyaka.com> <871v3yp5km.fsf@ti.com> <871v3ffps6.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37124 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757311Ab1BJXRo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Feb 2011 18:17:44 -0500
In-Reply-To: <871v3ffps6.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kevin,

On Thu, 10 Feb 2011, Kevin Hilman wrote:

> While testing, I found out this patch breaks suspend/resume and idle on
> at least 34xx.
> 
> A first suspend/resume works fine, but on subsequent ones SGX
> powerdomain does not hit retention (and thus CORE powerdomain does not
> either....

...

> Simply adding back the above 5 lines (the SGX ones) gets things working
> again, which suggests something isn't quite right with SGX, but I
> haven't found the exact reason yet.

Thanks for the report, I will take a look.


- Paul
