From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: calling runtime PM from system PM methods
Date: Mon, 6 Jun 2011 20:01:50 +0200
Message-ID: <201106062001.50969.rjw@sisk.pl>
References: <87k4d55c8k.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60296 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756958Ab1FFSBA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Jun 2011 14:01:00 -0400
In-Reply-To: <87k4d55c8k.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>

On Thursday, June 02, 2011, Kevin Hilman wrote:
> Hi Rafael,

Hi,

> Once again, I'm back to some problems with using runtime PM from system
> PM methods.  On OMAP, many drivers don't need to do anything different
> for runtime PM compared to system PM, so the system PM methods can
> simply use runtime PM.

No, they can't (I was talking about that at LinuxCon Japan last week).

I'll give more details in replies to the other messages in this thread.

Thanks,
Rafael
