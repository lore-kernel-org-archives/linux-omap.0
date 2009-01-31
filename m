From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH D 01/11] OMAP: Add clk_get_parent() for OMAP2/3
Date: Sat, 31 Jan 2009 15:07:06 +0000
Message-ID: <yw1xhc3f5xb9.fsf@thrashbarg.mansr.com>
References: <20090128191638.16688.33452.stgit@localhost.localdomain>
	<20090128191807.16688.91255.stgit@localhost.localdomain>
	<20090129110043.GE12627@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.0901292327090.26985@utopia.booyaka.com>
	<20090131142344.GM1394@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754710AbZAaPH2@vger.kernel.org>
In-Reply-To: <20090131142344.GM1394@n2100.arm.linux.org.uk> (Russell King's message of "Sat, 31 Jan 2009 14:23:44 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Thu, Jan 29, 2009 at 11:29:31PM -0700, Paul Walmsley wrote:
>> On Thu, 29 Jan 2009, Russell King - ARM Linux wrote:
>>=20
>> > On Wed, Jan 28, 2009 at 12:18:16PM -0700, Paul Walmsley wrote:
>> > > From: Mans Rullgard <mans@mansr.com>
>> > >=20
>> > > This makes clk_get_parent() work on OMAP2/3.
>> >=20
>> > This is clearly something that the generic code should be doing.
>> > It's not something specific to OMAP2/3.  Please move it to
>> > arch/arm/plat-omap/clock.c
>>=20
>> Done; revised patch below.
>
> Great, thanks.  However, I'd forgotten that one of my patches complet=
ely
> removes clk_get_parent() since it's unused by any code in OMAP at pre=
sent.
>
> What was the reasoning behind making this work?

It is needed for the omapfb/dss driver to set an optimal rate for
dpll4_m4_ck.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
