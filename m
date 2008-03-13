From: David Brownell <david-b@pacbell.net>
Subject: Re: rdhi, rdlo and rm must all be different:  say what??
Date: Thu, 13 Mar 2008 02:20:45 -0800
Message-ID: <200803130320.46227.david-b@pacbell.net>
References: <200803121758.41024.david-b@pacbell.net> <c3756a11e4164ac843d68e9be0d6112a@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:30976 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751703AbYCMKUv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Mar 2008 06:20:51 -0400
In-Reply-To: <c3756a11e4164ac843d68e9be0d6112a@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

On Thursday 13 March 2008, Felipe Balbi wrote:
> > =A0 sched_clock:
> > =A0 16: =A0 =A0 umull =A0 r0, r1, r0, r3 =A0@ tmp136, jiffies.371, =
tmp137
> >
> > =A0 sched_slice:
> > =A0 =A0 =A0 =A0 =A0 ...
> > =A0 1243: =A0 umull =A0 r0, r1, r0, r2 =A0@ slice.2262, slice,
> > <variable>.load.weight
> >
> > So this all looks suspiciously buglike. =A0Does anyone know how
> > to fix this issue? =A0Is it really a problem?
>=20
> It doesn't look like an issue:
>=20
> UMULL rdlo, rdhi, rn, rm

The ARM DDI (Rev I is handy) says different stuff than Keil:

  UMULL{<cond>}{S} <RdLo>, <RdHi>, <Rm>, <Rs>

Making the warning about rdlo vs rm:  both use r0.


> rdlo and rdhi really must be different, but they are. Maybe CodeSourc=
ery's
> toolchain is complaining about r0 appearing twice (as rdlo and rn) bu=
t
> that's not really an issue. We can multipply r0 and r3 and place the =
result
> in r0 and r1.

The DDI casts light on the issue:

  Operand restriction
    <RdHi> and <RdLo> must be distinct registers, or the results are UN=
PREDICTABLE.
    Specifying the same register for either <RdHi> and <Rm>, or <RdLo> =
and <Rm>, was
    previously described as producing UNPREDICTABLE results. There is n=
o restriction
    in ARMv6, and it is believed all relevant ARMv4 and ARMv5 implement=
ations do
    not require this restriction either, because high performance multi=
pliers read
    all their operands prior to writing back any results.

And indeed, that's what Rev E said:  "UNPREDICTABLE".  (It also did
not cover v6...)

So it looks like this warning is a definite bug:  should not issue
on v6, or with "-mcpu=3Darm926ej-s" (a "relevant" v5 implementation).

So I agree about ignoring this, but I'm still puzzled about why this
warning appeared.  Maybe the issue is that I upgraded to q3-53 from
an older toolchain, and just didn't do an H4 build since then... and
this bug didn't exist in that older toolchain.

- Dave



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
