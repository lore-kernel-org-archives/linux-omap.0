From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [patch 2.6.29-rc7-omap 5/5] mmc-twl4030 uses regulator framework
Date: Tue, 17 Mar 2009 09:12:22 +0200
Message-ID: <49BF4D56.2070704@nokia.com>
References: <200903110518.34945.david-b@pacbell.net> <200903161233.06166.david-b@pacbell.net> <49BF4554.601@nokia.com> <200903170007.18908.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31725 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbZCQHMH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 03:12:07 -0400
In-Reply-To: <200903170007.18908.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: OMAP <linux-omap@vger.kernel.org>

David Brownell wrote:
> On Monday 16 March 2009, Adrian Hunter wrote:
>> Also vsim (vmmc_aux) is not being found.
> 
> Elaborate please?  The regulator framework complains
> if it's not there, even when that's not a bug.

Sorry, I am at home but I realise now that I did record the message:

regulator: Unable to get requested regulator: vmmc_aux
