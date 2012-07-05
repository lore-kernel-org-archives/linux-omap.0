From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v2 0/4] ARM: OMAP2+: dmtimer: cleanup related to devm API
 and clk usage
Date: Thu, 5 Jul 2012 17:11:27 +0530
Message-ID: <CAC83ZvKO22JZ59VLdykEjRNDqK_FmGLtC=1y8OEfP88Ef9jBSA@mail.gmail.com>
References: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
	<CAC83ZvLOoUwthcv0seXeqJcuvxvhP7P500T66RHCCWvrsaPr2A@mail.gmail.com>
	<CAMQu2gxDbi191EdA0_acaJwhuAddXJ44FzVQJ=5c1Fh0PFDG4w@mail.gmail.com>
	<CAC83ZvLcyRSc-X2o_05tS7R3S1s190ejDQaBOYHOK1JuknrAxA@mail.gmail.com>
	<20120705092809.GY1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:40191 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754671Ab2GELla (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 07:41:30 -0400
Received: by qcpx40 with SMTP id x40so5456935qcp.40
        for <linux-omap@vger.kernel.org>; Thu, 05 Jul 2012 04:41:28 -0700 (PDT)
In-Reply-To: <20120705092809.GY1122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>

Hi Tony,

On Thu, Jul 5, 2012 at 2:58 PM, Tony Lindgren <tony@atomide.com> wrote:
> * DebBarma, Tarun Kanti <tarun.kanti@ti.com> [120704 21:07]:
>> On Thu, Jun 14, 2012 at 4:28 PM, Shilimkar, Santosh <santosh.shilimkar@ti.com> wrote:
>> >
>> > Just to let you know that this cleanup is essential for Benoit's OMAP4
>> > hwmod cleanup
>> > and OMAP5 minimal support series.
>>
>> This is a gentle reminder in case you have missed somehow!!
>> Let me know if anything else needs to be done.
>
> Now with the hwmod patch 2/4 pulled into cleanup-part2 from Paul,
> I've also applied patch 1/4 there. Patches 3 and 4 have still some pending
> comments from Kevin it seems?
Yes....

>
> Also at least patch 3 won't apply, so please check Kevin's comments
> and repost patches 3 and 4 on top of cleanup-part2 at commit 74dd9ec62.
Patch 3: Comment was about adding summary in patch 0/x why we have
not removed iclk in OMAP2/3 platform. In other words there was no
specific changes needed on patch 3 as such. BTW, patch 3 is already merged.

Patch 4:
--- [Kevin's comment] ---
>>
>> Comment applies to PATCH 4/4 also.
> You mean removing iclk from clkdev table? That is already done in this patch!!
I meant why can't OMAP2/3 data be removed in PATCH 4/4 also, which only
touches OMAP4.
--- [end] -----------------------
In patch 4 the only change done in the clock table was to correct the
name mis-match
of functional clock names for OMAP4 between clock data and hwmod data.
For OMAP2/3 the names are already matching. As the comment was given in patch 3
where iclk entries got removed for OMAP4, he must have expected similar cleanup
is done for fclk in patch 4. But as I said, only the name mis-match is
corrected.
In summary, there is no specific changes needed in the patch.

I will rebase on top of cleanup-part2 are repost patch 4.
--
Tarun
>
> Regards,
>
> Tony
