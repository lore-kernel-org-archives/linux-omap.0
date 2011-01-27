From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V2] OMAP3EVM:FIX: Reset the smsc911x ethernet controller in board_init
Date: Thu, 27 Jan 2011 12:08:16 -0800
Message-ID: <87d3nikt3j.fsf@ti.com>
References: <1295968956-10166-1-git-send-email-hvaibhav@ti.com>
	<19F8576C6E063C45BE387C64729E739404BD7BE3F4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:42135 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752752Ab1A0UIU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jan 2011 15:08:20 -0500
Received: by mail-yw0-f50.google.com with SMTP id 21so842474ywc.23
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 12:08:19 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E739404BD7BE3F4@dbde02.ent.ti.com>
	(Vaibhav Hiremath's message of "Tue, 25 Jan 2011 20:58:44 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

>> -----Original Message-----
>> From: Hiremath, Vaibhav
>> Sent: Tuesday, January 25, 2011 8:53 PM
>> To: linux-omap@vger.kernel.org
>> Cc: Hiremath, Vaibhav; Varadarajan, Charulatha
>> Subject: [PATCH-V2] OMAP3EVM:FIX: Reset the smsc911x ethernet controller
>> in board_init
>> 
>> With addition of hwmod support to gpio, the ethernet controller
>> goes undetected for OMAP35xEVM. So explicitly assert the reset signal to
>> ethernet controller smsc911x -
>> 
>> 	- GPIO7 (>=RevG version of EVM's)
>> 	- GPIO64 (<=RevD version of EVM's)
>> 
>> This patch is based on intial version from Charulatha V, reference
>> to original discussion -
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35784.html
>> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> Tested-by: Kevin Hilman <khilman@ti.com>
>> ---
>> Since Kevin reported that this patch doesn't get applied cleanly,
>> so I am reposting it again after making sure that it gets applied cleanly.
>> 
> [Hiremath, Vaibhav] Oops, missed linux-arm-kernel list, adding here.
>
> Not sure whether I need to repost keeping linux-arm-kernel?
>

Also, did you post the smc911x driver fix yet that is needed for testing
with newer kernels?

Kevin
