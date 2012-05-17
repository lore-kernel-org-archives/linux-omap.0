From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2 04/19] ARM: OMAP4: PM: save/restore all DPLL settings in
 OFF mode
Date: Thu, 17 May 2012 14:22:52 +0530
Message-ID: <CAMQu2gywor2o+g8Fn80ogbTtEZPSXM74M65GsO2zH44tg-W7gQ@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-5-git-send-email-t-kristo@ti.com> <87d363928g.fsf@ti.com> <CAMQu2gw5myvyvM8x225KnN59vEYBYLBiEsvML8RAoE0t+RrbYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:55189 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759489Ab2EQIxP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 May 2012 04:53:15 -0400
Received: by qaea16 with SMTP id a16so1635750qae.10
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 01:53:13 -0700 (PDT)
In-Reply-To: <CAMQu2gw5myvyvM8x225KnN59vEYBYLBiEsvML8RAoE0t+RrbYA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>

On Thu, May 17, 2012 at 12:34 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Thu, May 17, 2012 at 4:12 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Tero Kristo <t-kristo@ti.com> writes:
>>
>>> From: Rajendra Nayak <rnayak@ti.com>
>>>
>>> SAR/ROM code restores only CORE DPLL to its original state
>>> post wakeup from OFF mode.
>>> The rest of the DPLL's in OMAP4 platform (MPU/IVA/ABE/USB/PER)
>>> are saved and restored here during an OFF transition.
>>>
>>> [nm@ti.com: minor cleanups]
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>
>> Some general comments:
>>
>> - the register dump/print doesn't belong here. =A0If needed, should =
be a
>> =A0debug feature if needed.
>>
>> - Rather than hooking into omap4_enter_lowpower(), should use
>> =A0the cluster PM enter/exit notifier chain.
>>
> This is again specific to device OFF only and not related to CPU
> cluster state as such. So I don't think notifiers should be used here=
=2E
>
> O.w even when we attempt just MPU OSWR C-state, all these functions w=
ill
> get called in notifier chain.
>
Just a thought, we can have a separate notifier chain for device OFF. I=
t can
allow use to get rid of 'enable_off_mode" kind of flags and can be
used by many drivers too.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
