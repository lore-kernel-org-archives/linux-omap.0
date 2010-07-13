From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: ARM defconfig files
Date: Tue, 13 Jul 2010 09:07:41 +0200
Message-ID: <20100713070741.GB26442@pengutronix.de>
References: <20100630104043.GG11746@pengutronix.de> <20100712155518.GA24144@pengutronix.de> <AANLkTilhI9O6YwnuAylo_jNgwR8VXmpSVJ1kylIYPCGT@mail.gmail.com> <20100712173228.GC9897@n2100.arm.linux.org.uk> <AANLkTinxUqzxClVDTyruJ6kzFTganXUGJJHJ5wRi9Iak@mail.gmail.com> <20100712185029.GB14425@pengutronix.de> <AANLkTinOuU-VVXaMwMp69CBp2Y4wxpoWybEQ34H5j0lJ@mail.gmail.com> <alpine.LFD.2.00.1007121510260.10598@xanadu.home> <AANLkTim-O00n9YPv7w4VCKjN-ETLijyTHomWUn4mZtTV@mail.gmail.com> <AANLkTilDoGbCx_0oKKPOeGG7TKL2VSNVII5ydmnQ77B7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTilDoGbCx_0oKKPOeGG7TKL2VSNVII5ydmnQ77B7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Pitre <nico@fluxnic.net>, Daniel Walker <dwalker@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-msm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, Eric Miao <eric.miao@canonical.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi

On Mon, Jul 12, 2010 at 01:50:47PM -0600, Grant Likely wrote:
> On Mon, Jul 12, 2010 at 1:34 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Mon, Jul 12, 2010 at 12:17 PM, Nicolas Pitre <nico@fluxnic.net> =
wrote:
> >> I think Uwe could provide his script and add it to the kernel tree=
=2E
> >> Then all architectures could benefit from it. =A0Having the defcon=
fig
> >> files contain only those options which are different from the defa=
ults
> >> is certainly more readable, even on x86.
> >
> > Quite possible. But maintainers would need to be on the lookout of
> > people actually using the script, and refusing to apply patches tha=
t
> > re-introduce the whole big thing.
>=20
> I can (partially) speak for powerpc.  If ARM uses this approach, then
> I think we can do the same.  After the defconfigs are trimmed, I
> certainly won't pick up any more full defconfigs.
I just restarted my script on the powerpc defconfigs basing on rc5, I
assume they complete in a few days time.
=20
> Of course, I'm also operating under the assumption that this is a
> temporary measure until one of the better solutions is implemented.
ack

>                                                                      =
I
> do suspect that the trimmed defconfigs will tend to be unstable and
> will still require manual maintenance.  I think the Kconfig fragments
> approach is the most promising if the dependencies issue can be
> solved.
I don't understand what you mean with unstable here.  They are sensible
to changed defaults in the Kconfig files which you can consider to be
good or bad.

And ack, I like the Kconfig approach, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
