From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: pm-core: recursive dependency on config
Date: Sat, 5 Mar 2011 14:11:29 +0530
Message-ID: <ea74188f9e010d45c0c8ba15ab6b2617@mail.gmail.com>
References: <AANLkTi=wNSOmZ8TcWGUoPmdaC5ga9NrzsXhULnUxLMGk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:48003 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750821Ab1CEIld (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 03:41:33 -0500
Received: by qyk7 with SMTP id 7so2357820qyk.10
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 00:41:31 -0800 (PST)
In-Reply-To: <AANLkTi=wNSOmZ8TcWGUoPmdaC5ga9NrzsXhULnUxLMGk@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>

+ Russell,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Saturday, March 05, 2011 1:51 PM
> To: linux-omap
> Subject: pm-core: recursive dependency on config
>
> Folks,
> Dumb question:
> Some one seen this one? is there a patch in the pipe for the fix?
>
> scripts/kconfig/conf --silentoldconfig Kconfig
> arch/arm/Kconfig:1277:error: recursive dependency detected!
> arch/arm/Kconfig:1277:	symbol SMP depends on CPU_V6K
> arch/arm/mm/Kconfig:407:	symbol CPU_V6K depends on SMP
>
I saw this one too. This is because of resent changes to
ensure that CPU_32v6K is always enabled with SMP builds.

This is tricky dependency. May be RMK has better way to deal
with this.

Two relevant commit on this are '85a11f52' and  '15490ef8'

Regards,
Santosh
