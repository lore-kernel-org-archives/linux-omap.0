From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] usb: musb: drop superfluous pm_runtime calls around musb_shutdown
Date: Thu, 12 Jan 2012 17:45:38 +0200
Message-ID: <CAMP44s3PnWCmCD1ip1EP9wMBDeOZ0EacpFTOTvASxYcFJh+W6A@mail.gmail.com>
References: <1326374498-22968-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56425 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754061Ab2ALPpk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jan 2012 10:45:40 -0500
In-Reply-To: <1326374498-22968-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>

On Thu, Jan 12, 2012 at 3:21 PM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> Since commit 4f9edd2d7e8d "usb: musb: Fix the crash issue during reboot"
> musb_shutdown() does pm_runtime_get_sync/pm_runtime_put by itself, so
> this no longer needs to be done by the caller. Also, musb_exit_debugfs()
> doesn't access the device, so just drop those runtime_pm calls.

I don't understand what is the relationship with 4f9edd2d7e8d and
musb_shutdown(), it seems this patch is basically reverting
4f9edd2d7e8d.

Cheers.

-- 
Felipe Contreras
