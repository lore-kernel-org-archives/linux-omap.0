From: Olof Johansson <olof@lixom.net>
Subject: Re: OMAP build now completely broken in latest arm-soc
Date: Sun, 25 Nov 2012 05:56:58 -0800
Message-ID: <CAOesGMgvGxfghFbyki7aXE8dVbAA7QQP6nwBKhzHftngGRi0Tw@mail.gmail.com>
References: <20121125093704.GV3332@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54927 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659Ab2KYN47 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Nov 2012 08:56:59 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so5131076iea.19
        for <linux-omap@vger.kernel.org>; Sun, 25 Nov 2012 05:56:59 -0800 (PST)
In-Reply-To: <20121125093704.GV3332@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, arm@kernel.org

Hi,

On Sun, Nov 25, 2012 at 1:37 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Not much more to say...
>
> arch/arm/plat-omap/i2c.c:35:1: error: expected identifier or '(' before '<<' token

Hmm. In for-next, line 35 is a blank line.

Could this be because of a merge conflict in your local version? This
is one of the files that has conflicts with mainline right now; I'll
look to see if we can resolve those in our tree later today.


> But also, the:
>
> arch/arm/mach-omap2/timer.c:163:28: warning: 'omap_counter_match' defined but not used
>
> warning is still there.

There's a fix for this in Tony's tree, but he hasn't sent up the pull
request for it yet.


-Olof
