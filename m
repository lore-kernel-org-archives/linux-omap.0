From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v3 2/3] gpio/omap: modify wake-up register with interrupt enable.
Date: Fri, 31 May 2013 15:58:55 -0700
Message-ID: <874ndiycwg.fsf@linaro.org>
References: <1368564867-11142-1-git-send-email-andreas.fenkart@streamunlimited.com>
	<1368564867-11142-2-git-send-email-andreas.fenkart@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:54173 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129Ab3EaW67 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 May 2013 18:58:59 -0400
Received: by mail-pd0-f179.google.com with SMTP id q11so2912332pdj.10
        for <linux-omap@vger.kernel.org>; Fri, 31 May 2013 15:58:58 -0700 (PDT)
In-Reply-To: <1368564867-11142-2-git-send-email-andreas.fenkart@streamunlimited.com>
	(Andreas Fenkart's message of "Tue, 14 May 2013 22:54:26 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Cc: santosh.shilimkar@ti.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, balbi@ti.com, linux-omap@vger.kernel.org, daniel@zonque.org, jon-hunter@ti.com

Andreas Fenkart <andreas.fenkart@streamunlimited.com> writes:

> OMAP4430 TRM chap. 25.4.5.2
> To reduce dynamic consumption, an efficient idle scheme is based on t=
he
> following:
> =E2=80=A2 An efficient local autoclock gating for each module
> =E2=80=A2 The implementation of control sideband signals between the =
PRCM module
>   and each module
> This enhanced idle control allows clocks to be activated and deactiva=
ted
> safely without requiring complex software management. The idle mode
> request, idle acknowledge, and wake-up request are sideband signals
> between the PRCM module and the general-purpose interface
>
> OMAP4430 TRM chap. 25.4.6.2
> There must be a correlation between the wake-up enable and interrupt
> enable register. If a GPIO pin has a wake-up configured on it, it mus=
t
> also have the corresponding interrupt enabled. Otherwise, it is possi=
ble
> there is a wake-up event, but after exiting the IDLE state, no interr=
upt
> is generated; the corresponding bit from the interrupt status registe=
r is
> not cleared, and the module does not acknowledge a future idle reques=
t.
>
> Up to now _set_gpio_triggering() is also handling the wake-up enable
> register. According the TRM this should be in sync with the interrupt
> enable. Wakeup is still enabled by default, since the module would no=
t
> wake from idle otherwise.
> The enabled_wakeup_gpios was introduced to remember an explicit
> _set_gpio_wakeup beyond a mask/unmask cycle. Calling the flag flag
> disabled_wakeup_gpios would spare the problem of initializing it, but
> feels very unnatural to read.

There's a lot of description here, but it still fails to describe the
problem that is being solved and the motiviation for this change. =20

> Wakeup functionality is completely untested, since the AM335x
> lacks a IRQWAKEN register.

So in addtion to a better description of the problem, and the changes,
this needs much broader testing, including on platforms with off-mode.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
