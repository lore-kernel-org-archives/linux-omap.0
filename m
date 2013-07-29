From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every
 GPIO on DT
Date: Mon, 29 Jul 2013 08:54:14 +0200
Message-ID: <51F61196.7050804@ahsoftware.de>
References: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk> <51F4F973.8000303@ahsoftware.de> <CACRpkda8byMWTQ5n24MsUBacpcHDcf=P9KzjcckT-KyAFEinHw@mail.gmail.com> <51F515A9.9010005@ahsoftware.de> <CACRpkdbCpbkSe1+Ap1yLm+iCDy3rnHL1LYTxCVJkmwdrNJCKGQ@mail.gmail.com> <448912EABC71F84BBCADFD3C67C4BE5283E9D4@DBDE04.ent.ti.com> <CACRpkdbqpQ81o9b-wswNKxcDznL+o7pZy9n-8fFr67Kkrkm+1g@mail.gmail.com> <CAAwP0s18ouM7wMm=dGCbWzukf-ikpB+yarNO5d2OZLjuQei8eA@mail.gmail.com> <CACRpkdYEmzh-Viq+vj6-99yz8=Ghn=e3Xe5_UYvsSkTr0g8JyQ@mail.gmail.com> <CAAwP0s3_LXK9dgRdaYC5dQ6swMgiUc4ujSM-8tyDZnfSRViZFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:48716 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab3G2Gyt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 02:54:49 -0400
Received: from eiche.ahsoftware (p57B216E0.dip0.t-ipconnect.de [87.178.22.224])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ahsoftware.de (Postfix) with ESMTPSA id 4A6FE423C03C
	for <linux-omap@vger.kernel.org>; Mon, 29 Jul 2013 08:54:47 +0200 (CEST)
In-Reply-To: <CAAwP0s3_LXK9dgRdaYC5dQ6swMgiUc4ujSM-8tyDZnfSRViZFQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, ext Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jon Hunter <jgchunter@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Aaro Koskinen <aaro.koskinen@iki.fi>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

Am 28.07.2013 21:30, schrieb Javier Martinez Canillas:
> On Sun, Jul 28, 2013 at 8:22 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Sun, Jul 28, 2013 at 7:33 PM, Javier Martinez Canillas
>> <martinez.javier@gmail.com> wrote:
>>

>
>> I wish we already had the DTS schema parser and checks
>> in place. In that case I could just ask if the DTS is well-formed,
>> and you could say "yes" or "no", and if it was no, it's just an
>> invalid DTS file.
>>
>
> Indeed, hopefully we will have schema validation in dtc soon so we
> could validate if DTS are well-formed and test if our changes breaks
> valid DTS or not.

That won't help with the current problem because the DTS doesn't know 
that some code want's to use a gpio as irq, so that can't be verified.

Regards,

Alexander Holler

