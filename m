From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [1/3] mfd/omap-usb-tll: Delete two error messages for a failed
 memory allocation in usbtll_omap_probe()
Date: Mon, 15 Jan 2018 18:41:22 +0100
Message-ID: <20180115174122.GA20745@lenoch>
References: <c048a681-70e4-ecdd-e0f8-48c8f1bb0ac4@users.sourceforge.net>
 <7719b4e7-1081-6fa4-6f14-f45cf062482d@users.sourceforge.net>
 <20180115134101.GA6711@lenoch>
 <1ebb5ac5-aa4d-7c19-94db-210b518d562f@users.sourceforge.net>
 <20180115160522.GA2672@lenoch>
 <11eaf92d-3928-531f-35e8-fb5a60ff03e3@users.sourceforge.net>
 <20180115163543.GA10657@lenoch>
 <ead577ac-a36b-dfc4-9f2c-3d5f34495d78@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ead577ac-a36b-dfc4-9f2c-3d5f34495d78@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 15, 2018 at 06:06:20PM +0100, SF Markus Elfring wrote:
> >>> Now, if probe function calls devm_kzalloc two times and one of them fails,
> >>> you cannot easily say which one without looking at assembly listing.
> >>
> >> Will this situation change with any other implementation for such backtraces?
> > 
> > How much that situation changes depends mainly on that very person who is
> > sending bugreport and his/her ability and willigness to eventually change
> > said implementation.
> 
> Have you got any more influence on the selection?

?

> Which variant was applied for your example?

ARM_UNWIND

> > In the other words your question (presumably) expects a world of
> > ideal backtraces, which is (so far) rarely the case.
> 
> I assume that further software evolution will matter.
> 
> Does an article like “The ORCs are coming” (by Jonathan Corbet from 2017-07-20)
> point information out which is also useful for this issue here?
> 
> https://lwn.net/Articles/728339/

I'm aware of this article. Please bear in mind which driver you are modifying.
Not everything is desktop or server machine with almost unlimited resources
and embedded people are rarely using latest stuff with all that bells and
whistles.

That said, you might end having only fragment of log in only one of thousands
machines in field. And saying technician he needs to use another kernel
(upgrade all machines) and wait another several weeks for bug to trigger
is no way.

So until evolution reaches ARM land, my point stands unchanged: Make it
single allocation or leave one of those two messages in place.

In practice it probably does not matter if we know which allocation
failed. We simply run out of memmory.

> > Anyway, if we agree to change the way we allocate driver data here,
> > the issue this debate is about will no longer exist.
> 
> Does your update suggestion contain still any additional error messages for
> memory allocation failures?

Of course not as there will be only one memory allocation in the probe
function.

Best regards,
	ladis
