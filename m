From: Felipe Balbi <me@felipebalbi.com>
Subject: [ANNOUNCE] musb procfs
Date: Thu, 4 Sep 2008 03:00:01 +0300
Message-ID: <20080903235958.GF6693@frodo>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:33050 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbYIDAAQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 20:00:16 -0400
Received: from a91-154-115-238.elisa-laajakaista.fi ([91.154.115.238]:12595 helo=@)
	by serv01.siteground211.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <me@felipebalbi.com>)
	id 1Kb2Gh-0002En-G9
	for linux-omap@vger.kernel.org; Wed, 03 Sep 2008 19:00:13 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi all,

This mail is just to let you know musb procfs file has been removed from
musb for several reasons being "drivers shouldn't add procfs files" the
most outstanding one.

For those used to change musb debugging level via "echo D3 >
/proc/drivers/musb_hdrc" the same approach can be done by changing the
debug module parameter or in runtime by writing to
/sys/modules/musb_hdrc/parameters/debug

All the other functionalities (testmodes, mostly) will be developed
under debugfs or userspace accordingly but don't expect it to come
too soon due to tight schedule at work on other tasks.

If anyone wanna help on such tasks I can tell you what should be done.

Thanks.

-- 
balbi
