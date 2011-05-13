From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC PATCH v3] Consolidate SRAM support
Date: Fri, 13 May 2011 09:30:14 +0200
Message-ID: <BANLkTimmCuxUUY46B+aY5C0KxnY4_Dvucg@mail.gmail.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<20110512174546.GB8633@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59249 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757267Ab1EMHaP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 May 2011 03:30:15 -0400
Received: by qyg14 with SMTP id 14so1315858qyg.19
        for <linux-omap@vger.kernel.org>; Fri, 13 May 2011 00:30:14 -0700 (PDT)
In-Reply-To: <20110512174546.GB8633@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, May 12, 2011 at 7:45 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>    This version fixes the davinci pm free, and adds updates for the
>    davinci pcm driver.  As I don't know what's happening with Jean's
>    patch tweaking the genpool allocator, I've kept my version.

Sorry I do not get the question. The latest changes I submitted have
been merged in mainline as 'ARM: 6649/1: omap: use fncpy to copy the
PM code functions to SRAM' [1] . Thanks for that!
This change is only about the simple linear SRAM allocator, not the
genpool allocator.

>    This still suffers from the "only one region per pvpool" problem
>    which I believe Jean's patch doesn't suffer.

[1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=b6338bdc8305b27688a7feb8689e4ccfd42f0292

Regards,
Jean
