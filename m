From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/5] OMAP2: remove duplicated #include
Date: Mon, 14 Dec 2009 13:13:22 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912141312430.12561@utopia.booyaka.com>
References: <1260710017-3804-1-git-send-email-weiyi.huang@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42229 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757806AbZLNUNW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 15:13:22 -0500
In-Reply-To: <1260710017-3804-1-git-send-email-weiyi.huang@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: linux-omap@vger.kernel.org

On Sun, 13 Dec 2009, Huang Weiyi wrote:

> Remove duplicated #include('s) in
>   arch/arm/mach-omap2/clock34xx.c
>   arch/arm/mach-omap2/io.c
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

Thanks Weiyi, will queue for .33-rc*.


- Paul
