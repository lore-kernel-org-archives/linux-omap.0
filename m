From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 07/11] arm:omap:am33xx: Add irq, dma and module base addr to SoC header files
Date: Wed, 30 Nov 2011 17:46:17 -0800
Message-ID: <87obvtt66u.fsf@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
	<1321809555-13833-8-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:58914 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752479Ab1LABqX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Nov 2011 20:46:23 -0500
Received: by mail-yx0-f178.google.com with SMTP id m3so1243032yen.9
        for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 17:46:22 -0800 (PST)
In-Reply-To: <1321809555-13833-8-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Sun, 20 Nov 2011 22:49:11 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, Afzal Mohammed <afzal@ti.com>

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> This patch creats seperate irq and dma defination header file
> and updates the module base addresses required for HWMOD data.
>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

These headers/defines should no longer be needed.  Instead, as with
OMAP4, the raw values are used in the hwmod data (and we'll be moving
device tree for these values.)

Kevin
