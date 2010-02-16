From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH] dspbridge: Simplify Atoi() method (v2)
Date: Tue, 16 Feb 2010 17:49:04 -0600
Message-ID: <4B7B2EF0.80002@ti.com>
References: <4B7213C1.1040300@ti.com> <1265788738-27123-1-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44045 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933627Ab0BPXtJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 18:49:09 -0500
In-Reply-To: <1265788738-27123-1-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

On 2/10/2010 1:58 AM, Andy Shevchenko wrote:
> From: Andy Shevchenko<ext-andriy.shevchenko@nokia.com>
>
> Try to use simple_strtoul() kernel native method instead.
>
> However, there are opened questions:
>   - why type of Atoi() is s32 if the sign is used only to detect base?
>   - should we really to check hex integers like DEAD0123h?
>   - how many spaces could lead token?
>
> Signed-off-by: Andy Shevchenko<ext-andriy.shevchenko@nokia.com>

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Pushed to dspbridge

- omar
