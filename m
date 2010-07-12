From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: ARM defconfig files
Date: Mon, 12 Jul 2010 12:34:59 -0700
Message-ID: <AANLkTim-O00n9YPv7w4VCKjN-ETLijyTHomWUn4mZtTV@mail.gmail.com>
References: <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org>
	<20100603181010.GA25779@flint.arm.linux.org.uk>
	<1275589230.23384.19.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1006031119440.8175@i5.linux-foundation.org>
	<20100614083214.GA2104@pengutronix.de>
	<20100630104043.GG11746@pengutronix.de>
	<20100712155518.GA24144@pengutronix.de>
	<AANLkTilhI9O6YwnuAylo_jNgwR8VXmpSVJ1kylIYPCGT@mail.gmail.com>
	<20100712173228.GC9897@n2100.arm.linux.org.uk>
	<AANLkTinxUqzxClVDTyruJ6kzFTganXUGJJHJ5wRi9Iak@mail.gmail.com>
	<20100712185029.GB14425@pengutronix.de>
	<AANLkTinOuU-VVXaMwMp69CBp2Y4wxpoWybEQ34H5j0lJ@mail.gmail.com>
	<alpine.LFD.2.00.1007121510260.10598@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.LFD.2.00.1007121510260.10598@xanadu.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Daniel Walker <dwalker@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-msm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, Eric Miao <eric.miao@canonical.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 12, 2010 at 12:17 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>>
>> =A0 =A0Put another way: I realize that fairly late in the -rc series is
>> actually a really good time to do this, rather than during the merge
>> window itself when things are in flux. However, while it would be a
>> good time to pull this for that reason, it's also a _horrible_ time to
>> pull if it then regresses the defconfig uses, or if it causes horrible
>> problems for linux-next merging etc.
>
> This cannot be any worse than wholesale removal of those files as you
> were contemplating at some point. =A0Furthermore, on ARM we have someone
> providing automatic rebuild of all defconfigs already, so any serious
> issue should be noticed right away.

You aren't really answering the question. The thing is, the wholesale
removal wouldn't happen during the late -rc anyway, and it wouldn't
cause any merge issues (merge conflicts where the file is just to be
removed are trivial to take care of).

So I'm really asking about the issue of "how does this work during the
late -rc phase". Where the _timing_ is the important thing.

Because I could as easily pull after 2.6.35 is out. That has it's own
downsides (with all the merging going on), but at the same time, it's
clearly the right time for a large change.

So when I ask about timing and "how does this work in late -rc", it's
really about how safe it is to do now. Because if it isn't very
obviously safe, I can't pull it.

One part of the "obviously safe" thing is verification for each
defconfig file that the end result is identical with the reduced
version. Uwe implied that it was, and that was clearly the intention,
but was there some explicit verification that yes, the
before-and-after configurations are 100% the same?

Also, I assume that while it's _mostly_ a transparent change to users,
it does require that people do "make oldconfig" with the reduced
defconfig file first, in order to avoid having to answer with the
defaults. No? And the reduced defconfig files obviously do depend on
the default in the Kconfig files themselves, so it does have that kind
of fairly subtle semantic change that may not be entirely obvious or
easy to notice.

So from a timing standpoint, I just want to be convinced that "late
-rc" really is the right thing. I'm not entirely sure it is, even
though I do see advantages.

> I think Uwe could provide his script and add it to the kernel tree.
> Then all architectures could benefit from it. =A0Having the defconfig
> files contain only those options which are different from the defaults
> is certainly more readable, even on x86.

Quite possible. But maintainers would need to be on the lookout of
people actually using the script, and refusing to apply patches that
re-introduce the whole big thing.

I also haven't actually seen the script - I don't think Uwe ever
posted it - so maybe it's some very fragile thing. Hard to judge on no
real information ;^p

               Linus
