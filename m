From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/5] OMAP3&4: Fixes in setup/suspend/powerdomain
Date: Tue, 14 Dec 2010 11:53:15 -0800
Message-ID: <87lj3srv10.fsf@deeprootsystems.com>
References: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
	<alpine.DEB.2.00.1012132342030.15971@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:40290 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759840Ab0LNTxT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 14:53:19 -0500
Received: by gwb20 with SMTP id 20so841494gwb.1
        for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 11:53:19 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012132342030.15971@utopia.booyaka.com> (Paul
	Walmsley's message of "Mon, 13 Dec 2010 23:43:56 -0700 (MST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Beno=C3=AEt, Kevin,
>
> On Mon, 13 Dec 2010, Benoit Cousson wrote:
>
>> This is a series of fixes on OMAP3/4 in setup apis,
>> in the suspend framework and in powerdomain modelling
>> for OMAP4.
>
> ...
>
>> Rajendra Nayak (3):
>>   OMAP4: PM: Use the lowpwrstatechange feature on OMAP4
>>   OMAP4: PM: Do not assume clkdm supports hw transitions
>
> The above two patches should be run by Kevin for his ack (cc'ed on th=
is=20
> message).  Kevin, care to ack these?

I had some comments on the first, and ack'd the second.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
