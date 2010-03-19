From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-WIP-OPP][PATCH 1/4] omap3: pm: cpufreq: BUG_ON cleanup
Date: Fri, 19 Mar 2010 11:42:16 -0700
Message-ID: <87iq8sw3uf.fsf@deeprootsystems.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com>
	<1268937891-19445-2-git-send-email-nm@ti.com>
	<87tysdi6tq.fsf@deeprootsystems.com> <4BA3886E.9070906@ti.com>
	<871vfgxkz5.fsf@deeprootsystems.com> <20100319175213.GC3836@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f194.google.com ([209.85.222.194]:50112 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab0CSSmT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 14:42:19 -0400
Received: by pzk32 with SMTP id 32so2396429pzk.4
        for <linux-omap@vger.kernel.org>; Fri, 19 Mar 2010 11:42:19 -0700 (PDT)
In-Reply-To: <20100319175213.GC3836@gandalf> (Felipe Balbi's message of "Fri\, 19 Mar 2010 19\:52\:14 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Nishanth Menon <nm@ti.com>, Linux-Omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>

Felipe Balbi <me@felipebalbi.com> writes:

> On Fri, Mar 19, 2010 at 10:46:54AM -0700, Kevin Hilman wrote:
>> IMO, Using BUG* macros usually indicates improper or incomplete error
>> handling rather than a real catastrophic system failure.
>
> on the other hand a kernel oops and system hang will always get
> noted. Rather than a WARN() which simply sits in the log buffer.

Of course, but what I'm trying to avoid is making other people deal
with a BUG inserted by a developer when proper error checking and
recovery is what is really needed.

Kevin
