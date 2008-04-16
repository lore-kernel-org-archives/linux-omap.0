From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.25-rc8] omap_rng minor updates
Date: Wed, 16 Apr 2008 10:04:49 -0700
Message-ID: <200804161004.50075.david-b@pacbell.net>
References: <200804102132.03907.david-b@pacbell.net> <20080416112517.GA29220@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932258AbYDPRFG@vger.kernel.org>
In-Reply-To: <20080416112517.GA29220@gondor.apana.org.au>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 16 April 2008, Herbert Xu wrote:
> > Minor cleanups to the OMAP RNG:
>=20
> Thanks. =A0I've picked this up in cryptodev-2.6.

Is that where the RNG stuff is now getting maintained?


If so, I wonder what should be done with some other
RNG changes sitting in one of my trees.  Briefly,
their initializations come late ... and after kernel
code has already started to use the kernel pool.  So
attacks based on known RNG patterns are possible at
that time.

So the patch I had -- needs reworking -- moves the
RNG driver initializations earlier, and uses the
first one to seed the kernel pool.  Cryptographically
that would be no worse than the current situation (even
if you don't wholly trust the RNG), and in most cases
would be a distinct improvement.

- Dave
