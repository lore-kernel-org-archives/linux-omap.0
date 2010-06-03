From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 3 Jun 2010 06:44:31 -0700 (PDT)
Message-ID: <806772.17066.qm@web180305.mail.gq1.yahoo.com>
References: <20100601073548.5ed65352@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n2-vm0.bullet.mail.gq1.yahoo.com ([67.195.23.154]:30535 "HELO
	n2-vm0.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752955Ab0FCNoc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 09:44:32 -0400
In-Reply-To: <20100601073548.5ed65352@schatten.dmk.lab>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Florian Mickler <florian@mickler.org>
Cc: Neil Brown <neilb@suse.de>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Alan@smtp1.linux-foundation.org, Peter Zijlstra <peterz@infradead.org>, Felipe Balbi <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>


> > > If "suspend" is the thing we are used to via
> /sys/power/state then the
> > > race will persist forever except for the suspend blocker workaround,

True, because device wakeups are enabled
by device.driver.suspend() methods, which are
invoked towards the end of the activities
triggered by writing /sys/power/state.

Now, there can be platforms (mostly embedded)
where the drivers adopt a policy that not only
do they keep their devices in as low a power
state as practical at all times, but they also
keep the hardware wakeup mechanisms enabled (they
may be needed to kick the hardware out of those
low power states) ...  That is, suspend() might be
superfluous (a NOP) in those platforms' drivers.

Such platforms might also be (non-ACPI) ones
where idle C-states and S3/STR have the same
power consumption ... but that would be a
platform-specific issue, not a generic thing
which all Linux implementations could rely on.

- Dave


