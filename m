From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] mailbox: OMAP: introduce mailbox framework
Date: Tue, 6 Nov 2012 09:55:52 +0100
Message-ID: <CACRpkdb0nCaV5L5xCnzje3w=t7+TZpcvCCUDRPi-10t+oF8UGg@mail.gmail.com>
References: <1352170552-29564-1-git-send-email-omar.luna@linaro.org>
	<1352170552-29564-2-git-send-email-omar.luna@linaro.org>
	<509886A2.5060509@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37582 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab2KFIzx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 03:55:53 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so98171eek.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Nov 2012 00:55:52 -0800 (PST)
In-Reply-To: <509886A2.5060509@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Omar Ramirez Luna <omar.luna@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Loic PALLARDY <loic.pallardy@st.com>, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dom Cobley <popcornmix@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Suman Anna <s-anna@ti.com>, Juan Gutierrez <jgutierrez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Tue, Nov 6, 2012 at 4:40 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> Is this a public interface to the driver? If so, shouldn't the header be
> in include/linux somewhere?

I think the split out of the public header is done in patch 2/2.

Yours,
Linus Walleij
