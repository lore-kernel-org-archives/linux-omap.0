From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH] ARM: Thumb-2: Make CONFIG_THUMB2_KERNEL depend on !CPU_V6
Date: Wed, 08 Dec 2010 17:50:04 +0000
Message-ID: <yw1xipz4xigj.fsf@unicorn.mansr.com>
References: <AANLkTin8r4-ooAUsf-T5SnM_QDHdY_c3XfRL4o=nZkHC@mail.gmail.com> <603978.51278.qm@web180303.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:35727 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755257Ab0LHRuW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Dec 2010 12:50:22 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1PQO9l-0005zc-GO
	for linux-omap@vger.kernel.org; Wed, 08 Dec 2010 18:50:21 +0100
Received: from unicorn.mansr.com ([78.86.181.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 18:50:21 +0100
Received: from mans by unicorn.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 18:50:21 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

David Brownell <david-b@pacbell.net> writes:

> So to recapitulate ... you're agreeing with me on my key point --
> that ARM1156, a V6T2 core with Thumb2 support (used in fact to
> introduce Thumb2), should work for some in-kernel Thumb2 usage,
> degree TBD, but obviously the v7 cores are more capable (with SIMD
> support in T2, etc).

The ARM1156 implements the full Thumb2 instruction set, exactly the
same as in v7 except for ThumbEE and features new to v7 in general.

> But the updated reason you gave for not allowing V6T2 is that it's
> an uncommon architecture (one core, not widely manufactured today)
> ... not impossibility.

The architecture being uncommon is not in my opinion cause to make
life harder than necessary for whomever might some day want to add
support for it.

Does the patch solve any real problem today?

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
