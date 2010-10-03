From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: add synchronous runtime interface for interrupt handlers
Date: Sun, 3 Oct 2010 22:33:38 +0200
Message-ID: <201010032233.39055.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1010031144420.26676-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39188 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754766Ab0JCUed (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 3 Oct 2010 16:34:33 -0400
In-Reply-To: <Pine.LNX.4.44L0.1010031144420.26676-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

On Sunday, October 03, 2010, Alan Stern wrote:
> On Sun, 3 Oct 2010, Rafael J. Wysocki wrote:
> 
> > On Saturday, October 02, 2010, Alan Stern wrote:
> > > On Fri, 1 Oct 2010, Rafael J. Wysocki wrote:
> > ...
> > > > At the moment it suspends when the network cable is removed from the device
> > > > and the hack I mentioned is used during the resume after the cable has been
> > > > reinserted (it checks if the cable is still there and schedules suspend if not).
> > > 
> > > That does seem like a strange hack.  Instead of scheduling a suspend,
> > > why not simply do a suspend as soon as you learn that the cable has
> > > been removed again?  Is there a problem about the connection status
> > > bouncing?
> > 
> > I don't remember 100%, but ISTR there was a problem with that.
> 
> Regardless, it seems like the sort of thing autosuspend would handle
> easily with no need for idle notifications.  Just call
> pm_runtime_mark_last_busy when the cable is plugged in, then do the
> runtime resume, and then call pm_request_autosuspend.  The check for 
> the cable being disconnected would have to move from the runtime_idle 
> callback to the runtime_suspend callback -- but then the runtime_idle 
> callback wouldn't have to be present at all.

It would be necessary because of the PCI bus type's implementation of it.

Anyway, I'll have a look, but I don't use the hardware any more, so testing
would be rather hard. :-)

Thanks,
Rafael
