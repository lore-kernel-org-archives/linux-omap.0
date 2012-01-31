From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to pwrdm_clear_all_prev_pwrst()
Date: Tue, 31 Jan 2012 12:53:29 +0530
Message-ID: <CAMQu2gyACq7RFyfnyNddDg7xRbHTTqsgXwMq6Ng4WfLxaatvAw@mail.gmail.com>
References: <20120130093931.11027.31048.stgit@dusk> <20120130094312.11027.31050.stgit@dusk>
 <878vkopw2o.fsf@ti.com> <CAMQu2gxyY50Bno_R2v1x98-ND47CrVpZBq+wA3POXz2+7E7eEw@mail.gmail.com>
 <alpine.DEB.2.00.1201302359320.10061@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:37118 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752225Ab2AaHXu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 02:23:50 -0500
Received: by qadz30 with SMTP id z30so2658908qad.6
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 23:23:49 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1201302359320.10061@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>

On Tue, Jan 31, 2012 at 12:45 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> just a few thoughts.
>
> On Tue, 31 Jan 2012, Shilimkar, Santosh wrote:
>
>> In this code the need is to clear only CPU and MPUPD, and hence they=
 are
>> explicitly cleared since the pre/post transition calls can be moved =
to PM_DEBUG
>> in production kernels.
>>
>> But as you stated in current mainline kernel they are superfluous si=
nce the
>> pre/post calls are not under PM debug. So I am ok either way
>
> We're using the PM counters for the context restore skip optimization=
 now
> in pwrdm_get_context_loss_count(), so they've suddenly become needed =
even
> when PM_DEBUG=3Dn. =A0But those counters are only needed when there a=
re
> devices in the CPU* powerdomains to track that can lose logic context=
=2E =A0I
> don't think that's the case on OMAP4, but you would probably know bet=
ter
> than I.
>
Good point so the pre/post calls are must then. We should kill those ex=
tra calls
form OMAP4 code then.

> Another aspect is that previous powerstate accesses for the CPU*
> powerdomains would theoretically go to the MPU local PRM rather than =
the
> system PRCM. =A0So they may actually return quickly. =A0Haven't teste=
d this.
>
You are correct. They do.

> The MPUSS powerdomain might be another case, though. =A0There are a b=
unch of
> devices in there: the local timers, APB debug devices, etc. =A0We pro=
bably
> have to worry about restoring context for some of those at some point=
=2E
>
MPUSS PD is at the global PRCM level but that one doesn't take time eit=
her.
You need few more cycles to reach there.
IIRC, other power domains use to take time because of the wait_transiti=
on
calls we had. Mostly it was because of the BUGs you fixed. When get som=
e
time I will profile these calls and see if we still have that issue.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
