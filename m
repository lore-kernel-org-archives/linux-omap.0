From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH v2] power: introduce library for device-specific OPPs
Date: Fri, 17 Sep 2010 22:38:49 -0700
Message-ID: <20100918053849.GA19709@suse.de>
References: <1284787459-25643-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57456 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986Ab0IRFiE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 18 Sep 2010 01:38:04 -0400
Content-Disposition: inline
In-Reply-To: <1284787459-25643-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@xenotime.net>, Lnus Walleij <linus.walleij@stericsson.com>, Phil <ext-phil.2.carmody@nokia.com>, Kevin <khilman@deeprootsystems.com>

On Sat, Sep 18, 2010 at 12:24:19AM -0500, Nishanth Menon wrote:
> This is hence introduced under lib allowing all architectures to
> selectively enable the feature based on their capabilities.

<snip>

>  Documentation/power/00-INDEX |    2 +
>  Documentation/power/opp.txt  |  326 ++++++++++++++++++++++++++
>  drivers/base/power/Makefile  |    1 +
>  drivers/base/power/opp.c     |  527 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/opp.h          |  126 ++++++++++
>  kernel/power/Kconfig         |   14 ++
>  6 files changed, 996 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/power/opp.txt
>  create mode 100644 drivers/base/power/opp.c
>  create mode 100644 include/linux/opp.h

That doesn't look like the files are under lib/

Did you forget to move them, or do you need to update the changelog
message?

thanks,

greg k-h
