From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2] PM: OPP: introduce function to free cpufreq table
Date: Sat, 11 Jun 2011 00:06:34 +0200
Message-ID: <201106110006.34976.rjw@sisk.pl>
References: <1306309406-3299-1-git-send-email-nm@ti.com> <8739k2wsdx.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47500 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753467Ab1FJWGE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jun 2011 18:06:04 -0400
In-Reply-To: <8739k2wsdx.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Todd <toddpoynor@google.com>, linux-omap <linux-omap@vger.kernel.org>

On Wednesday, May 25, 2011, Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
> > cpufreq table allocated by opp_init_cpufreq_table is better
> > freed by OPP layer itself. This allows future modifications to
> > the table handling to be transparent to the users.
> >
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Acked-by: Kevin Hilman <khilman@ti.com>

Applied to suspend-2.6/linux-next.

Thanks!
