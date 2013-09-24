From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: Booting recent mainline on omap5-uevm
Date: Tue, 24 Sep 2013 18:24:57 -0400
Message-ID: <52421139.1090005@ti.com>
References: <A2CA0424C0A6F04399FB9E1CD98E030458E05AC1@US01WEMBX2.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49061 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374Ab3IXWZA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Sep 2013 18:25:00 -0400
In-Reply-To: <A2CA0424C0A6F04399FB9E1CD98E030458E05AC1@US01WEMBX2.internal.synopsys.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Zimmerman <Paul.Zimmerman@synopsys.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "lokeshvutla@ti.com" <lokeshvutla@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Anna, Suman" <s-anna@ti.com>

On Tuesday 24 September 2013 04:30 PM, Paul Zimmerman wrote:
>> From: Paul Zimmerman
>> Sent: Tuesday, September 24, 2013 1:21 PM
>>
>> Hi,
>>
>> I have an OMAP5432 uEVM which I cannot get to boot with recent mainline
>> (tried 3.11 and 3.12-rc1). I have the TI GLSDK for this board (v6.0.0.7),
>> which comes with 3.8.4 which works fine.
>>
>> I found this thread: http://marc.info/?l=fedora-arm&m=137717811815777 and
> 
> Wrong link, should have been http://marc.info/?l=linux-omap&m=137515583214350.
> 
Its because of commit 03ab349ec{ARM: OMAP5: hwmod data: Add mailbox data} which
added hwmod data but DT data for mailbox is missing. Reverting that makes
things work. Looks like mailbox dt patches missed the last merge window.

The booting branch is pushed here [1] just in case you need it.

regards,
Santosh

[1] https://git.kernel.org/cgit/linux/kernel/git/ssantosh/linux.git/log/?h=3.12/omap5




