From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/5] arm/dts: Add pinctrl driver entries for omap2/3/4
Date: Fri, 7 Sep 2012 10:10:47 +0200
Message-ID: <CACRpkdZOJURpX=NqAOemKiOXvKQp5brUqpkB7YOdZvAosHD2eg@mail.gmail.com>
References: <20120906185615.1172.23588.stgit@muffinssi.local>
	<20120906185824.1172.95748.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:64262 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756055Ab2IGIKs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 04:10:48 -0400
Received: by wibhi8 with SMTP id hi8so1411456wib.1
        for <linux-omap@vger.kernel.org>; Fri, 07 Sep 2012 01:10:47 -0700 (PDT)
In-Reply-To: <20120906185824.1172.95748.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Thu, Sep 6, 2012 at 8:58 PM, Tony Lindgren <tony@atomide.com> wrote:

> Add pinctrl driver entries for omap2+. These all use
> the generic pinctrl-single driver for the padconf
> registers.
>
> Note that as 2420 and 2430 have different padmux
> registers, we now need to include omap2420.dtsi from
> omap2420-h4.dts.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: devicetree-discuss@lists.ozlabs.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>

FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
