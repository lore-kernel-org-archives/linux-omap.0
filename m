From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v2 0/5] Split powerdomain framework into plat
 specific/independent
Date: Fri, 3 Dec 2010 01:40:49 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012030139020.17078@utopia.booyaka.com>
References: <1291131848-31640-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1012011254460.2515@utopia.booyaka.com> <699e6818fd0b2162302926a3c724749f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36081 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab0LCIku (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 03:40:50 -0500
In-Reply-To: <699e6818fd0b2162302926a3c724749f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>

Hi Rajendra,

On Thu, 2 Dec 2010, Rajendra Nayak wrote:

> This seems to be popping up with powerdomains.h file (which now
> has func declarations) being included in multiple source files. It earlier
> had only static structs and was included in one source file.
> 
> I thought the right way to fix this was to probably move the static
> structs from the header into a source file.
> See if the below patch makes sense. Also attached as I don't trust
> my mailer.

Yes, that general approach looks fine to me.  I've got some patches here 
that will be posted once this powerdomain series is done to convert all 
the remaining static allocations in .h files into .c files.


- Paul
