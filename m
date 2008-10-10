From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Git tree updated to v2.6.27, some issues remain
Date: Sat, 11 Oct 2008 04:04:40 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870239624A48@dbde02.ent.ti.com>
References: <20081010120427.GZ3044@atomide.com>
	 <200810100843.47808.david-b@pacbell.net>
	 <5e088bd90810100857p2cea5429s810c9810f05bd341@mail.gmail.com>
	 <FCCFB4CDC6E5564B9182F639FC3560870239624A2E@dbde02.ent.ti.com>
	 <FCCFB4CDC6E5564B9182F639FC3560870239624A46@dbde02.ent.ti.com>
 <e5e6ade50810101529y53a1e203g68d5faeaaada22c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60584 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbYJJWe4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 18:34:56 -0400
In-Reply-To: <e5e6ade50810101529y53a1e203g68d5faeaaada22c7@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

>Sent: Friday, October 10, 2008 5:29 PM
>To: Pandita, Vikram
>Cc: linux-omap@vger.kernel.org List
>Subject: Re: Git tree updated to v2.6.27, some issues remain
>
>On Fri, Oct 10, 2008 at 3:15 PM, Pandita, Vikram <vikram.pandita@ti.com> wrote:
>> Theory changed. NR_IRQS is 402. so above is not the issue.
>>
>> Theory 2:
>> When I debug on LDP board, I can see the failure happening in request_irq()
>>
>> In T2-probe:
>>        request_irq( ... )
>>                ...
>>                if (irq_desc[irq].status & IRQ_NOREQUEST)
>>                        return -EINVAL; >>>> code returns from here !!!
>>                ...
>
>This is exactly what I saw when testing bare linux-omap git without
>Dave's i2c retry patch.  Maybe the patch is not working for you?

Check the fix I just sent. 

>
>- Nathan

