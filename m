From: "David A. Marlin" <dmarlin@redhat.com>
Subject: unhandled fault on reboot/shutdown
Date: Sun, 22 Jan 2012 18:40:17 -0600
Message-ID: <4F1CAC71.9080109@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62212 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526Ab2AWAkS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Jan 2012 19:40:18 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q0N0eI34030817
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-omap@vger.kernel.org>; Sun, 22 Jan 2012 19:40:18 -0500
Received: from localhost.localdomain (vpn-9-167.rdu.redhat.com [10.11.9.167])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q0N0eHcV030864
	for <linux-omap@vger.kernel.org>; Sun, 22 Jan 2012 19:40:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


I experience an unhandled fault on reboot/shutdown using the ARM-OMAP kernel-2.6.41.3-1 and later (from Fedora) on a Panda Board.  I have logged a bug in:

   https://bugzilla.redhat.com/show_bug.cgi?id=781552

which provides the details, and a work around which reverts one commit 
from kernel-3.1.3.

Please let me know if you require any additional information or have 
changes for me to try.


Thank you,

d.marlin

