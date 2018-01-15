From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [1/3] mfd/omap-usb-tll: Delete two error messages for a failed
 memory allocation in usbtll_omap_probe()
Date: Mon, 15 Jan 2018 18:06:20 +0100
Message-ID: <ead577ac-a36b-dfc4-9f2c-3d5f34495d78@users.sourceforge.net>
References: <c048a681-70e4-ecdd-e0f8-48c8f1bb0ac4@users.sourceforge.net>
 <7719b4e7-1081-6fa4-6f14-f45cf062482d@users.sourceforge.net>
 <20180115134101.GA6711@lenoch>
 <1ebb5ac5-aa4d-7c19-94db-210b518d562f@users.sourceforge.net>
 <20180115160522.GA2672@lenoch>
 <11eaf92d-3928-531f-35e8-fb5a60ff03e3@users.sourceforge.net>
 <20180115163543.GA10657@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20180115163543.GA10657@lenoch>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

>>> Now, if probe function calls devm_kzalloc two times and one of them fails,
>>> you cannot easily say which one without looking at assembly listing.
>>
>> Will this situation change with any other implementation for such backtraces?
> 
> How much that situation changes depends mainly on that very person who is
> sending bugreport and his/her ability and willigness to eventually change
> said implementation.

Have you got any more influence on the selection?

Which variant was applied for your example?


> In the other words your question (presumably) expects a world of
> ideal backtraces, which is (so far) rarely the case.

I assume that further software evolution will matter.

Does an article like “The ORCs are coming” (by Jonathan Corbet from 2017-07-20)
point information out which is also useful for this issue here?

https://lwn.net/Articles/728339/


> Anyway, if we agree to change the way we allocate driver data here,
> the issue this debate is about will no longer exist.

Does your update suggestion contain still any additional error messages for
memory allocation failures?

Regards,
Markus
