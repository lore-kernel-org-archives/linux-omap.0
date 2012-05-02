From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 01/19] ARM: OMAP4: PM: save/restore all DPLL settings in
 OFF mode
Date: Wed, 2 May 2012 17:16:19 +0530
Message-ID: <CAMQu2gxSKaLhd3qMYpE75_X8gLDrjBWbt3oAf52LE3NjfE=5qg@mail.gmail.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
 <1334914432-26456-2-git-send-email-t-kristo@ti.com> <B5906170F1614E41A8A28DE3B8D121433EA6B68E@DBDE01.ent.ti.com>
 <CAMQu2gwCstL6eF92_QBDYZaA5xwxD9a+YWRVxdghA5WVkp4PEQ@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433EA6C848@DBDE01.ent.ti.com>
 <CAMQu2gxcUw5A-p25xdYeXfy=tLbDNPsjV_5MJ6s5qGNfn4Zbfw@mail.gmail.com> <B5906170F1614E41A8A28DE3B8D121433EA6D93B@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:60227 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752226Ab2EBLqm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 07:46:42 -0400
Received: by qadb15 with SMTP id b15so2779848qad.9
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 04:46:39 -0700 (PDT)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EA6D93B@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "Kristo, Tero" <t-kristo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, May 2, 2012 at 5:10 PM, Bedia, Vaibhav <vaibhav.bedia@ti.com> wrote:
> On Wed, May 02, 2012 at 16:30:26, Shilimkar, Santosh wrote:
> [...]
>
>> >> How ?
>> >> SRAM is sower memory than DDR so I don't see how it
>> >> will reduce latency.
>> >>
>> >
>> > I am just guessing if that's indeed the case ;)
>> > Haven't done any measurements to really check if that's indeed the case though.
>> >
>> You don't have to do any real measurements at least on OMAP.
>> OCMC RAM is interfaced over L4 and MPU has to cross two interconnect
>> bridges to reach to SRAM. DDR is more of direct path and much faster.
>>
>
> Hmm, I was under the impression that OCMC RAM was on L3, at least for OMAP4.
Nope. It's on L4 and it is same for all OMAPs including OMAP5

> Maybe there's a extra low latency path for DDR that I am missing.
Even OMAP3 DDR is faster than OCMC RAM.

Regards
Santosh
