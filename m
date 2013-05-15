From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 2/3] gpio/omap: modify wake-up register with interrupt
 enable.
Date: Wed, 15 May 2013 18:11:55 +0530
Message-ID: <51938293.7030506@ti.com>
References: <1368564867-11142-1-git-send-email-andreas.fenkart@streamunlimited.com> <1368564867-11142-2-git-send-email-andreas.fenkart@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35306 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758624Ab3EOMjW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 May 2013 08:39:22 -0400
In-Reply-To: <1368564867-11142-2-git-send-email-andreas.fenkart@streamunlimited.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Cc: khilman@deeprootsystems.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, balbi@ti.com, linux-omap@vger.kernel.org, daniel@zonque.org

On Wednesday 15 May 2013 02:24 AM, Andreas Fenkart wrote:
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
>=20
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
>=20
> Up to now _set_gpio_triggering() is also handling the wake-up enable
> register. According the TRM this should be in sync with the interrupt
> enable. Wakeup is still enabled by default, since the module would no=
t
> wake from idle otherwise.
> The enabled_wakeup_gpios was introduced to remember an explicit
> _set_gpio_wakeup beyond a mask/unmask cycle. Calling the flag flag
> disabled_wakeup_gpios would spare the problem of initializing it, but
> feels very unnatural to read.
>=20
> Wakeup functionality is completely untested, since the AM335x
> lacks a IRQWAKEN register.
>=20
> Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
> ---
I am ok with the subject patch and other two patches.
Would be good to get a tested by at least for though for OMAP4
and OMAP3. I have no access to boards for few weeks so
can't test it myself.

Other than that, for all three patches,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
