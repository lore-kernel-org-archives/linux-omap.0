From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 02/11] ARM: OMAP3: Fix idle mode signaling for sys_clkreq
 and sys_off_mode
Date: Wed, 16 Apr 2014 16:58:31 +0300
Message-ID: <CANOLnONGTJb7D_jqsHbUzc7RG28oC433BCcXR_HSiW7DapwPWw@mail.gmail.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
	<1397173639-29587-3-git-send-email-tony@atomide.com>
	<CANOLnOO=O8xkTV9LiH+JTtmEXd9ihu0+ZYoHtrQK2QsFWOWVbg@mail.gmail.com>
	<20140415225559.GA5313@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:51185 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161077AbaDPN6c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2014 09:58:32 -0400
Received: by mail-ob0-f173.google.com with SMTP id wn1so4928791obc.32
        for <linux-omap@vger.kernel.org>; Wed, 16 Apr 2014 06:58:32 -0700 (PDT)
In-Reply-To: <20140415225559.GA5313@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>

On Wed, Apr 16, 2014 at 1:56 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Grazvydas Ignotas <notasas@gmail.com> [140414 15:51]:
>> On Fri, Apr 11, 2014 at 2:47 AM, Tony Lindgren <tony@atomide.com> wr=
ote:
>> > @@ -282,6 +283,7 @@ void omap_sram_idle(void)
>> >
>> >         /* CORE */
>> >         if (core_next_state < PWRDM_POWER_ON) {
>> > +               omap3_vc_set_pmic_signaling(core_next_state);
>>
>> I wonder how is it going to affect latencies, adding stuff to suspen=
d
>> path hurts things like NAND transfers, which consist of lots of smal=
l
>> blocks with an interrupt after each..
>
> For most part this is the completely idle path, so there should
> not be much of hurry. Most devices should already block the deeper
> idle states for the devices listed in cm_idlest_per, cm_idlest1_core
> and cm_idlest3_core registers. So it should be mostly automatic with
> runtime PM.
>
> No idea what happens with GPMC though for NAND transfers :) Might
> be worth checking.

What happens there is that the interrupt arrives shortly after the
transfer was issued, but arm_pm_idle() would already be entered and
interrupts disabled, so it then has to go through all those slow
register accesses in omap_sram_idle(), which is just useless work in
such particular case (WFI will just return) and cause interrupt
response latency and loss of throughput. But this is mostly a problem
caused by pwrdm_pre_transition() and pwrdm_post_transition() calls
(they were optimized a bit at one point but later reverted),
core_next_state would probably stay ON and your function wouldn't be
called here, yes.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
