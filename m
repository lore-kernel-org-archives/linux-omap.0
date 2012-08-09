From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 1/2] cpufreq: OMAP: Handle missing frequency table on SMP systems
Date: Thu, 9 Aug 2012 21:32:24 +0200
Message-ID: <201208092132.25141.rjw@sisk.pl>
References: <1344496102-24451-1-git-send-email-rnayak@ti.com> <201208091132.14992.rjw@sisk.pl> <87d330glel.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:51390 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759223Ab2HIT0b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Aug 2012 15:26:31 -0400
In-Reply-To: <87d330glel.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-pm@vger.kernel.org

On Thursday, August 09, 2012, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Thursday, August 09, 2012, Rajendra Nayak wrote:
> >> On OMAP4, if the first CPU fails to get a valid frequency table (this
> >> could happen if the platform does not register any OPP table), the
> >> subsequent CPU instances end up dealing with a NULL freq_table and
> >> crash.
> >> 
> >> Check for an already existing freq_table, before trying to create one,
> >> and increment the freq_table_users only if the table is sucessfully
> >> created.
> >> 
> >> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> >> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> Cc: <linux-pm@vger.kernel.org>
> >
> > Kevin, are you going to merge this?
> >
> 
> Yes, I plan to queue this with 2/2 for v3.6-rc.

If you have any cpufreq patches for v3.7, can you please tell me where to
pull them from (and when)?

Rafael
