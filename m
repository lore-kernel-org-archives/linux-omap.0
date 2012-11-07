From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: [PATCH v2 1/2] mailbox: OMAP: introduce mailbox framework
Date: Tue, 6 Nov 2012 19:10:35 -0600
Message-ID: <CALLhW=6V=7Maq4FLpjrMJ015nYKBSnpagb25ZtQ4AVNLfmwsdg@mail.gmail.com>
References: <1352170552-29564-1-git-send-email-omar.luna@linaro.org>
	<1352170552-29564-2-git-send-email-omar.luna@linaro.org>
	<509886A2.5060509@wwwdotorg.org>
	<CACRpkdb0nCaV5L5xCnzje3w=t7+TZpcvCCUDRPi-10t+oF8UGg@mail.gmail.com>
	<20121106085931.GA26335@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:60126 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619Ab2KGBKg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 20:10:36 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so1049318vbb.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Nov 2012 17:10:35 -0800 (PST)
In-Reply-To: <20121106085931.GA26335@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Loic PALLARDY <loic.pallardy@st.com>, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dom Cobley <popcornmix@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Suman Anna <s-anna@ti.com>, Juan Gutierrez <jgutierrez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Hi Greg,

On 6 November 2012 02:59, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Tue, Nov 06, 2012 at 09:55:52AM +0100, Linus Walleij wrote:
>> On Tue, Nov 6, 2012 at 4:40 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>
>> > Is this a public interface to the driver? If so, shouldn't the header be
>> > in include/linux somewhere?
>>
>> I think the split out of the public header is done in patch 2/2.
>
> Yes, but the names are still omap_*, which doesn't make much sense here.

Ok, I have no problem with this...

I was under the impression that moving this code out of plat-omap was
blocking single zImage support hence the minimal changes to move it to
drivers/.

I will strip the generic portions from omap_ prefixes and resend.

Cheers,

Omar
