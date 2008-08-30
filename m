From: Felipe Balbi <me@felipebalbi.com>
Subject: omapzoom isn't working again
Date: Sat, 30 Aug 2008 14:40:49 +0300
Message-ID: <20080830114046.GD14130@frodo>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:54651 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbYH3LlF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Aug 2008 07:41:05 -0400
Received: from a91-154-115-238.elisa-laajakaista.fi ([91.154.115.238]:29404 helo=@)
	by serv01.siteground211.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <me@felipebalbi.com>)
	id 1KZOpB-0007XS-5j
	for linux-omap@vger.kernel.org; Sat, 30 Aug 2008 06:41:02 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Tried cloning right and it's not working again.

someone has to run git update-server-info.
chmod +x .git/hooks/post-update would be cooler though.

-- 
balbi
