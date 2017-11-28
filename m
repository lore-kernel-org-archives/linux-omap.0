From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: omapfb/dss: Delete an error message for a failed memory
 allocation in three functions
Date: Tue, 28 Nov 2017 12:41:30 +0100
Message-ID: <20171128114130.GA1615@lenoch>
References: <1511809633.32426.70.camel@perches.com>
 <d82fbab2-865f-3051-f487-d310ee819cf3@users.sourceforge.net>
 <1511833514.32426.86.camel@perches.com>
 <7e7e64cf-dbe5-614a-f1e5-29d7b6cf9297@users.sourceforge.net>
 <1511856244.19952.14.camel@perches.com>
 <0ecf4b17-7757-adb4-b978-a80ebb15cfe6@users.sourceforge.net>
 <alpine.DEB.2.20.1711281026410.3443@hadrien>
 <28816ce9-9d62-7d61-1889-64407eececca@users.sourceforge.net>
 <20171128102327.GA30267@lenoch>
 <796a5c89-7c72-776d-e769-e52f5e5bf43f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <796a5c89-7c72-776d-e769-e52f5e5bf43f@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Julia Lawall <julia.lawall@lip6.fr>, Joe Perches <joe@perches.com>, "Andrew F. Davis" <afd@ti.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 28, 2017 at 11:50:14AM +0100, SF Markus Elfring wrote:
> >> How will this aspect evolve further?
> > 
> > I do not follow.
> 
> Interesting …
> 
> > This is OMAP framebuffer driver, so in this case, there is zero variation.
> 
> How much are you interested to compare differences in build results
> also for this software module because of varying parameters?
> 
> Which parameters were applied for your size comparisons so far?

It was just omap2plus_defconfig build using gcc-7.2.0

> > Could you, please, review following patch
> 
> I assume that other OMAP developers are in a better position to decide
> about the deletion of extra memory allocations (instead of keeping
> questionable error messages).
> 
> > and verify is it satisfies your automated static code analysis test?
> 
> I am not going to “verify” your update suggestion by my evolving approaches
> around the semantic patch language (Coccinelle software) at the moment.

As you are sending patches as Markus Elfring I would expect you take
Coccinelle's suggestion into account and actually try to understand code
before sending patch. That suggestion may lead to actual bug in code
which your patch just leaves unnoticed as it is not apparent from
the patch itself (no, not talking about this very patch it all started
with)

That said, I'm considering Markus Elfring being a human. If you do not like
reactions to your patches or are interested only in improving tool that
generates them, it would be better to just setup a "tip bot for Markus
Elfring" and let it send patches automatically. This way noone is going
to waste time on them as it would be clear those are purely machine only
generated and there's no point to reply.

The way you are sending patches makes impression (at least to me), that
you spent some time on fixing issue Coccinelle found and not just shut
the warning up.

> But I thank you for this contribution.
> How will further feedback evolve for such an idea?

And the idea is?

> Regards,
> Markus

Thank you,
	ladis
