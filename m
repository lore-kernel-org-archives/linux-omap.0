From: NS <nags75@yahoo.com>
Subject: Problems with workqueue
Date: Thu, 25 Mar 2010 11:24:00 +0000 (UTC)
Message-ID: <loom.20100325T122311-43@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:35271 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753858Ab0CZKzG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Mar 2010 06:55:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1Nv7Bw-0005TV-40
	for linux-omap@vger.kernel.org; Fri, 26 Mar 2010 11:55:04 +0100
Received: from 59.97.0.73 ([59.97.0.73])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 26 Mar 2010 11:55:04 +0100
Received: from nags75 by 59.97.0.73 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Fri, 26 Mar 2010 11:55:04 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi All,

I am facing a problem with Work Queues and need some help debugging. We are
using 2.6.22 Kernel. I know that it is old kernel version, but this kernel
version was chosen for the product almost a year back and we are not in a
position to change the kernel version due to time constraints.

Problem description
We use work queues for the second half of the ISR with a touch screen driver.
Most of the times, everything works fine. However, occasionally, the work does
not seem to get a chance to execute.

Questions:
a) What is the best way to monitor the work execution on the work queues?
b) Is it possible that the Kernel flushes the work from the work queue sometimes
and makes the work unavailable?
c) How to make sure that the work is available on the work queue and how to
check this?

Any suggestions on this will be really helpful.

with regards,
NS. 

