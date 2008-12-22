From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: Nokia Internet Tablets
Date: Mon, 22 Dec 2008 14:33:41 +0200
Message-ID: <1229949221.2782.63.camel@localhost>
References: <20081222103422.GL29448@guug.org>
	 <20081222122757.GI7125@gandalf.research.nokia.com>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43252 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbYLVMei (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Dec 2008 07:34:38 -0500
In-Reply-To: <20081222122757.GI7125@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Otto Solares <solca@guug.org>, linux-omap@vger.kernel.org

On Mon, 2008-12-22 at 14:27 +0200, ext Felipe Balbi wrote:
> On Mon, Dec 22, 2008 at 04:34:22AM -0600, ext Otto Solares wrote:


> > -I don't plan to suspend but just sleep while idling, is this a good
> >  approach to power management (pm)?
> 
> That's broken afaict.

The feature might be broken, but the approach is correct.

> > -I read about the pm branch, where can I pull it?
> 
> from linux-omap git.
> 
> git pull \
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git pm
> 
> should do it

but afaik it still doesn't survive the wfi

> > -Are the CONFIG_REGULATOR and CONFIG_POWER_SUPPLY APIs of any use for
> >  the Internet Tablets?
> 
> hmm... it could be used for charging but it won't work unless you get
> documentation of the charging chips used on n8x0. Also, you'd need to
> change BME I suppose, which you can't :-s

I think there was the intention to provide BME still i nbinary form but
make it available to the community and have somebody from nokia to
recompile it when needed. Far from optimal but at least something.

-- 

Cheers, Igor

---

Igor Stoppa
Maemo Software - Nokia Devices R&D - Helsinki
