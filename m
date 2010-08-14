From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] PM: runtime PM + idle: allow usage when interrupts are disabled
Date: Sat, 14 Aug 2010 11:38:10 +0800
Message-ID: <AANLkTi=wzuGw6=Sg31F1h1=fyYAObboFUp6vr0c1-+1c@mail.gmail.com>
References: <1281459261-30829-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61115 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756802Ab0HNDiM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 23:38:12 -0400
Received: by wwj40 with SMTP id 40so3803606wwj.1
        for <linux-omap@vger.kernel.org>; Fri, 13 Aug 2010 20:38:11 -0700 (PDT)
In-Reply-To: <1281459261-30829-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, stern@rowland.harvard.edu

2010/8/11 Kevin Hilman <khilman@deeprootsystems.com>:
> When using runtime PM in combination with CPUidle, the runtime PM
> transtions of some devices may be triggered during the idle path.
> Late in the idle sequence, interrupts will likely be disabled when
> runtime PM for these devices is initiated.
>
> Currently, the runtime PM core assumes methods are called with
> interrupts enabled. =A0However, if it is called with interrupts
> disabled, the internal locking unconditionally enables interrupts, fo=
r
> example:
>
> pm_runtime_put_sync()

It is always called from process context,  why do you have to disable i=
rq
before calling pm_runtime_put_sync?

> =A0 =A0__pm_runtime_put()
> =A0 =A0 =A0 =A0pm_runtime_idle()
> =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irq()
> =A0 =A0 =A0 =A0 =A0 =A0__pm_runtime_idle()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irq() =A0 <--- interrupts =
unconditionally enabled
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->bus->pm->runtime_idle()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irq()
> =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq()
>
> Unconditionally enabling interrupts late in the idle sequence is not
> desired behavior. =A0To fix, use the save/restore versions of the
> spinlock API.
>
> Reported-by: Partha Basak <p-basak2@ti.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> RFC: I'm not crazy about having the 'flags' in struct dev_pm_info, bu=
t
> since the locks are taken and released in separate functions, this
> seems better than changing the function APIs to pass around the flags=
=2E
>

thanks,

--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
