From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Issues with calling pm_runtime functions in platform_pm_suspend_noirq/IRQ disabled context.
Date: Tue, 03 Aug 2010 10:35:59 -0700
Message-ID: <874ofbppj4.fsf@deeprootsystems.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E7ED1089@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45622 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756514Ab0HCRgF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 13:36:05 -0400
Received: by iwn7 with SMTP id 7so5292758iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 03 Aug 2010 10:36:04 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7ED1089@dbde02.ent.ti.com>
	(Partha Basak's message of "Tue, 3 Aug 2010 19:19:40 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kalliguddi, Hema" <hemahk@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

"Basak, Partha" <p-basak2@ti.com> writes:

> Resending with the corrected mailing list
>
> Hello Kevin,
>
> I want to draw your attention to an issue the following patch
> introduces. http://dev.omapzoom.org/?p=swarch/linux-omap-adv.git;a=commitdiff;h=8041359e18e49bf8a3d41f15894db9e476f3a8fc

[...]

> I believe, it is not correct to call the pm_runtime APIs from
> interrupt locked context since the underlying functions
> __pm_runtime_suspend & __pm_runtime_resume enable interrupts and call
> schedule().
>
> Further, from a s/w layering standpoint, platform-bus is a deeper
> layer than the Runtime layer, which the runtime layer calls into. So
> it may not be correct to have this layer calling into pm_runtime(). It
> should directly call omap_device APIs.

The original version of this patch did directly call the omap_device
APIs.  However, Paul didn't like that approach and there were
use-counting problems to handle as well (e.g. if a driver was not (yet)
in use, it would already be disabled, and a suspend would trigger an
omap_device_disable() which would fail since device was already
disabled.)

Paul and I agreed that this current approach would solve the
use-counting problems, but you're correct in that it introduces
new problems as these functions can _possibly_ sleep/schedule.

That being said, have you actually seen problems here?   I would like
to see how they are triggered?

By the time the drivers _noirq hooks are called, the PM core has
shutdown all the drivers, prevented any runtime PM transitions and
disabled interrupts, so no pending runtime transitions will be queued
so the sleeping patch of the __pm_runtime_* should never be entered.

> We are facing a similar issue with a few drivers USB, UART & GPIO
> where, we need to enable/disable clocks & restore/save context in the
> CPU-Idle path with interrupts locked.

These are unrelated issues.  The above is for the static suspend/resume
case.  These are for runtime PM.

> As we are unable to use Runtime APIs, we are using omap_device APIs
> directly with the following modification in the .activate_funcion/
> deactivate_funcion (example UART driver)

[...]

The UART driver is a special case as it is managed from deep inside the
idle path.

> Can you feedback on my observations and comment on the approach taken
> for these drivers?

I cannot comment until I understand why these drivers need to
enable/disable with interrupts off.

In general, any use of the interrupts-off versions of the omap_device
APIs need to be thorougly justified.

Even the UART one will go away when the omap-serial driver is converted
to runtime PM.

Kevin


