From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [OMAP and mainline][RFC 2.6.28-rc2-omap 3/3] USB: OHCI-OMAP:
 Switch to gpio_request/free calls
Date: Tue, 11 Nov 2008 15:17:37 +0200
Message-ID: <20081111151737.3dc034d5.jarkko.nikula@nokia.com>
References: <1225455447-12179-1-git-send-email-jarkko.nikula@nokia.com>
	<200810311056.55697.david-b@pacbell.net>
	<20081103133750.1d4e66e8.jarkko.nikula@nokia.com>
	<200811101423.50989.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29215 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755398AbYKKNSI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 08:18:08 -0500
In-Reply-To: <200811101423.50989.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Mon, 10 Nov 2008 14:23:50 -0800
"ext David Brownell" <david-b@pacbell.net> wrote:

> On Monday 03 November 2008, Jarkko Nikula wrote:
> > Yes, I actually noted already before making the first set, that
> > probably I should sent a patch to wide the label column in debugs
> > listings :-)
> 
> Sure, you send me a drivers/gpio/gpiolib.c update and I'll
> sign off on it.  20 chars would be better than 12, but
> maybe more are needed.
> 
I'll try do as soon as possible. Some "work" and other side stuff has
unfortunately delayed this gpio & patchset update recently.

Do you see are there any issue to change label into last column like
in /proc/interrupts so that width doesn't have to be fixed?


Jarkko
