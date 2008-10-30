From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [RFC 0/21 Continue phasing out legacy GPIO calls
Date: Thu, 30 Oct 2008 15:11:27 +0200
Message-ID: <20081030151127.e0b8b430.jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
	<20081029160056.GD20456@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21064 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872AbYJ3NM3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 09:12:29 -0400
In-Reply-To: <20081029160056.GD20456@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Wed, 29 Oct 2008 09:00:56 -0700
"ext Tony Lindgren" <tony@atomide.com> wrote:

> Great. One request though:
> 
> Let's do the clean-up patches in two phases, one series that
> applies against the mainline kernel, then additional patches for
> linux-omap. Otherwise we'll never get out of this merge hell.
> 
> BTW, we should try to do the same for anything that we can already
> patch in the mainline kernel.
> 
Is it most easiest to you if I leave the set aside for a while and base
only first patch against mainline or David's recent set?

Probably first conversion set is then for those board files which are
in mainline and second set to non-mainline merged board files. Drivers
probably can be converted gradually as they are going via their mailing
lists?

At least with my first patch it's easy to detect from debugfs what is
needed to convert :-)

+static inline int omap_request_gpio(int gpio)
+{
+	return gpio_request(gpio, "FIXME");
+}


Jarkko
