From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: v3.5-rc4 doesn't wake from dynamic idle on 3530ES3 Beagle
Date: Thu, 28 Jun 2012 11:45:18 +0530
Message-ID: <CAMQu2gztSV1qtgea9rL46orqTFR-vQkES5fen4GCqEfBh046-Q@mail.gmail.com>
References: <alpine.DEB.2.00.1206271101220.27496@utopia.booyaka.com> <alpine.DEB.2.00.1206271318070.27496@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:51000 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932289Ab2F1GPk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 02:15:40 -0400
Received: by qcsq13 with SMTP id q13so1237094qcs.17
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 23:15:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1206271318070.27496@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, govindraj.raja@ti.com, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Felipe Balbi <balbi@ti.com>

+ Shubro, Felipe,

On Thu, Jun 28, 2012 at 12:57 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 27 Jun 2012, Paul Walmsley wrote:
>
>> Looks like something broke between v3.5-rc3 and v3.5-rc4 with dynami=
c
>> idle on 3530ES3 Beagle. =A037xx EVM doesn't seem to be affected.
>>
>> Taking a closer look now.
>
> Reverting commit 91930652a23de0873a157aa1d9962cb878d64451 ("OMAP2+: U=
ART:
> Add mechanism to probe uart pins and configure rx wakeup") makes wake=
up
> from dynamic retention idle work again.
>
I suspected this.
This could be because, all the board are now expected to setup the pin
configurations.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
