From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 6/9] OMAP device: change pr_warnings to pr_debugs
Date: Fri, 01 Jul 2011 15:05:42 -0700
Message-ID: <87wrg1sll5.fsf@ti.com>
References: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
	<1309338303-2086-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:53439 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756864Ab1GAWFq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 18:05:46 -0400
Received: by mail-iy0-f176.google.com with SMTP id 20so3465818iyi.7
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 15:05:46 -0700 (PDT)
In-Reply-To: <1309338303-2086-7-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Wed, 29 Jun 2011 12:05:00 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> Prevents a hang when omap_device would want to print something for
> serial console device while enabling / disabling its clocks.

hang is still there if you boot with 'debug' on the cmdline.

This needs a fix in the UART driver using console locking.

This should be marked as 'TEMP' also as this should be fixed in the UART
drivers runtime PM adaptation.

Kevin
