From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ARM: Blacklist GCC 4.8.0 to GCC 4.8.2 - PR58854
Date: Sun, 19 Oct 2014 13:04:20 -0700
Message-ID: <CA+55aFwy1hg25p3amy1xZq58afcaNSgP+uy=UA19BSgoVpARVQ@mail.gmail.com>
References: <E1XeWYh-0004Mw-FC@rmk-PC.arm.linux.org.uk>
	<543EF2B6.1050009@hurleysoftware.com>
	<20141016001801.GQ12379@n2100.arm.linux.org.uk>
	<alpine.LFD.2.11.1410161052520.9094@knanqh.ubzr>
	<20141017134112.GS12379@n2100.arm.linux.org.uk>
	<20141019095555.GU12379@n2100.arm.linux.org.uk>
	<CA+55aFw_N=E9O-7VknWTzjNgYG-tB-8736diA1r7K=50b+0czQ@mail.gmail.com>
	<20141019185118.GA22014@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:47636 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbaJSUEV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Oct 2014 16:04:21 -0400
Received: by mail-vc0-f181.google.com with SMTP id le20so2660486vcb.12
        for <linux-omap@vger.kernel.org>; Sun, 19 Oct 2014 13:04:21 -0700 (PDT)
In-Reply-To: <20141019185118.GA22014@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: David Laight <David.Laight@aculab.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Otavio Salvador <otavio@ossystems.com.br>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Nathan Lynch <Nathan_Lynch@mentor.com>

On Sun, Oct 19, 2014 at 11:51 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> Does that work for things like allnoconfig and randconfig?  I guess people
> /could/ seed those appropriately, but that seems to be something that Olof
> wants to avoid doing.

You can force particular config options for those, using something like

    export KCONFIG_ALLCONFIG=custom.config

and filling the custom config file with the required config setting.

So the downside is that you do need to have this custom support to
seed particular things, but yes, it's doable, and it only requires a
one-time setup with an environment variable, so it doesn't need
changes to the actual testing infrastructure.

                   Linus
