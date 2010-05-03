From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [CBUS PATCH 1/2] cbus: fix compilation with current mainline
Date: Mon, 3 May 2010 10:15:28 +0300
Message-ID: <20100503101528.1ecedcc8.jhnikula@gmail.com>
References: <1272736870-5216-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f222.google.com ([209.85.219.222]:50115 "EHLO
	mail-ew0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab0ECHO1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 03:14:27 -0400
Received: by ewy22 with SMTP id 22so589696ewy.37
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 00:14:26 -0700 (PDT)
In-Reply-To: <1272736870-5216-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, Felipe Balbi <me@felipebalbi.com>

On Sat,  1 May 2010 21:01:09 +0300
Felipe Balbi <felipe.balbi@nokia.com> wrote:

> From: Felipe Balbi <me@felipebalbi.com>
> 
> commit 5a0e3ad6af8660be21ca98a971cd00f331318c05 broke
> compilation of the retu-pwrbutton driver when it dropped
> implicit inclusion of slab.h and gfp.h.
> 
> Fix it by including slab.h on retu-pwrbutton.c, while at
> that, also include slab.h on retu-rtc.c to avoid later
> problems with implicit inclusion of that being dropped.
> 
> Compile tested with n770_defconfig and n8x0_defconfig
> 
> Signed-off-by: Felipe Balbi <me@felipebalbi.com>
> ---
>  drivers/cbus/retu-pwrbutton.c |    1 +
>  drivers/cbus/retu-rtc.c       |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
