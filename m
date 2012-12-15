From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] fbdev changes for 3.8
Date: Sat, 15 Dec 2012 13:11:04 -0800
Message-ID: <CA+55aFz9+3mOZcjJ9C-izKkidT9mxeO7xUubJER0OTjcZjE=2A@mail.gmail.com>
References: <50CAFDFF.3070802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50CAFDFF.3070802@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 14, 2012 at 2:22 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi Linus,
>
> Florian, the fbdev maintainer, has been very busy lately, so I offered to send
> the pull request for fbdev for this merge window.

Pulled. However, with this I get the Kconfig question

   OMAP2+ Display Subsystem support (OMAP2_DSS) [N/m/y/?] (NEW)

which doesn't make a whole lot of sense on x86-64, unless there's
something about OMAP2 that I don't know.

So I'd suggest making that OMAP2_DSS be dependent on OMAP2. Or at
least ARM. Because showing it to anybody else seems insane.

Same goes for FB_OMAP2 for that matter. I realize that it's likely
nice to get compile testing for this on x86-64 too, but if that's the
intent, we need to think about it some more. I don't think it's good
to ask actual normal users questions like this just for compile
coverage.

Hmm?

                    Linus
