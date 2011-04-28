From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] [RFC PATCH] PM: Introduce generic DVFS framework
	with device-specific OPPs
Date: Thu, 28 Apr 2011 13:19:15 +0100
Message-ID: <20110428121909.GB26116@sirena.org.uk>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com> <201104261309.47629.rjw@sisk.pl> <BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com> <BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com> <BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com> <BANLkTi=WWASxk3Fz83324k40Lbq+ccAPeA@mail.gmail.com> <BANLkTikEtTDp3Cpj0D5z34wA0_G_DWwKFg@mail.gmail.com> <alpine.LFD.2.02.1104272104390.3323@ionos> <BANLkTinWD0ktYKzR_jnQSE76AuW+Z1PSLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:52405 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875Ab1D1MTd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 08:19:33 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinWD0ktYKzR_jnQSE76AuW+Z1PSLw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Menon, Nishanth" <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@lists.linux-foundation.org, linux-omap <linux-omap@vger.kernel.org>

On Wed, Apr 27, 2011 at 01:48:52PM -0700, Colin Cross wrote:

> OPP currently has opp_enable and opp_disable functions.  I don't
> understand why these are needed, they are only used at init time to
> determine available voltages, which could be handled by never passing
> unavailable voltages to the dvfs implementation.

I queried this when OPP was originally added.  The motivation which was
given (which seemed fairly reasonable) was to reduce the number of data
tables for similar parts and board designs.  That did seem like
something which it was reasonable to factor out in some way, though
possibly with a different mechanism.
