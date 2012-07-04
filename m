From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Wed, 04 Jul 2012 07:27:06 -0700
Message-ID: <87mx3f38lh.fsf@ti.com>
References: <20120611004502.20034.8840.stgit@dusk>
	<20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com>
	<alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com>
	<4FDA45F5.9090300@ti.com>
	<alpine.DEB.2.00.1206141706420.25628@utopia.booyaka.com>
	<4FDB387C.7030003@ti.com>
	<alpine.DEB.2.00.1207040625090.6760@utopia.booyaka.com>
	<alpine.DEB.2.00.1207040652240.6760@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:34473 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750910Ab2GDO06 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jul 2012 10:26:58 -0400
Received: by pbbrq13 with SMTP id rq13so12710116pbb.22
        for <linux-omap@vger.kernel.org>; Wed, 04 Jul 2012 07:26:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207040652240.6760@utopia.booyaka.com> (Paul
	Walmsley's message of "Wed, 4 Jul 2012 06:53:30 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Paul Walmsley <paul@pwsan.com> writes:

> On Wed, 4 Jul 2012, Paul Walmsley wrote:
>
>> So the updated patch below uses a clockdomain data flag for this=20
>> instead.
>
> Here's a version that's a little cleaner.  No functional changes.
>
>
> - Paul
>
> From: Paul Walmsley <paul@pwsan.com>
> Date: Wed, 4 Jul 2012 05:22:53 -0600
> Subject: [PATCH] ARM: OMAP2+: hwmod code/clockdomain data: fix 32K sy=
nc timer
>
> Kevin discovered that commit c8d82ff68fb6873691536cf33021977efbf5593c
> ("ARM: OMAP2/3: hwmod data: Add 32k-sync timer data to hwmod
> database") broke CORE idle on OMAP3.  This prevents device low power
> states.
>
> The root cause is that the 32K sync timer IP block does not support
> smart-idle mode[1], and so the hwmod code keeps the IP block in
> no-idle mode while it is active.  This in turn prevents the WKUP
> clockdomain from transitioning to idle.  There is a hardcoded sleep
> dependency that prevents the CORE_L3 and CORE_CM clockdomains from
> transitioning to idle when the WKUP clockdomain is active[2], so the
> chip cannot enter any device low power states.
>
> It turns out that there is no need to take the 32k sync timer out of
> idle.  The IP block itself probably does not have any native idle
> handling at all, due to its simplicity.  Furthermore, the PRCM will
> never request target idle for this IP block while the kernel is
> running, due to the sleep dependency that prevents the WKUP
> clockdomain from idling while the CORE_L3 clockdomain is active.  So
> we can safely leave the 32k sync timer in target-force-idle mode, eve=
n
> while we continue to access it.
>
> This workaround is implemented by defining a new clockdomain flag,
> CLKDM_ACTIVE_WITH_MPU, that indicates that the clockdomain is
> guaranteed to be active whenever the MPU is inactive.  If an IP
> block's main functional clock exists inside this clockdomain, and the
> IP block does not support smart-idle modes, then the hwmod code will
> place the IP block into target force-idle mode even when enabled.  Th=
e
> WKUP clockdomains on OMAP3/4 are marked with this flag.  (On OMAP2xxx=
,
> no OCP header existed on the 32k sync timer.)   Other clockdomains al=
so
> should be marked with this flag, but those changes are deferred until
> a later merge window, to create a minimal fix.
>
> Another theoretically clean fix for this problem would be to implemen=
t
> PM runtime-based control for 32k sync timer accesses.  These PM
> runtime calls would need to located in a custom clocksource, since th=
e
> 32k sync timer is currently used as an MMIO clocksource.  But in
> practice, there would be little benefit to doing so; and there would
> be some cost, due to the addition of unnecessary lines of code and th=
e
> additional CPU overhead of the PM runtime and hwmod code - unnecessar=
y
> in this case.
>
> Another possible fix would have been to modify the pm34xx.c code to
> force the IP block idle before entering WFI.  But this would not have
> been an acceptable approach: we are trying to remove this type of
> centralized IP block idle control from the PM code.
>
> This patch is a collaboration between Kevin Hilman <khilman@ti.com>
> and Paul Walmsley <paul@pwsan.com>.
>
> Thanks to Vaibhav Hiremath <hvaibhav@ti.com> for providing comments o=
n
> an earlier version of this patch.  Thanks to Tero Kristo
> <t-kristo@ti.com> for identifying a bug in an earlier version of this
> patch.  Thanks to Beno=C3=AEt Cousson <b-cousson@ti.com> for identify=
ing some
> bugs in an earlier version of this patch and for implementation comme=
nts.
>
> References:
>
> 1. Table 16-96 "REG_32KSYNCNT_SYSCONFIG" of the OMAP34xx TRM Rev. ZU
>    (SWPU223U), available from:
>    http://www.ti.com/pdfs/wtbu/OMAP34x_ES3.1.x_PUBLIC_TRM_vzU.zip
>
> 2. Table 4-72 "Sleep Dependencies" of the OMAP34xx TRM Rev. ZU
>    (SWPU223U)
>
> 3. ibid.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Tested-by: Kevin Hilman <khilman@ti.com>

I confirm this version is now allowing CORE to hit retention during
suspend.

Benoit, I hope this is OK with you.  We need a fix for this in v3.5
since this is last core bug preventing CORE retention in v3.5.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
