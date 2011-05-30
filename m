From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH] PM: export suspend_set_ops, suspend_valid_only_mem
Date: Mon, 30 May 2011 16:00:51 +0200
Message-ID: <201105301600.51839.rjw@sisk.pl>
References: <1306542839-5688-1-git-send-email-khilman@ti.com> <201105281101.13691.rjw@sisk.pl> <BANLkTi=pQEp=_RpNyJ9o=mxjA+PMhgTKZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40689 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560Ab1E3OAO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 May 2011 10:00:14 -0400
In-Reply-To: <BANLkTi=pQEp=_RpNyJ9o=mxjA+PMhgTKZQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-pm@lists.linux-foundation.org, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Monday, May 30, 2011, Jean Pihet wrote:
> Rafael,

Hi,

> On Sat, May 28, 2011 at 11:01 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Saturday, May 28, 2011, Kevin Hilman wrote:
> >> Some platforms wish to implement their PM core suspend code as
> >> modules.  To do so, these functions need to be exported to modules.
> >
> > Hmm.  What happens if the module is not loaded and the user attempts to
> > suspend?
> In that case suspend_ops is NULL and suspending has no effect
> (pm_suspend returns -ENODEV).
> Note that this also happens after the module unload.
> 
> Is that the expected behavior?

Yes, kind of, thanks.

Take care,
Rafael
