From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 00/19] Runtime PM fixes for omap-ssi
Date: Sat, 18 Jun 2016 20:54:38 +0200
Message-ID: <20160618185438.GA8866@amd>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi!

> This series fixes runtime PM for omap-ssi, so that
> the OMAP SoC can idle correctly. After applying the
> series, the SSI module correctly goes into idle if
> phonet0 interface is not configured or if it's
> used by ofono (*). Apart from me Pavel Machek did
> some testing of my devel branch [0] and reported,
> that he was able to get the phone into full idle.
> 
> Note: I did my testing with kernel flashing over USB, so
> idle is broken. But I found the bit in cm_idlest1_core,
> that stands for SSI blocking status: 0x00800000 (documented
> as "reserved" in the public TRM).
> 
> (*) "ifconfig phonet0 up" will result in blocking ssi module
>     until modem setup has finished (data communication via
> 	phonet0 device), since it enables ssi wakelines.
> 
> [0] https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/log/?h=runtime-pm-fixes

I tried applying it over v4.7-rc, but:

Applying: HSI: core: switch port event notifier from atomic to
blocking
error: drivers/hsi/hsi_core.c: does not exist in index
Patch failed at 0008 HSI: core: switch port event notifier from atomic
to blocking
The copy of the patch that failed is found in:

I tried against v4.6, but could not, either:

git checkout 2dcd0af568b0cf583645c8a317dd12e344b1c72a
Checking out files: 100% (9566/9566), done.
Note: checking out '2dcd0af568b0cf583645c8a317dd12e344b1c72a'.

You are in 'detached HEAD' state. You can look around, make
experimental
changes and commit them, and you can discard any commits you make in
this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you
may
do so (now or later) by using -b with the checkout command
again. Example:

  git checkout -b new_branch_name

HEAD is now at 2dcd0af... Linux 4.6
pavel@amd /data/l/linux-n900 (2dcd0af...) $ git am /tmp/delme.patch
Applying: HSI: omap_ssi_port: remove useless newline
error: patch failed: drivers/hsi/controllers/omap_ssi_port.c:1018
error: drivers/hsi/controllers/omap_ssi_port.c: patch does not apply
Patch failed at 0001 HSI: omap_ssi_port: remove useless newline
The copy of the patch that failed is found in:
   /data/l/linux-n900/.git/rebase-apply/patch
   When you have resolved this problem, run "git am --continue".
   If you prefer to skip this patch, run "git am --skip" instead.
   To restore the original branch and stop patching, run "git am
   --abort".
   pavel@amd /data/l/linux-n900 (2dcd0af...)|AM 1/19 $

What tree should I try it against?

Thanks,									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
