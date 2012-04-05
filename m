From: Paul Walmsley <paul@pwsan.com>
Subject: RE: OMAP3EVM not booting on l-o master
Date: Thu, 5 Apr 2012 13:52:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204051303000.10302@utopia.booyaka.com>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com> <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com> <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com> <alpine.DEB.2.00.1204050403460.10302@utopia.booyaka.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317C4B44@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48063 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab2DETwV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 15:52:21 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A9317C4B44@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 5 Apr 2012, Mohammed, Afzal wrote:

> On Thu, Apr 05, 2012 at 15:37:42, Paul Walmsley wrote:
> > I just booted the 'io_chain_devel_3.5' branch from 
> > git://git.pwsan.com/linux-2.6 on a 35xx ES3.0 BeagleBoard with no 
> > problems.  Could you please try booting this branch on your OMAP3EVM?
> 
> I am unable to fetch using git protocol, hence tried,
> 
> http://git.pwsan.com/linux-2.6 & http://git.pwsan.com/linux-2.6.git
> 
> but giving error,
> 
> fatal: http://git.pwsan.com/linux-2.6/info/refs not found: did you run git update-server-info on the server?

The git trees on that server aren't exported by the HTTP server, so git 
protocol is the only access method on git.pwsan.com right now.

Anyway, I've just posted that branch on git.kernel.org.  Here's the gitweb 
URL:

http://git.kernel.org/?p=linux/kernel/git/pjw/omap-devel.git;a=summary

If you open it in your web browser, it shows http and https URLs for the 
tree that you should be able to pull from.  You'll want the 
"io_chain_devel_3.5" branch.


- Paul
