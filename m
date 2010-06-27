From: David Brownell <david-b@pacbell.net>
Subject: RE: On the APIs for Enabling and Disabling Wakeup capability.
Date: Sat, 26 Jun 2010 20:05:07 -0700 (PDT)
Message-ID: <609745.65367.qm@web180311.mail.gq1.yahoo.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026FFCAA53@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n13.bullet.mail.mud.yahoo.com ([68.142.206.40]:27351 "HELO
	n13.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754195Ab0F0DFI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 26 Jun 2010 23:05:08 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026FFCAA53@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, ParthaBasak <p-basak2@ti.com>, HemaKalliguddi <hemahk@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, RajendraNayak <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> >> I wanted to close on the introduction of two new
> OMAP device APIs
> >> omap_device_enable_wakeup () &
> omap_device_disable_wakeup() in
> >> omap_device layer.

What's the relationship between these
and the sysfs attribute which manages
the per-device wakeup enable?


Should there be driver model calls, into which
these OMAP errata-oriented calls would hook?



