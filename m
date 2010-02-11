From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Moving board patches from DSS2 to linux-omap
Date: Thu, 11 Feb 2010 14:04:48 +0200
Message-ID: <1265889888.2433.245.camel@tubuntu.research.nokia.com>
References: <1265884185.2433.239.camel@tubuntu.research.nokia.com>
	 <4B73EF0D.8080904@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53901 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab0BKMCM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 07:02:12 -0500
In-Reply-To: <4B73EF0D.8080904@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mike Rapoport <mike@compulab.co.il>
Cc: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2010-02-11 at 12:50 +0100, ext Mike Rapoport wrote:
> Tomi Valkeinen wrote:
> > Hi,
> > 
> > As discussed previously, board file changes in DSS2 tree cause conflicts
> > with linux-omap easily. There are currently three board file patches in
> > DSS2's for-next branch:
> > 
> > 722a97e4594b2041bbf18d95a913ba6dfaca87f2 omap3: cm-t35: add DSS2 display support
> > 7a56267e775e469c64521179ccc958c8bb661dbf OMAP: AM3517: Enable DSS2 for AM3517EVM board
> > 40e4e67c6dabcb9897b6823cce2297d6c3e78bbd OMAP: Enable DSS2 for OMAP3EVM board
> > 
> > The problem here is of course that DSS2 tree may contain unmerged panel
> > drivers, and those board file changes try to use these new panel
> > drivers.
> 
> Well, the panel drivers are referenced by name in the board files, so merging board
> file changes through linux-omap tree should not create merge conflicts and compile
> problems. There just won't be display until DSS2 tree is merged. Or am I missing
> something?

Yes, that is correct. This makes adding new boards and panels a bit more
complicated, but should remove most conflicts that happen between
linux-omap and dss2 trees.

 Tomi


