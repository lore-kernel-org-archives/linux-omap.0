From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch updates
Date: Wed, 13 May 2009 09:54:13 -0700
Message-ID: <87bppx6j0q.fsf@deeprootsystems.com>
References: <87pred6jff.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:51348 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760568AbZEMQyP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 12:54:15 -0400
Received: by wf-out-1314.google.com with SMTP id 26so514098wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 13 May 2009 09:54:16 -0700 (PDT)
In-Reply-To: <87pred6jff.fsf@deeprootsystems.com> (Kevin Hilman's message of "Wed\, 13 May 2009 09\:45\:24 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> FYI... this small set of updates has been pushed to the pm branch[1].
> This will be the last round of updates before the rebase to 2.6.30.

Oops, shortlog was missing the two patches from Kalle.  Heres' the
right log:

Aaro Koskinen (1):
      OMAP3: PM: Save and restore I2C wakeup sources

Kalle Jokiniemi (2):
      ARM: OMAP3: Add missing iva2 clken_pll save/restore
      ARM: OMAP: Add missing SMS_SYSCONFIG save/restore

Kevin Hilman (1):
      OMAP3: PM: set MUSB OTG into force-idle at boot

Phil Carmody (2):
      OMAP3: PM: Don't do unnecessary searches in omap_sr_vdd*_autocomp_store
      OMAP3: PM: Early exit on invalid parameters

Rajendra Nayak (1):
      OMAP3: SR: Fix SR driver to check for omap-pm return values

Russ Dill (1):
      Allow OMAP3 GPIO wakeup from power off.

