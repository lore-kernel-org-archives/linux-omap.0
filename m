From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 0/4] Horray, more CBUS patches
Date: Tue, 19 Oct 2010 10:38:25 +0300
Message-ID: <20101019103825.e7906b0b.jhnikula@gmail.com>
References: <1287473358-25634-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38795 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933481Ab0JSHhx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 03:37:53 -0400
Received: by ewy20 with SMTP id 20so3001876ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 19 Oct 2010 00:37:52 -0700 (PDT)
In-Reply-To: <1287473358-25634-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, 19 Oct 2010 10:29:14 +0300
Felipe Balbi <balbi@ti.com> wrote:

> I believe now everything is fine. Still, it's only
> compile tested with n770_defconfig and omap2plus_defconfig.
> 
> Felipe Balbi (4):
>   cbus: remove unneded includes
>   cbus: retu: move platform_device to board file
>   cbus: tahvo: move platform_device to board file
>   cbus: tahvo-usb: move platform_device to board file
> 
omap2plus_defconfig doesn't include CONFIG_CBUS(_x) so you must enable
them manually.


-- 
Jarkko
