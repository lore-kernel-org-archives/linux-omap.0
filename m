From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: mfd/omap-usb-tll: Allocate driver data at once in
 usbtll_omap_probe()
Date: Mon, 15 Jan 2018 20:23:03 +0100
Message-ID: <20180115192303.GA31762@lenoch>
References: <20180115134101.GA6711@lenoch>
 <1ebb5ac5-aa4d-7c19-94db-210b518d562f@users.sourceforge.net>
 <20180115160522.GA2672@lenoch>
 <11eaf92d-3928-531f-35e8-fb5a60ff03e3@users.sourceforge.net>
 <20180115163543.GA10657@lenoch>
 <ead577ac-a36b-dfc4-9f2c-3d5f34495d78@users.sourceforge.net>
 <20180115174122.GA20745@lenoch>
 <cadb0da1-23d0-f629-8dcf-8d2566058812@users.sourceforge.net>
 <20180115183059.GA30039@lenoch>
 <8144f711-b4fd-730c-4e9f-780c42d5e68f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8144f711-b4fd-730c-4e9f-780c42d5e68f@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 15, 2018 at 08:04:03PM +0100, SF Markus Elfring wrote:
> >> So I hope that your solution approach will be also fine.
> >> Will it supersede my proposal?
> > 
> > Who knows, perhaps it would be the best if you could judge yourself...
> 
> I am also curious on how other contributors will respond to
> your following update suggestion.
> 
> 
> > 8<--------
> > 
> > Subject: [PATCH] mfd/omap-usb-tll: Allocate driver data at once
> 
> Would it have been clearer to use this information as the subject
> for this reply already?
> 
> Are you fine with that this change approach was recorded in
> a possibly questionable format?
> https://patchwork.kernel.org/patch/10165193/

Sure. It does not seem anyone involved cares about patchwork.

> > Allocating memory to store clk array together with driver
> > data simplifies error unwinding and allows deleting memory
> > allocation failure message as there is now only single point
> > where allocation could fail.
> 
> * Will it matter to mention the previous software situation a bit
>   in such a commit description?
> 
> * Would you like to add a tag “link”?

Are you okay with this one?
https://lkml.org/lkml/2018/1/15/411

> * Are you going to “supersede” any more source code adjustments
>   around questionable error messages?

I'm going to handle it usual way:
- wait for feedback and modify accordingly
- collect tags
- resend as v2

Also, patch contains all your changes, so you should be credited
somehow - hence the need for v2 anyway.

What about:
[marcus: simplified error unwinding, error message removal]
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Feel free to propose anything else.

Best regards,
	ladis
