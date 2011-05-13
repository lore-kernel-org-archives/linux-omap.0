From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH v3] Consolidate SRAM support
Date: Fri, 13 May 2011 10:11:23 +0100
Message-ID: <20110513091123.GA20941@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk> <20110512174546.GB8633@n2100.arm.linux.org.uk> <BANLkTimmCuxUUY46B+aY5C0KxnY4_Dvucg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40616 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478Ab1EMJLo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 May 2011 05:11:44 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimmCuxUUY46B+aY5C0KxnY4_Dvucg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, May 13, 2011 at 09:30:14AM +0200, Jean Pihet wrote:
> On Thu, May 12, 2011 at 7:45 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >    This version fixes the davinci pm free, and adds updates for the
> >    davinci pcm driver.  As I don't know what's happening with Jean's
> >    patch tweaking the genpool allocator, I've kept my version.
> 
> Sorry I do not get the question. The latest changes I submitted have
> been merged in mainline as 'ARM: 6649/1: omap: use fncpy to copy the
> PM code functions to SRAM' [1] . Thanks for that!
> This change is only about the simple linear SRAM allocator, not the
> genpool allocator.

The wrong Jean!  I meant Jean-Christophe PLAGNIOL-VILLARD.
