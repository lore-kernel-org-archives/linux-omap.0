From: Tony Lindgren <tony@atomide.com>
Subject: omap code merged to mainline, fixes only for -rc, no more -omap
 releases
Date: Tue, 2 Mar 2010 12:27:47 -0800
Message-ID: <20100302202747.GJ7393@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60164 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab0CBU0j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 15:26:39 -0500
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1NmYfu-0007Si-Ab
	for linux-omap@vger.kernel.org; Tue, 02 Mar 2010 20:26:38 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

Linus just pulled our code for 2.6.34, so let's now concentrate
on the fixes for for 2.6.34 -rc cycle.

So no more new code please except for the 2.6.35 merge window.

It seems like we can send about 1/3 of all the patches during
the -rc cycle as fixes, so please tweak the patches accordingly
if you want them in during the -rc cycle. For the fixes, please
specify what it fixes in the patch description. And please have
the magic word "fix" somewhere in the patch subject too.

For the patches going into 2.6.35 merge window, we need to have
those tested and integrated in linux-omap master branch by
2.6.34-rc6 or so.

I'll be rebuilding linux-omap master branch again today on top
of the current code from Linus. I will not tag 2.6.33-omap1 or
anything like that as 2.6.33 _mainline_ tree is our stable tree.

So please base any products and distros on the _mainline_ recent
stable version, currently 2.6.33, and apply the patches you need
on top of it. I guess that's mostly Kevin's PM branch and Tomi's
DSS2 branch that you might want to apply.

This way we are following the standard Linux development cycle.

Also, I'll be taking few days off starting Wednesday :)

Regards,

Tony
