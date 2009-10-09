From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [GIT PULL] omap fixes for v2.6.32-rc3
Date: Fri, 9 Oct 2009 20:29:24 +0300
Message-ID: <94a0d4530910091029p12f8c28fve91e95db533e78e5@mail.gmail.com>
References: <20091007185112.GJ7899@atomide.com>
	 <94a0d4530910081429m7ad88b43q38245109f3252078@mail.gmail.com>
	 <20091008214140.GJ7417@atomide.com>
	 <94a0d4530910081513w1a919dc2s50eca41966a2261d@mail.gmail.com>
	 <94a0d4530910081520t66ce7567xe142979a35b1245@mail.gmail.com>
	 <20091008232603.GB25892@atomide.com>
	 <94a0d4530910090508o1e3d19cew881d2eb348199674@mail.gmail.com>
	 <20091009144840.GA9561@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933569AbZJIRbR@vger.kernel.org>
In-Reply-To: <20091009144840.GA9561@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Denis Karpov <ext-denis.2.karpov@nokia.com>, Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 9, 2009 at 5:48 PM, Greg KH <gregkh@suse.de> wrote:
> On Fri, Oct 09, 2009 at 03:08:00PM +0300, Felipe Contreras wrote:
>> On Fri, Oct 9, 2009 at 2:26 AM, Tony Lindgren <tony@atomide.com> wro=
te:
>> > * Felipe Contreras <felipe.contreras@gmail.com> [091008 15:20]:
>>
>> <snip/>
>>
>> >> > Here you can see Uwe Kleine-K??nig sending the original patch w=
ithout
>> >> > even CC'ing the mmc list:
>> >> > http://marc.info/?l=3Dlinux-kernel&m=3D124820861213849&w=3D2
>> >> >
>> >> > And it was unintentionally broken by this one:
>> >> > http://marc.info/?l=3Dlinux-mmc&m=3D125249763422227&w=3D2
>> >>
>> >> Er, actually that one was ok, the problem was introduced only in =
the
>> >> final version:
>> >> http://marc.info/?l=3Dlinux-mmc&m=3D125366315417006&w=3D2
>> >
>> > Right, looks like Roger forgot to Cc linux-mmc.
>> >
>> >> > I don't see what we are waiting for, the code is clearly broken=
, even
>> >> > the compiler warns that nobody is using omap_hsmmc_probe().
>> >
>> > I've sent Roger's patch to Andrew & linux-mmc so hopefully it will=
 get
>> > merged soon:
>> >
>> > http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg00539.htm=
l
>>
>> I don't see what's specific about mmc in that patch, nor omap. It's
>> just a fix for an obvious mistake that must be picked ASAP and can't
>> possibly be NAK'ed.
>>
>> There's a tree for trivial fixes:
>> git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial
>>
>> And one for includecheck:
>> git://git.kernel.org/pub/scm/linux/kernel/git/jaswinder/linux-2.6
>>
>> What's the procedure for obvious fixes? I'm CC'ing Greg KH and Andre=
w
>> Morton because I think they might interested in fixing these kinds o=
f
>> issues quickly in the future.
>
> What kind of issues? =C2=A0Why would I be interested, where is the pr=
oblem?

The obvious-brain-dead-duh kind of issues, like this one.

The problem is that OMAP devices (like beagleboard) are not booting
correctly right now because of a wrong merge. It has been identified,
tested, and acked, but nobody has picked it up for a pull request, so
it's not clear it will be on -rc4.

To me it's not clear who should push the patch, it seems it doesn't
belong on linux-omap, so Tony is pushing it through linux-mmc, which I
don't think is the right place. They should be handling mmc-related
issues, not obvious breakage.

In order to keep the engines oiled I think there must be a process to
flag obvious generic breakage so it's immediately picked; maybe an
'obvious-fixes' tree, or a 'simple-fixes' that has 'trivial',
'includecheck', and similar, or maybe nothing needs to be done. Up to
you to decide.

Cheers.

--=20
=46elipe Contreras
