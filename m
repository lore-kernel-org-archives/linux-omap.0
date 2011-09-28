From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v3 3/6] OMAP3+: use DPLL's round_rate when setting rate
Date: Wed, 28 Sep 2011 15:39:26 -0700
Message-ID: <CAJOA=zPq__48SbsKeFHaQ_+J0YQYLLXBP67g2JGXknhWj7PNOA@mail.gmail.com>
References: <1316195281-14988-1-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1109280059380.4399@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:39967 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932116Ab1I1Wju convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Sep 2011 18:39:50 -0400
Received: by mail-wy0-f181.google.com with SMTP id 19so602286wyf.12
        for <linux-omap@vger.kernel.org>; Wed, 28 Sep 2011 15:39:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1109280059380.4399@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Wed, Sep 28, 2011 at 12:02 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi,
>
> On Fri, 16 Sep 2011, Jon Hunter wrote:
>
>> From: Mike Turquette <mturquette@ti.com>
>>
>> omap3_noncore_dpll_set_rate uses omap2_dpll_round_rate explicitly. =A0=
Instead
>> use the struct clk pointer's round_rate function to allow for DPLL's=
 with
>> special needs.
>>
>> Also the rounded rate can differ from target rate, so to better refl=
ect
>> reality set clk->rate equal to the rounded rate when setting DPLL fr=
equency.
>> This avoids issues where the DPLL frequency is slightly different th=
an what
>> debugfs clock tree reports using the old target rate.
>>
>> An example of both of these needs is DPLL_ABE on OMAP4 which can hav=
e a 4x
>> multiplier on top of the usual MN dividers depending on register set=
tings.
>> This requires a special round_rate function that might yield a rate
>> different from the initial target.
>>
>> Signed-off-by: Mike Turquette <mturquette@ti.com>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>
> The two separate changes in this patch have been separated out into t=
wo
> patches - both included below. =A0Please let me know if you have any
> comments; otherwise, I'll queue for 3.2.

The split patches look good to me.  I have another patch which does a
similar thing (converts omap2_get_dpll_rate use to clk->recalc) which
fixes yet more bugs that plague DPLL_ABE.  Will send across shortly;
hopefully can make it into 3.2?

Regards,
Mike
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
