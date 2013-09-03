From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] ARM: OMAP: Device Tree for 3.12 take #2
Date: Tue, 3 Sep 2013 08:06:51 -0700
Message-ID: <CAOesGMgwRsEJaKb4-LF2SFO_nHT97EHrE1MSdXv4bE8Ja_OhDA@mail.gmail.com>
References: <522100FF.5030204@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:60911 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680Ab3ICPGw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Sep 2013 11:06:52 -0400
Received: by mail-wg0-f50.google.com with SMTP id j13so3386856wgh.17
        for <linux-omap@vger.kernel.org>; Tue, 03 Sep 2013 08:06:51 -0700 (PDT)
In-Reply-To: <522100FF.5030204@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: "khilman@linaro.org" <khilman@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Benoit,

On Fri, Aug 30, 2013 at 1:30 PM, Benoit Cousson <bcousson@baylibre.com> wrote:
> Hi Kevin & Olof,
>
> Here is the updated version without the conflicting patch (ARM: dts: AM33XX: don't redefine OCP bus and device nodes) and with the signed tag.
> There is still a small conflict with usb-next, but it is easily fixable, and already fixed by Stephen.

Sorry, I wasn't able to get this pulled in before the merge window
opened, so it'll unfortunately have to wait until 3.13. Please send a
fresh pull request as soon as -rc1 is out.

It looks like a few of these are fixes (at least from the patch
topics), we'd of course be happy to take those.


-Olof
