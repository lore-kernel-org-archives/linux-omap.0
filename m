From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 20 May 2010 16:08:49 -0700 (PDT)
Message-ID: <758575.48890.qm@web180307.mail.gq1.yahoo.com>
References: <20100520185057.GA25089@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100520185057.GA25089@gandalf>
Sender: linux-kernel-owner@vger.kernel.org
Cc: felipe.balbi@nokia.com, Vladimir Pantelic <pan@nt.tu-darmstadt.de>, Matthew Garrett <mjg@redhat.com>, "me@felipebalbi.com" <me@felipebalbi.com>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Kernel development list <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org


> -0700, David Brownell wrote:
> > Some apps do abuse kernel mechanisms, and whether the
> bug is in the
> > app or that kernel mechanism can be a judgement
> call.=A0 I'd expect to
>=20
> hey come on, there's no judgement call for an app polling
> every second
> to check battery status or some other status that doesn't
> change that frequently.

Or something as broken as a non-terminating CPU loop ...


Of course not.  But if there's a kernel mechanism exposed to
userspace which really sucks down power ... either it's done
correctly and the problem is userspace abusing it, or it's done
wrong so that it's not possible to be used correctly.  There are
some things that just cost power, and that cost can't be escaped.
