From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2 04/19] ARM: OMAP4: PM: save/restore all DPLL settings in
 OFF mode
Date: Thu, 17 May 2012 12:34:31 +0530
Message-ID: <CAMQu2gw5myvyvM8x225KnN59vEYBYLBiEsvML8RAoE0t+RrbYA@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-5-git-send-email-t-kristo@ti.com> <87d363928g.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:48748 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759153Ab2EQHEx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 May 2012 03:04:53 -0400
Received: by qabj40 with SMTP id j40so1452949qab.8
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 00:04:51 -0700 (PDT)
In-Reply-To: <87d363928g.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>

On Thu, May 17, 2012 at 4:12 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tero Kristo <t-kristo@ti.com> writes:
>
>> From: Rajendra Nayak <rnayak@ti.com>
>>
>> SAR/ROM code restores only CORE DPLL to its original state
>> post wakeup from OFF mode.
>> The rest of the DPLL's in OMAP4 platform (MPU/IVA/ABE/USB/PER)
>> are saved and restored here during an OFF transition.
>>
>> [nm@ti.com: minor cleanups]
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>
> Some general comments:
>
> - the register dump/print doesn't belong here. =A0If needed, should b=
e a
> =A0debug feature if needed.
>
> - Rather than hooking into omap4_enter_lowpower(), should use
> =A0the cluster PM enter/exit notifier chain.
>
This is again specific to device OFF only and not related to CPU
cluster state as such. So I don't think notifiers should be used here.

O.w even when we attempt just MPU OSWR C-state, all these functions wil=
l
get called in notifier chain.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
