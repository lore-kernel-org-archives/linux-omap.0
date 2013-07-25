From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: hwmod: AM335x: fix cpgmac address space
Date: Thu, 25 Jul 2013 15:31:43 +0530
Message-ID: <51F0F787.9030108@ti.com>
References: <4bb04ee7bcb8ca73d5fc43049ba029471b9cdda3.1373036932.git.afzal@ti.com> <84d9a3ae9ab7a47924eb54934dcad91339543d63.1373036932.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40252 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755144Ab3GYKCL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Jul 2013 06:02:11 -0400
In-Reply-To: <84d9a3ae9ab7a47924eb54934dcad91339543d63.1373036932.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, "Benoit Cousson (benoit.cousson@linaro.org)" <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>

On 7/5/2013 8:43 PM, Afzal Mohammed wrote:
> Register target address to be used for cpgmac is the second device
> address space. By default, hwmod picks first address space (0th index)
> for register target.
>
> With removal of address space from hwmod and using DT instead, cpgmac
> is getting wrong address space for register target.
>
> Fix it by indicating the address space to be used for register target.
>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
I have tested this patch and it's needed when we have CPSW Ethernet built-in to
go to low power state.

Tested-by: Mugunthan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N
