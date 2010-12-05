From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 4/5] ARM: GIC: move gic_data[] initialization into gic_init()
Date: Sun, 5 Dec 2010 22:04:24 +0000
Message-ID: <AANLkTim_+9DJYA4R+HvT4pNT5cp21i6bvaRhLmJV2AQ8@mail.gmail.com>
References: <20101205113311.GC9138@n2100.arm.linux.org.uk>
	<E1PPCsB-0004xa-H0@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37570 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab0LEWEZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Dec 2010 17:04:25 -0500
Received: by iwn6 with SMTP id 6so2552008iwn.19
        for <linux-omap@vger.kernel.org>; Sun, 05 Dec 2010 14:04:25 -0800 (PST)
In-Reply-To: <E1PPCsB-0004xa-H0@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 5 December 2010 11:35, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This avoids writing unnecessarily to gic_data[] from other CPUs,
> making this a mostly read-only variable.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
