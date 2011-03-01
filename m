From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/5] ARM: gic: Add distributor and interface
 enable/disable accessory api
Date: Tue, 1 Mar 2011 11:28:49 +0530
Message-ID: <40fac4df5423b501f2b3eca514e62b99@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com> <1295859080-15259-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:38017 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755008Ab1CAF6w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 00:58:52 -0500
Received: by mail-qy0-f176.google.com with SMTP id 30so4379449qyk.14
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 21:58:50 -0800 (PST)
In-Reply-To: <1295859080-15259-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, ccross@android.com, catalin.marinas@arm.com, linux@arm.linux.org.uk, linus.ml.walleij@gmail.com, Russell King <rmk+kernel@arm.linux.org.uk>

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Monday, January 24, 2011 2:21 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org; ccross@android.com;
> catalin.marinas@arm.com; linux@arm.linux.org.uk;
> linus.ml.walleij@gmail.com; Santosh Shilimkar; Russell King
> Subject: [PATCH 2/5] ARM: gic: Add distributor and interface
> enable/disable accessory api
>
> The power management code needs to have access to enable/disable the
> gic cpu interface and distributor based on targetted low power
> states.
>
> This patch adds and exports one API each for distributor and cpu
> interface enable/disable.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
As per off-the list discussion with Russell, I am going to drop
this patch for time being and handle this in OMAP code instead
till common GIC code refactoring is sorted out.
