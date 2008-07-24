From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 0/3] Implement powerdomain off on state counters
Date: Thu, 24 Jul 2008 16:04:25 +0300
Message-ID: <20080724130425.GA4601@codecarver.research.nokia.com>
References: <1216904434-7545-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:64556 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbYGXNE4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jul 2008 09:04:56 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m6OD4bRl017874
	for <linux-omap@vger.kernel.org>; Thu, 24 Jul 2008 16:04:54 +0300
Received: from codecarver.research.nokia.com (esdhcp04096.research.nokia.com [172.21.40.96])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m6OD4PL8001836
	for <linux-omap@vger.kernel.org>; Thu, 24 Jul 2008 16:04:26 +0300
Received: from p2 by codecarver.research.nokia.com with local (Exim 4.69)
	(envelope-from <p2@codecarver.research.nokia.com>)
	id 1KM0Ub-0001zA-L4
	for linux-omap@vger.kernel.org; Thu, 24 Jul 2008 16:04:25 +0300
Content-Disposition: inline
In-Reply-To: <1216904434-7545-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Thu, Jul 24, 2008 at 04:00:31PM +0300, Peter 'p2' De Schrijver wrote:
> This patchset implement counters to count the number of off to on state transitions in a powerdomain. These counters will be made available to
> drivers in a later patchset to allow them to make a better informed decision wether to restore the hardware registers or not.

Thanks to Tero Kristo for providing the basis of this patch in the form
of the PM Debug counters.

-- 
goa is a state of mind
