From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Fri, 15 Apr 2011 16:41:13 +0100
Message-ID: <20110415154113.GE4423@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk> <4DA84AAB.60601@gmail.com> <201104151640.01040.arnd@arndb.de> <20110415152643.GC4423@n2100.arm.linux.org.uk> <BANLkTinDwH9G1zW784t=QnNR7kZkgfKA8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53460 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545Ab1DOPlb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Apr 2011 11:41:31 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinDwH9G1zW784t=QnNR7kZkgfKA8w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@ti.com>, davinci-linux-open-source@linux.davincidsp.com, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Apr 15, 2011 at 09:32:01AM -0600, Grant Likely wrote:
> Yes, once the infrastructure is in place, powerpc can do its own
> migration to the new code.  I vote for putting it in lib at the
> outset.

I don't agree with stuffing non-arch directories with code which people
haven't already agreed should be shared.  As I've already said, in my
experience it's hard to get agreement in the first place and even when
you can the API generally needs to be changed from what you first think
would be reasonable.

So, lets wait to see whether the SH folk reply.
