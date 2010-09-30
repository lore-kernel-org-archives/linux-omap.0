From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions:
 watchdog, UART, i2c
Date: Thu, 30 Sep 2010 08:46:28 -0700
Message-ID: <20100930154628.GI3117@atomide.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
 <20100928201844.GI3117@atomide.com>
 <87tyl8rxwp.fsf@deeprootsystems.com>
 <20100930021819.GD3117@atomide.com>
 <877hi3i9cp.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53052 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab0I3Pqb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 11:46:31 -0400
Content-Disposition: inline
In-Reply-To: <877hi3i9cp.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Charulatha Varadarajan <charu@ti.com>, Rajendra Nayak <rnayak@ti.com>, "Govindraj R." <govindraj.raja@ti.com>

* Kevin Hilman <khilman@deeprootsystems.com> [100930 07:31]:
> 
> What config are you using to get a small enough kernel to boot on your
> n810?  nolo on my n810 only accepts a maximum size kernel of 2097152
> bytes. :(

I guess the options there are to leave out tons of boards and some other
omaps, or to use kexec to get around that limit.

Regards,

Tony
