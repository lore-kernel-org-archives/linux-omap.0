From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH 6/6] omap: move generic omap3 features to generic
Date: Tue, 1 Jun 2010 11:04:15 +0530
Message-ID: <AANLkTilLDPZqmFfVbey0aFixbWRZ4lyAklTuvu5Kv84A@mail.gmail.com>
References: <1274585799-16226-1-git-send-email-nm@ti.com>
	<1274585799-16226-2-git-send-email-nm@ti.com>
	<1274585799-16226-3-git-send-email-nm@ti.com>
	<1274585799-16226-4-git-send-email-nm@ti.com>
	<1274585799-16226-5-git-send-email-nm@ti.com>
	<1274585799-16226-6-git-send-email-nm@ti.com>
	<1274585799-16226-7-git-send-email-nm@ti.com>
	<AANLkTinsrRAYX4dvB8A8wPayfRc7wkULQtUSiJ9RxbWh@mail.gmail.com>
	<4BFE9C14.9040703@ti.com>
	<AANLkTinHOZXk9pYeSfsBiejU7x1w-rA2MRtC4BBoKK0r@mail.gmail.com>
	<4C03ED47.6060308@gmail.com>
	<AANLkTin32ueXXPjVFbLt-cur2WlmFOmgPj6Zlr47tuff@mail.gmail.com>
	<4C040B76.2090605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.211.179]:39661 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab0FAFeR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 01:34:17 -0400
Received: by ywh9 with SMTP id 9so3250838ywh.17
        for <linux-omap@vger.kernel.org>; Mon, 31 May 2010 22:34:16 -0700 (PDT)
In-Reply-To: <4C040B76.2090605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

On Tue, Jun 1, 2010 at 12:48 AM, Nishanth Menon <nm@ti.com> wrote:
> On 05/31/2010 09:46 PM, S, Venkatraman wrote:
>>
>> I understand that you might not have all platforms to test with, but
>> let's not provide a
>> 'generic feature api' without it being available for the supported
>> platforms.
>> It's incomplete without it.
>
> well.. if you did read 0/6
> http://marc.info/?l=linux-omap&m=127458581708411&w=2
> "Caveat: this series just introduces the framework by reorganizing
> the existing data, it does not attempt to define what the features
> for OMAP1,2,3,4 would be. As usual, comments are welcome.
> "

I did see this. My point was the 6/6 claims to do $foo (where $foo=
make it generic)
doesn't fit with a caveat description (My patch doesn't do $foo)

> :) anyways, these are how the three follow on patches will look like (sample
> omap1,2,4 patches are attached), feel free to ack them after testing - but
> this patch 6/6 needs to be done prior to the remaining being added - that is
> one more reason why i stopped where I did.

If you can post them formally as part of the series, I can test and
ack them (with OMAP3, OMAP4)
My original comment was even if these were not implemented due to some
constraints, they should be
mentioned in the code (as TODO / FIXME etc). The caveat description is
not going to show up in
commit logs or printks
