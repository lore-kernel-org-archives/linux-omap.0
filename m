From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap: wd_timer: Fix crash frm wdt_probewhen!CONFIG_RUNTIME_PM
Date: Thu, 6 Jan 2011 22:05:52 +0530
Message-ID: <7a7e28065232cb3b196a3813a891225f@mail.gmail.com>
References: <1294234855-6623-1-git-send-email-santosh.shilimkar@ti.com>
 <20110105221839.GD8717@n2100.arm.linux.org.uk> <19b4a66bfdd4ef3e51fdb27bf43b9ce2@mail.gmail.com>
 <20110106152638.GC1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:54165 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751545Ab1AFQfx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 11:35:53 -0500
Received: by mail-gy0-f171.google.com with SMTP id 13so6086775gyg.30
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 08:35:53 -0800 (PST)
In-Reply-To: <20110106152638.GC1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Thursday, January 06, 2011 8:57 PM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; Paul Walmsley; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH] omap: wd_timer: Fix crash frm
> wdt_probewhen!CONFIG_RUNTIME_PM
>
[.....]

> >
> > Yes. That's managed through the shutdown part. Apart from that
> there
> > is another enhancement done in case some one wants to have WDT
> running
> > throughout the kernel boot.
>
> Good - and just to confirm, the fix for LDP watchdogging will be
> submitted
> in the current merge window?

Yes. It's in the queue already.
