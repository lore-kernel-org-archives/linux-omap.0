From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PM-WIP-OPP][PATCH 1/4] omap3: pm: cpufreq: BUG_ON cleanup
Date: Fri, 19 Mar 2010 19:52:14 +0200
Message-ID: <20100319175213.GC3836@gandalf>
References: <1268937891-19445-1-git-send-email-nm@ti.com>
 <1268937891-19445-2-git-send-email-nm@ti.com>
 <87tysdi6tq.fsf@deeprootsystems.com>
 <4BA3886E.9070906@ti.com>
 <871vfgxkz5.fsf@deeprootsystems.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:41087 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab0CSRvs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 13:51:48 -0400
Content-Disposition: inline
In-Reply-To: <871vfgxkz5.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Nishanth Menon <nm@ti.com>, Linux-Omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>

On Fri, Mar 19, 2010 at 10:46:54AM -0700, Kevin Hilman wrote:
> IMO, Using BUG* macros usually indicates improper or incomplete error
> handling rather than a real catastrophic system failure.

on the other hand a kernel oops and system hang will always get noted. Rather
than a WARN() which simply sits in the log buffer. Remember that not all
users will be looking at console. If there's a kernel hang, we get a
core dump which is saved in the mtdoops (if you're using it) and can
send later to some central server for analysis.

-- 
balbi
