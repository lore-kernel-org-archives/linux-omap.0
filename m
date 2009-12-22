From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/1] ARM: OMAP4: PM: Remove the checks preventing OMAP4
 clockdomain validation
Date: Tue, 22 Dec 2009 09:12:33 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912220911160.5563@utopia.booyaka.com>
References: <1261391747-24066-1-git-send-email-abhijitpagare@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32812 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbZLVQMe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 11:12:34 -0500
In-Reply-To: <1261391747-24066-1-git-send-email-abhijitpagare@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abhijit Pagare <abhijitpagare@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

Hello Abhijit,

On Mon, 21 Dec 2009, Abhijit Pagare wrote:

> The clockdomain related code beng in place it is now not necessary to have
> some of the clock code commented out. This would help the validation of the
> clockdomain functions using the clock level interfaces.
> 
> Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

Could you also deal with the TODO in mach-omap2/clock44xx_data.c ?

Also, has this patch been tested?  If so, please list the platform it was 
tested on in the commit message.

thanks,

- Paul
