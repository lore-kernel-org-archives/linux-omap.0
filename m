From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC][PATCH] OMAP3: add support for 2 SDRAM chip selects
Date: Mon, 08 Jun 2009 10:28:20 -0700
Message-ID: <87eitu63ez.fsf@deeprootsystems.com>
References: <200904291553.49378.jpihet@mvista.com>
	<200906081102.00779.jpihet@mvista.com>
	<6ed0b2680906080401g64ed4dbcpa24bbad3841a2b2d@mail.gmail.com>
	<200906081911.33673.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:64276 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144AbZFHR2V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 13:28:21 -0400
Received: by pzk1 with SMTP id 1so2390391pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2009 10:28:23 -0700 (PDT)
In-Reply-To: <200906081911.33673.jpihet@mvista.com> (Jean Pihet's message of "Mon\, 8 Jun 2009 19\:11\:33 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>

Jean Pihet <jpihet@mvista.com> writes:

> Hi Kevin,
>
> On Monday 08 June 2009 13:01:18 Grazvydas Ignotas wrote:
>> > =A0static void __init omap3pandora_init_irq(void)
>> > =A0{
>> > - =A0 =A0 =A0 omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL=
,
>> > + =A0 =A0 =A0 omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mt46h32m3=
2lf6_sdrc_params,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, NULL=
, NULL);
>>
>> Hm, since pandora uses OMAP3530, maybe it should also have
>> omap3_*_rate_table args passed? Could also be true for Overo, at lea=
st
>> for omap3_mpu_rate_table and omap3_l3_rate_table, as some models use
>> OMAP3503 without the DSP.
>
> Which table rates shall we pass for Overo and Pandora?
> I will update the patch set with the needed ones.
>

Let's leave any rate table changes out of this series.  That is an
unrelated change.

The Pandora/Overo folks should do some testing with the current rate
tables and DVFS/CPUfreq to see if they work for them.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
