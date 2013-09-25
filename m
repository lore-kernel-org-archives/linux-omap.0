From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: new binutils needed for arm in 3.12-rc1
Date: Wed, 25 Sep 2013 16:52:44 +0100
Message-ID: <yw1x7ge4x5ir.fsf@unicorn.mansr.com>
References: <1380122586.1974.84@driftwood>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380122586.1974.84@driftwood> (Rob Landley's message of "Wed, 25
	Sep 2013 10:23:06 -0500")
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: Nicolas Pitre <nico@fluxnic.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Andrew Morton <akpm@osdl.org>, Trivial patch monkey <trivial@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Rob Landley <rob@landley.net> writes:

> On 09/24/2013 09:07:57 PM, Nicolas Pitre wrote:
>> I'd strongly suggest you make your binutils compatible with newer
>> instruction syntax instead of making the kernel more complex.
>
> Meaning I play whack-a-mole as this becomes permission to depend on =20
> endless new gnuisms just because they're there and nobody else is =20
> regression testing against them, not because they actually add anythi=
ng.

Since when is assembling the instructions correctly, as specified in th=
e
arch ref, and not in some other random way a gnuism?

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
