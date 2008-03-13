From: David Brownell <david-b@pacbell.net>
Subject: rdhi, rdlo and rm must all be different:  say what??
Date: Wed, 12 Mar 2008 16:58:40 -0800
Message-ID: <200803121758.41024.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:48524 "HELO
	smtp108.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750924AbYCMA64 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Mar 2008 20:58:56 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I did a build for H4, using the CodeSourcery 2007q3-53 toolchain, and:

    CC      kernel/sched.o
  /tmp/ccePvKYj.s: Assembler messages:
  /tmp/ccePvKYj.s:16: rdhi, rdlo and rm must all be different
  /tmp/ccePvKYj.s:1243: rdhi, rdlo and rm must all be different

The problem doesn't crop up with a build for OSK; different CPUs,
presumably.  It turns out these are both umull instructions; if
I "make kernel/sched.s" and build the result, the relevant lines
have different numbers but match up as:

  sched_clock:
  16:     umull   r0, r1, r0, r3  @ tmp136, jiffies.371, tmp137

  sched_slice:
          ...
  1243:   umull   r0, r1, r0, r2  @ slice.2262, slice, <variable>.load.weight

So this all looks suspiciously buglike.  Does anyone know how
to fix this issue?  Is it really a problem?

- Dave

