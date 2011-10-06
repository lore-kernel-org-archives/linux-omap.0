From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: Regressions for older OMAP3503 silicon
Date: Thu, 6 Oct 2011 07:23:26 -0700
Message-ID: <CAGDS+n=Cecv+anpDvmfuKivH9zUzDReSU2Qj7S7ZWyeRakBQjw@mail.gmail.com>
References: <CABi1daE-7OdgL5BqaLrB+X64-cf+kQMyXv9eSZOE79bRt+fMPw@mail.gmail.com>
	<alpine.DEB.2.00.1110051206090.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42712 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab1JFOX1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 10:23:27 -0400
Received: by vws1 with SMTP id 1so2236956vws.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Oct 2011 07:23:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1110051206090.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Dave Hylands <dhylands@gmail.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>

On Wed, Oct 5, 2011 at 11:09 AM, Paul Walmsley <paul@pwsan.com> wrote:

> Looking at the 2.6.39 kernel sources, those messages are coming from
> mach-omap2/pm34xx.c:omap3_enable_io_chain(). =A0That means that somet=
hing is
> seriously wrong since that code should only be executing on ES3.1 chi=
ps
> and higher.
>
> Could you put something similar to a
>
> pr_err("** omap_rev is %08x\n", omap_rev());
>
> in your pm34xx.c right above the #if 0 that you added and let us know=
 what
> it says?

I think that what is seriously wrong is the way that the revision test =
is done:

	if (omap_rev() >=3D OMAP3430_REV_ES3_1) {

=46or 3505 ES2.1 omap_rev() returns 35030234 and it is being compared t=
o 34300434.

This sort of revision check really should be looking at cpu type and
revision.  I suspect there are a number of other similar tests in the
kernel that have this issue.

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
