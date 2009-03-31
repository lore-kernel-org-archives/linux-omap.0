From: Ameya Palande <ameya.palande@nokia.com>
Subject: find_task_by_vpid() not protected
Date: Tue, 31 Mar 2009 17:51:42 +0300
Message-ID: <49D22DFE.7070105@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:35727 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbZCaOvz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2009 10:51:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Hari,

I found out that bridge_open() function is calling find_task_by_vpid()
without taking rcu_read_lock() or with tasklist_lock read-held.

Should we introduce proper read locking with following functions?
read_lock(&tasklist_lock);
read_unlock(&tasklist_lock);

Cheers,
Ameya.
