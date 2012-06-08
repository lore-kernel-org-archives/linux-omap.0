From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [CFT] PL08x patches
Date: Fri, 8 Jun 2012 10:32:02 +0200
Message-ID: <CACRpkdadwL6AvEtHK0RyBKXCvMhc_g8n5im0RjJCHof4-Bs_-Q@mail.gmail.com>
References: <20120607103434.GQ8262@n2100.arm.linux.org.uk>
	<E1Sca9b-0003ax-4E@rmk-PC.arm.linux.org.uk>
	<20120607104527.GA15973@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:41213 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756041Ab2FHIcE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 04:32:04 -0400
Received: by qadb17 with SMTP id b17so580233qad.19
        for <linux-omap@vger.kernel.org>; Fri, 08 Jun 2012 01:32:02 -0700 (PDT)
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

On Thu, Jun 7, 2012 at 12:45 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Here's the PL08x patches.

I've tested the entire set: first the three patches splitting out the virtual
channels, then the remaining 31 patches on PL08x.

The test was performed on a Nomadik S8815 which has a pretty
much vanilla PL08x block.

The DMAengine memcpy test completes just fine and behave like
before.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
