From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [CBUS PATCH 2/2] cbus: switch kmalloc() + memset() to kzalloc()
Date: Mon, 3 May 2010 10:15:33 +0300
Message-ID: <20100503101533.87971c05.jhnikula@gmail.com>
References: <1272736870-5216-1-git-send-email-felipe.balbi@nokia.com>
	<1272736870-5216-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f222.google.com ([209.85.219.222]:50115 "EHLO
	mail-ew0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab0ECHOb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 03:14:31 -0400
Received: by mail-ew0-f222.google.com with SMTP id 22so589696ewy.37
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 00:14:31 -0700 (PDT)
In-Reply-To: <1272736870-5216-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, Felipe Balbi <me@felipebalbi.com>

On Sat,  1 May 2010 21:01:10 +0300
Felipe Balbi <felipe.balbi@nokia.com> wrote:

> From: Felipe Balbi <me@felipebalbi.com>
> 
> no functional changes, just using kzalloc().
> 
> compile tested with n8x0_defconfig and n770_defconfig
> 
> Signed-off-by: Felipe Balbi <me@felipebalbi.com>
> ---
>  drivers/cbus/retu-user.c  |    6 +++---
>  drivers/cbus/tahvo-usb.c  |    4 ++--
>  drivers/cbus/tahvo-user.c |    6 +++---
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
