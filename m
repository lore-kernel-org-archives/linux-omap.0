From: Romit Dasgupta <romit@ti.com>
Subject: Re: omap3evm: touchscreen delays on pm branch
Date: Wed, 02 Dec 2009 10:41:45 +0530
Message-ID: <4B15F711.80206@ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE72D63F@dbde02.ent.ti.com>	 <4B0F9045.6030404@ti.com>	 <B85A65D85D7EB246BE421B3FB0FBB59301DE7B90E2@dbde02.ent.ti.com>	 <1259312859.19138.4.camel@boson>	 <B85A65D85D7EB246BE421B3FB0FBB59301DE7B9180@dbde02.ent.ti.com>	 <040b01ca6f4d$38ac95c0$LocalHost@wipultra793> <8bf247760912010206v2dc79ec0gc1f0ab369fdabd85@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB59301DE879FAD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41338 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbZLBFLp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 00:11:45 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE879FAD@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Sriram V <vshrirama@gmail.com>, "V, Hemanth" <hemanthv@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>>  Selecting performance governors solved the issue.
> 
> Nope. No cpufreq. I did notice that CPIO175 was not being set
> properly; have made local changes. It is a definite improvement;
> but there are still very noticeable delays.
> 

If PER Power domain is entering RET then module wakeups wont work! If at C2 you
are seeing this then it might explain.
