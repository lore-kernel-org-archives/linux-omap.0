From: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Subject: Re: [PATCH] input: Add support for the TSC2003 controller.
Date: Wed, 6 May 2009 15:54:20 +0900
Message-ID: <483a38b80905052354m221ddc03tcbe9d35ee902b467@mail.gmail.com>
References: <1241006627-22811-1-git-send-email-thierry.reding@avionic-design.de>
	 <5d5443650904290623n3712cd7dja653a139cff2cf6d@mail.gmail.com>
	 <483a38b80904291835p51044741p9bd83d33a40031c@mail.gmail.com>
	 <20090504113751.GA22603@avionic-design.de>
	 <5d5443650905040503n501e3b47qc890dc4c71a85b1c@mail.gmail.com>
	 <20090504145700.GA875@avionic-design.de>
	 <483a38b80905052125r76358182g7ce6b890c921b655@mail.gmail.com>
	 <20090506064529.GA14326@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:36451 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbZEFGyU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 May 2009 02:54:20 -0400
In-Reply-To: <20090506064529.GA14326@avionic-design.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Trilok Soni <soni.trilok@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, May 6, 2009 at 3:45 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> * Kwangwoo Lee wrote:
> [...]
>> Thanks for the patch. It looks good. :)
>> The code in the patch is already merged in the main kernel tree.
>>
>> @@ -235,7 +245,7 @@ static irqreturn_t tsc2007_irq(int irq, void *ha=
ndle)
>> =A0 =A0 =A0 spin_lock_irqsave(&ts->lock, flags);
>>
>> =A0 =A0 =A0 if (likely(ts->get_pendown_state())) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 disable_irq(ts->irq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_nosync(ts->irq);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_start(&ts->timer, ktime_set(0, T=
S_POLL_DELAY),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 HRTIMER_MODE_REL);
>> =A0 =A0 =A0 }
>
> Oh, I hadn't noticed. I diffed against 2.6.30-rc4. Do you want me to =
send a
> new patch or will you just rip that piece out?

Send fixed patch with your Signed-off-by line.

--=20
Kwangwoo Lee <kwangwoo.lee@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
