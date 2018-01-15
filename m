From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [1/3] mfd/omap-usb-tll: Delete two error messages for a failed
 memory allocation in usbtll_omap_probe()
Date: Mon, 15 Jan 2018 19:12:37 +0100
Message-ID: <cadb0da1-23d0-f629-8dcf-8d2566058812@users.sourceforge.net>
References: <c048a681-70e4-ecdd-e0f8-48c8f1bb0ac4@users.sourceforge.net>
 <7719b4e7-1081-6fa4-6f14-f45cf062482d@users.sourceforge.net>
 <20180115134101.GA6711@lenoch>
 <1ebb5ac5-aa4d-7c19-94db-210b518d562f@users.sourceforge.net>
 <20180115160522.GA2672@lenoch>
 <11eaf92d-3928-531f-35e8-fb5a60ff03e3@users.sourceforge.net>
 <20180115163543.GA10657@lenoch>
 <ead577ac-a36b-dfc4-9f2c-3d5f34495d78@users.sourceforge.net>
 <20180115174122.GA20745@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180115174122.GA20745@lenoch>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> That said, you might end having only fragment of log in only one of thousands
> And saying technician he needs to use another kernel (upgrade all machines)
> and wait another several weeks for bug to trigger is no way.

This was not really my intention here.


> So until evolution reaches ARM land, my point stands unchanged:
> Make it single allocation

Did I indicate a similar design direction (for the preferred stack trace
convenience) after your constructive feedback?


> or leave one of those two messages in place.

Are there any more preferences involved?


> In practice it probably does not matter if we know which allocation
> failed. We simply run out of memmory.

Would anybody insist to know for which driver instance an allocation attempt
was performed?


>> Does your update suggestion contain still any additional error messages for
>> memory allocation failures?
> 
> Of course not as there will be only one memory allocation in the probe function.

Thanks for this clarification. - So I hope that your solution approach
will be also fine. Will it supersede my proposal?

Regards,
Markus
