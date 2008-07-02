From: suresh@mistralsolutions.com
Subject: Suggestion required to switch to a new kernel
Date: Wed, 02 Jul 2008 14:02:37 -0500
Message-ID: <20080702140237.qt1dx5beo70g8048@webmail.mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx04.mailboxcop.com ([206.125.223.74]:44122 "EHLO
	mx04.mailboxcop.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755758AbYGBWDi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2008 18:03:38 -0400
Received: from secure3.apollohosting.com (secure3.apollohosting.com [206.125.215.253])
	by mx04.mailboxcop.com (8.13.8/8.13.8) with ESMTP id m62J2bRW017288
	for <linux-omap@vger.kernel.org>; Wed, 2 Jul 2008 14:02:38 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi All,

We are working on a product which is based on OMAP5912 (OSK). As of  
now, we are using linux-omap 2.6.16-rc3.

We had issues with the JFFS2 cleanmarkers on oneNAND. JFFS2 driver in  
2.6.16-rc3 did not understand the segmented OOB in oneNAND. Rather  
than  trying to backport the driver fixes, we have decided to upgrade  
to a new kernel which includes that fix (We noticed that it was fixed  
in  2.6.21).

We would really appreciate suggestions from people on the list about  
the kernel version that would be the best to switch to. We want to  
know which kernel version is stable on OMAP. Some of our requirements  
are;

1. DSP gateway should work on that kernel without any issues.
2. Power management should be functional. Our product uses power  
management to a great extent.

We are thinking of 2.6.24 (or 2.6.23). Please let us know your suggestions.

Thanks in advance,

Best Regards,
Suresh

