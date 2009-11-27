From: Romit Dasgupta <romit@ti.com>
Subject: Re: omap3evm: touchscreen delays on pm branch
Date: Fri, 27 Nov 2009 15:54:55 +0530
Message-ID: <4B0FA8F7.30300@ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE72D63F@dbde02.ent.ti.com>	 <4B0F9045.6030404@ti.com>	 <B85A65D85D7EB246BE421B3FB0FBB59301DE7B90E2@dbde02.ent.ti.com> <1259312859.19138.4.camel@boson> <B85A65D85D7EB246BE421B3FB0FBB59301DE7B9180@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57851 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282AbZK0KYy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Nov 2009 05:24:54 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nARAOwjL008062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2009 04:25:00 -0600
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE7B9180@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> 
> It is the same driver at SDP3430. I had earlier tried removing
> cpuidle altogether and did not see this issue. I too believe that
> issue is caused by clocks being going to (auto)idle.
> 
> But then, Hemanth should be seeing the same behavior.
Do you see PER powerdomain entering retention?
