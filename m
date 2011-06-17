From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP: Overo: remove duplicate call to overo_ads7846_init()
Date: Fri, 17 Jun 2011 13:59:28 -0700
Message-ID: <87lix0b2dr.fsf@ti.com>
References: <87r56sbg3b.fsf@ti.com>
	<1308327432-31177-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:38014 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932205Ab1FQU7c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jun 2011 16:59:32 -0400
Received: by mail-pv0-f176.google.com with SMTP id 37so1058290pve.21
        for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 13:59:31 -0700 (PDT)
In-Reply-To: <1308327432-31177-1-git-send-email-zonque@gmail.com> (Daniel
	Mack's message of "Fri, 17 Jun 2011 18:17:12 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com

Daniel Mack <zonque@gmail.com> writes:

> overo_ads7846_init() is already called from overo_spi_init(), and
> calling it twice is not only unnecessary but causes a warning as
> "reg-fixed-voltage.1" is already added to the device tree.

Excellent, thanks!

> Signed-off-by: Daniel Mack <zonque@gmail.com>

Tested-by: Kevin Hilman <khilman@ti.com>

