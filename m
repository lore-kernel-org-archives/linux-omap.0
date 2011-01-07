From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/1] arm: omap: gpio: define .disable callback for gpio irq chip
Date: Fri, 7 Jan 2011 01:00:44 -0800 (PST)
Message-ID: <522801.72719.qm@web180309.mail.gq1.yahoo.com>
References: <20110105202939.GC8717@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm3-vm0.bullet.mail.sp2.yahoo.com ([98.139.90.230]:21309 "HELO
	nm3-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753025Ab1AGJAq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 04:00:46 -0500
In-Reply-To: <20110105202939.GC8717@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org


> o lazy-disable state

This is an odd state, and confusion regularly
comes up ... I've never been a fan of having the
imperatively named disable_irq() act like a

disable_irq_at a_random_later_time_ _but_nyet().  If
one must have the latter function, clearer IMO
to name it better and have disable_irq()
do exactly that by the time it returns ... that
is after all what folk expect given its name and conventional interpretation of "disable".
 (ergo confusion when that's not what happens)

lazy_disable_irq() would be accurate, butI'm not
sure many folk would choose to use it.

- Dave

