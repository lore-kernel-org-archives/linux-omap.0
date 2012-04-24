From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 3/4] ARM: OMAP2+: dmtimer: cleanup iclk usage
Date: Mon, 23 Apr 2012 17:34:30 -0700
Message-ID: <878vhmezmx.fsf@ti.com>
References: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
	<1334925563-20768-4-git-send-email-tarun.kanti@ti.com>
	<87obqijq4j.fsf@ti.com>
	<CAC83ZvKrV6yjwj9BoU662p8MRbB-h2JGE6AS3eGgaPy8+z=J7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:55617 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753585Ab2DXAeY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 20:34:24 -0400
Received: by pbbjt11 with SMTP id jt11so5756556pbb.35
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 17:34:23 -0700 (PDT)
In-Reply-To: <CAC83ZvKrV6yjwj9BoU662p8MRbB-h2JGE6AS3eGgaPy8+z=J7w@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Tue, 24 Apr 2012 01:06:59 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> On Mon, Apr 23, 2012 at 11:18 PM, Kevin Hilman <khilman@ti.com> wrote=
:
>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>
>>> We do not use iclk anywhere in the dmtimer driver and so removing i=
t.
>>> Hence removing the timer iclk entries from OMAP4 clkdev table as we=
ll.
>>
>> What about the OMAP2/3 clkdev tables? =C2=A0Can't those be removed a=
s well?
> No, they are being used. In fact I removed them in the beginning only
> to discover they are needed.

Maybe PATCH 0/x could summarize why they're still needed for OMAP2/3.

>>
>> Comment applies to PATCH 4/4 also.
> You mean removing iclk from clkdev table? That is already done in thi=
s patch!!

I meant why can't OMAP2/3 data be removed in PATCH 4/4 also, which only
touches OMAP4.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
