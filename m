From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH 1/2] OMAP: tsc2005: Bringing driver's configuration (e.g.
	of IRQ/SPI) up to date.
Date: Tue, 17 Feb 2009 23:18:55 +0530
Message-ID: <5d5443650902170948q42cf0900n9e13c04cf7a1766f@mail.gmail.com>
References: <1234792171-4095-1-git-send-email-ext-phil.2.carmody@nokia.com>
	 <cad4802ce1266717a82d5bb73118713de1fdfd15.1234789985.git.ext-phil.2.carmody@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f222.google.com ([209.85.217.222]:62983 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529AbZBQRs5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2009 12:48:57 -0500
Received: by gxk22 with SMTP id 22so4365320gxk.13
        for <linux-omap@vger.kernel.org>; Tue, 17 Feb 2009 09:48:56 -0800 (PST)
In-Reply-To: <cad4802ce1266717a82d5bb73118713de1fdfd15.1234789985.git.ext-phil.2.carmody@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Phil Carmody <ext-phil.2.carmody@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi Phil,

> -       set_irq_wake(ts->irq, 1);
> +       set_irq_wake(ts->spi->irq, 1);

Better if you use enable_irq_wake/disable_irq_wake friends, with
device_init_wakup being done in the probe and suspend/resume checking
device_may_wakeup stuff.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
