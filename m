From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: omapfb/dss: Delete an error message for a failed memory
 allocation in three functions
Date: Tue, 28 Nov 2017 11:15:37 +0100
Message-ID: <28816ce9-9d62-7d61-1889-64407eececca@users.sourceforge.net>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
 <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
 <1511809633.32426.70.camel@perches.com>
 <d82fbab2-865f-3051-f487-d310ee819cf3@users.sourceforge.net>
 <1511833514.32426.86.camel@perches.com>
 <7e7e64cf-dbe5-614a-f1e5-29d7b6cf9297@users.sourceforge.net>
 <1511856244.19952.14.camel@perches.com>
 <0ecf4b17-7757-adb4-b978-a80ebb15cfe6@users.sourceforge.net>
 <alpine.DEB.2.20.1711281026410.3443@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1711281026410.3443@hadrien>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Joe Perches <joe@perches.com>, "Andrew F. Davis" <afd@ti.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

>>> Many people do not know that a generic kmalloc does a
>>> dump_stack() on OOM.
>>
>> This is another interesting information, isn't it?
>>
>> It is expected that the function “devm_kzalloc” has got a similar property.
> 
> 
> You don't have to expect this.  Go look at the definition of devm_kzalloc
> and see whether it has the property or not.

I find that the corresponding documentation of these programming interfaces
is incomplete for a desired format which could be different than C source code.

https://elixir.free-electrons.com/linux/v4.15-rc1/source/include/linux/device.h#L657
https://elixir.free-electrons.com/linux/v4.15-rc1/source/drivers/base/devres.c#L763
https://www.kernel.org/doc/html/latest/driver-api/basics.html#c.devm_kmalloc

Can the Coccinelle software help more to determine desired function properties?


>> For which hardware and software combinations would you like to see
>> facts there?
> 
> This is not for Joe to decide,

This view is fine in principle.


> it's for the person who receives the patch to decide.

I am curious on further comments from these contributors.


> You could start with the ones for which the code actually compiles,
> using the standard make file and no special options, and a
> recent version of gcc.

The variation space could become too big to handle for me (alone).
How will this aspect evolve further?

Regards,
Markus
