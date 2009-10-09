From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [GIT PULL] omap fixes for v2.6.32-rc3
Date: Fri, 9 Oct 2009 15:08:00 +0300
Message-ID: <94a0d4530910090508o1e3d19cew881d2eb348199674@mail.gmail.com>
References: <20091007185112.GJ7899@atomide.com>
	 <94a0d4530910081429m7ad88b43q38245109f3252078@mail.gmail.com>
	 <20091008214140.GJ7417@atomide.com>
	 <94a0d4530910081513w1a919dc2s50eca41966a2261d@mail.gmail.com>
	 <94a0d4530910081520t66ce7567xe142979a35b1245@mail.gmail.com>
	 <20091008232603.GB25892@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760332AbZJIMJv@vger.kernel.org>
In-Reply-To: <20091008232603.GB25892@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Denis Karpov <ext-denis.2.karpov@nokia.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 9, 2009 at 2:26 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Felipe Contreras <felipe.contreras@gmail.com> [091008 15:20]:

<snip/>

>> > Here you can see Uwe Kleine-K=C3=B6nig sending the original patch =
without
>> > even CC'ing the mmc list:
>> > http://marc.info/?l=3Dlinux-kernel&m=3D124820861213849&w=3D2
>> >
>> > And it was unintentionally broken by this one:
>> > http://marc.info/?l=3Dlinux-mmc&m=3D125249763422227&w=3D2
>>
>> Er, actually that one was ok, the problem was introduced only in the
>> final version:
>> http://marc.info/?l=3Dlinux-mmc&m=3D125366315417006&w=3D2
>
> Right, looks like Roger forgot to Cc linux-mmc.
>
>> > I don't see what we are waiting for, the code is clearly broken, e=
ven
>> > the compiler warns that nobody is using omap_hsmmc_probe().
>
> I've sent Roger's patch to Andrew & linux-mmc so hopefully it will ge=
t
> merged soon:
>
> http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg00539.html

I don't see what's specific about mmc in that patch, nor omap. It's
just a fix for an obvious mistake that must be picked ASAP and can't
possibly be NAK'ed.

There's a tree for trivial fixes:
git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial

And one for includecheck:
git://git.kernel.org/pub/scm/linux/kernel/git/jaswinder/linux-2.6

What's the procedure for obvious fixes? I'm CC'ing Greg KH and Andrew
Morton because I think they might interested in fixing these kinds of
issues quickly in the future.

Cheers.

--=20
=46elipe Contreras
