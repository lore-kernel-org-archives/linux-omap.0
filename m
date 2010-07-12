From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: ARM defconfig files
Date: Mon, 12 Jul 2010 09:51:47 -0700
Message-ID: <AANLkTilhI9O6YwnuAylo_jNgwR8VXmpSVJ1kylIYPCGT@mail.gmail.com>
References: <20100603074548.GA12104@flint.arm.linux.org.uk>
	<alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org>
	<20100603181010.GA25779@flint.arm.linux.org.uk>
	<1275589230.23384.19.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1006031119440.8175@i5.linux-foundation.org>
	<20100614083214.GA2104@pengutronix.de>
	<20100630104043.GG11746@pengutronix.de>
	<20100712155518.GA24144@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100712155518.GA24144@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Daniel Walker <dwalker@codeaurora.org>, Nicolas Pitre <nico@fluxnic.net>, Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-msm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Eric Miao <eric.miao@canonical.com>, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

2010/7/12 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
>
> As you havn't replied up to now I wonder if that just means that you
> still plan to remove all defconfig files or if you are just busy doing
> other things.

The reason I haven't replied is that

 (a) I don't think this really "solves" the issue, in that the
resulting files still aren't human-readable, and as such I suspect it
doesn't solve the problem in the long run: people will continue to
just run "make config" and then copy the resulting .config file as a
defconfig file.

and

 (b) even if ARM were to go this way, and run the scripts to minimize
the defconfig files, that's not something _I_ would do. If I get tired
of seeing the insane pull requests where 90% of the crap is just
defconfig noise, then _my_ solution will be to remove the crap because
I simply am never going to be the person who maintains those defconfig
files.

See? Especially the "(b)" part is relevant - I am simply not going to
be the person who tries to clean up after other people sh*tting all
over their trees with defconfig files.  If I do something, it will be
total surgery, ie "keep your damn broken defconfig files somewhere
else than in my tree - I'm tired of your stupidities". It will not be
"I'll be your mother and clean up your room every day after you made a
mess".

So if the ARM people decide that your script is a good way to clean up
the mess, I might be happy with that. But that would require that they
NEVER EVER try to push me a update that contains an un-cleaned-up
defconfig file. If they do, and the defconfig files end up showing up
big in git history, then the approach has failed.

See? The reason I'm not replying to your approach is that it's simply
not for me to do so (and no, I don't think it's maintainable, but I
haven't tried it, so..)

                            Linus
