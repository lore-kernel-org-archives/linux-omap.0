From: ville.syrjala@nokia.com
Subject: omapfb mem_idx patchset
Date: Thu, 18 Mar 2010 00:46:15 +0200
Message-ID: <1268865983-16270-1-git-send-email-ville.syrjala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28625 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185Ab0CQWqp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 18:46:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Imre Deak <imre.deak@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

This patchset is based on the v3 monolithic patch.

These are the changes from v3:
* split up into smaller chunks
* OMAPFB_MEM_IDX defines fixed to use the full byte
* unnecessary changes removed
* converted to use rwsems
* further modified further to make lockdep happy
* some debug WARN_ON()s added

The add locking + convert to rwsem patches could be squashed together
if you don't want the intermediate step in the tree.
