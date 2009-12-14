From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Padconf not working on pm_defconfig?
Date: Tue, 15 Dec 2009 01:16:02 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309C86411@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4EFC@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E739404372AAB54@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4F0F@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4F23@dbde02.ent.ti.com>
 <87fx7dcx8k.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0309C86409@dbde02.ent.ti.com>,<20091214192630.GA4575@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54136 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757499AbZLNTtU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 14:49:20 -0500
In-Reply-To: <20091214192630.GA4575@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Peter De Schrijver <peter.de-schrijver@nokia.com>

Tony Lindgren wrote:
> 
> Sounds like debobs should only set the pins based on platform_data
> passed from the board-*.c file. Then maybe allow override from
> cmdline on boards that have both debobs and ehci?
> 

Not sure about this - I haven't studied the driver yet
(it's been on my TODO for a while. Interesting area :) )

The debobs driver allows these mux-modes to be set from sysfs,
I think. If so, all we need to do is save the old mode
and restore it back from sysfs.

Also, by default not change any of the mux modes.

Another thing I'd like to add is the option to use the alternate
set of hwdebug pads.

- Anand