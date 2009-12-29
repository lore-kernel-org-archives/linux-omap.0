From: Romit Dasgupta <romit@ti.com>
Subject: Re: SR2: VDD autocomp is not active
Date: Tue, 29 Dec 2009 18:00:39 +0530
Message-ID: <4B39F66F.8080709@ti.com>
References: <82cfbe860912270047j6332384drff2c82ecf8eccd24@mail.gmail.com>	 <4B3862E3.1090705@ti.com> <82cfbe860912290428v573ec0c5k5506ad3dad6c0c35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57652 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237AbZL2Map (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Dec 2009 07:30:45 -0500
In-Reply-To: <82cfbe860912290428v573ec0c5k5506ad3dad6c0c35@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tarek attia <tarek.m.attia@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

>>> Each time I enable the ondemand governor ,it works fine for a while
>>> ,but each time the frequency is changed this messages appears :-
>>>
>>> SR1: VDD autocomp is not active
>>>
>>> then it works again ,but after small amount of time this messages
>>> appears followed by hang up for the overall system
>>>
>>> SR2: VDD autocomp is not active
>>>
>>>
>> try this:
>> echo 1 > /sys/power/sr_vdd1_autocomp; echo 1 > /sys/power/sr_vdd2_autocomp
What platform are you using? Also what is your git HEAD?
I can smell 3630... ;-) please confirm.
