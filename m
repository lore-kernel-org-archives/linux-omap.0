From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP4 clock framework: Remove the checks preventing
 OMAP4 clockdomain validation
Date: Tue, 5 Jan 2010 16:07:05 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001051606500.21295@utopia.booyaka.com>
References: <1262189386-22239-1-git-send-email-abhijitpagare@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43516 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755183Ab0AEXHH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 18:07:07 -0500
In-Reply-To: <1262189386-22239-1-git-send-email-abhijitpagare@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abhijit Pagare <abhijitpagare@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 30 Dec 2009, Abhijit Pagare wrote:

> The clockdomain related code being in place, it is not necessary to have
> some part of the clock code commented out. This would help the validation of
> the clockdomain functions using the clock level interfaces.
> 
> Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Thanks, queued for 2.6.34.


- Paul
