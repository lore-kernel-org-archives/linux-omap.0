From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 205/493] gpio: remove use of __devinit
Date: Thu, 22 Nov 2012 09:49:57 +0100
Message-ID: <CACRpkdat0=vv7+V6USOcgyXu_qPmgTVEtkHLfdhpeg4T660+WA@mail.gmail.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
	<1353349642-3677-205-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:52541 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755346Ab2KVURK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Nov 2012 15:17:10 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so3338788eaa.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Nov 2012 12:17:09 -0800 (PST)
In-Reply-To: <1353349642-3677-205-git-send-email-wfp5p@virginia.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Grant Likely <grant.likely@secretlab.ca>, Peter Tyser <ptyser@xes-inc.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, device-drivers-devel@blackfin.uclinux.org, patches@opensource.wolfsonmicro.com, linux-omap@vger.kernel.org

On Mon, Nov 19, 2012 at 7:22 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:

> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Peter Tyser <ptyser@xes-inc.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: device-drivers-devel@blackfin.uclinux.org
> Cc: patches@opensource.wolfsonmicro.com
> Cc: linux-omap@vger.kernel.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
