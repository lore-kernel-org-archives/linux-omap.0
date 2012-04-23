From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v2 3/4] ARM: OMAP2+: dmtimer: cleanup iclk usage
Date: Tue, 24 Apr 2012 01:06:59 +0530
Message-ID: <CAC83ZvKrV6yjwj9BoU662p8MRbB-h2JGE6AS3eGgaPy8+z=J7w@mail.gmail.com>
References: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
	<1334925563-20768-4-git-send-email-tarun.kanti@ti.com>
	<87obqijq4j.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:55310 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753040Ab2DWThB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 15:37:01 -0400
Received: by qcro28 with SMTP id o28so8524864qcr.5
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 12:36:59 -0700 (PDT)
In-Reply-To: <87obqijq4j.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Mon, Apr 23, 2012 at 11:18 PM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> We do not use iclk anywhere in the dmtimer driver and so removing it=
=2E
>> Hence removing the timer iclk entries from OMAP4 clkdev table as wel=
l.
>
> What about the OMAP2/3 clkdev tables? =A0Can't those be removed as we=
ll?
No, they are being used. In fact I removed them in the beginning only
to discover they are needed.

>
> Comment applies to PATCH 4/4 also.
You mean removing iclk from clkdev table? That is already done in this =
patch!!
--
Tarun
>
> Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
