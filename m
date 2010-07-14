From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: ARM defconfig files
Date: Wed, 14 Jul 2010 15:20:46 +0200
Message-ID: <20100714132046.GA18343@pengutronix.de>
References: <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org>
	<201007121605.32462.davidb@codeaurora.org>
	<AANLkTimho3rcoCZZ2PlC3B3KIZZhsEiTnTk-__n1q_Dy@mail.gmail.com>
	<201007121634.04427.davidb@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201007121634.04427.davidb@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-msm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, Eric Miao <eric.miao@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 12, 2010 at 04:34:04PM -0700, David Brown wrote:
> On Monday 12 July 2010 16:18:01 Linus Torvalds wrote:
> =

> > 2010/7/12 David Brown <davidb@codeaurora.org>:
> > >
> > > Do you have scripts or tools that you did this with, or is a manual
> > > process.  We're about to add several new (ARM) targets, and it'd be
> > > nice to be able to make small defconfigs for those targets as well.
> > =

> > Uwe posted it earlier in this thread as an attachement, and I put the
> > python script into the merge commit message too. And we should
> > probably put it somewhere in scripts too, and/or make a 'make' target
> > to create the small config files.
> > =

> > I pushed it all out, and tagged it as -rc5.
> =

> Got it, thanks.  I just pulled a bit soon.
> =

> It seems a bit brute force, probably not something I can make part of
> our regular build process, but I can definitely run it before sending
> patches out.
> =

> I wonder if there's a more efficient way of doing it that doesn't
> involve invoking make for each line of the file.  It at least
> shouldn't be necessary to actually build the kernel each time.
Note that no kernel is built at all, only the config is regenerated once
for each line.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
