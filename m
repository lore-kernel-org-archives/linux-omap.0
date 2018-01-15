From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: mfd/omap-usb-tll: Allocate driver data at once in
 usbtll_omap_probe()
Date: Mon, 15 Jan 2018 20:04:03 +0100
Message-ID: <8144f711-b4fd-730c-4e9f-780c42d5e68f@users.sourceforge.net>
References: <c048a681-70e4-ecdd-e0f8-48c8f1bb0ac4@users.sourceforge.net>
 <7719b4e7-1081-6fa4-6f14-f45cf062482d@users.sourceforge.net>
 <20180115134101.GA6711@lenoch>
 <1ebb5ac5-aa4d-7c19-94db-210b518d562f@users.sourceforge.net>
 <20180115160522.GA2672@lenoch>
 <11eaf92d-3928-531f-35e8-fb5a60ff03e3@users.sourceforge.net>
 <20180115163543.GA10657@lenoch>
 <ead577ac-a36b-dfc4-9f2c-3d5f34495d78@users.sourceforge.net>
 <20180115174122.GA20745@lenoch>
 <cadb0da1-23d0-f629-8dcf-8d2566058812@users.sourceforge.net>
 <20180115183059.GA30039@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20180115183059.GA30039@lenoch>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

>> So I hope that your solution approach will be also fine.
>> Will it supersede my proposal?
> 
> Who knows, perhaps it would be the best if you could judge yourself...

I am also curious on how other contributors will respond to
your following update suggestion.


> 8<--------
> 
> Subject: [PATCH] mfd/omap-usb-tll: Allocate driver data at once

Would it have been clearer to use this information as the subject
for this reply already?

Are you fine with that this change approach was recorded in
a possibly questionable format?
https://patchwork.kernel.org/patch/10165193/


> Allocating memory to store clk array together with driver
> data simplifies error unwinding and allows deleting memory
> allocation failure message as there is now only single point
> where allocation could fail.

* Will it matter to mention the previous software situation a bit
  in such a commit description?

* Would you like to add a tag “link”?

* Are you going to “supersede” any more source code adjustments
  around questionable error messages?

Regards,
Markus
