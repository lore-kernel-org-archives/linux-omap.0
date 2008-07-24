From: suresh@mistralsolutions.com
Subject: JFFS2 GC Bug?
Date: Wed, 23 Jul 2008 20:36:27 -0500
Message-ID: <20080723203627.s3d1nsowo4ysgskc@webmail.mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx03.mailboxcop.com ([206.125.223.73]:59071 "EHLO
	mx03.mailboxcop.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbYGXBg2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jul 2008 21:36:28 -0400
Received: from secure3.apollohosting.com (secure3.apollohosting.com [206.125.215.253])
	by mx03.mailboxcop.com (8.13.8/8.13.8) with ESMTP id m6O1aRuB001965
	for <linux-omap@vger.kernel.org>; Wed, 23 Jul 2008 20:36:27 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

Can files go missing if there is a powerfail when the garbage  
collection is running (and doing updation to the file system) on a  
JFFS2 filesystem.

Was this a bug in older kernels? I am seeing this on OMAP5912 using  
2.6.13-rc3.

Thanks in advance,
Suresh


