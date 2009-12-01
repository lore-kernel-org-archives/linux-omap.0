From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: SR1: VDD autocomp is not active
Date: Tue, 1 Dec 2009 20:04:48 +0300
Message-ID: <48239d390912010904r25b7246bx529b5132c65ef46a@mail.gmail.com>
References: <48239d390912010353l44f8e6d9w7ff963c7fb41ecf3@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE879FB1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:47253 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbZLAREm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 12:04:42 -0500
Received: by ey-out-2122.google.com with SMTP id 4so1243587eyf.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Dec 2009 09:04:48 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE879FB1@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Dec 1, 2009 at 7:08 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Sergey Lapin
>> Sent: Tuesday, December 01, 2009 5:24 PM
>> To: linux-omap@vger.kernel.org
>> Subject: SR1: VDD autocomp is not active
>>
>> Hi, all!
>>
>> on my OMAP3525-based custom board I get SR1: VDD autocomp is not
>> active and SR2: VDD autocomp is not active
>> quite frequently with PM branch. What that means, and how to fix it?
>
> Do you see them while trying to set the sr_vdd[1|2]_autocomp?
> OR
> During normal execution?
During normal execution.

>
> What is the silicon version reported when Linux kernel boot up?
OMAP3525 ES2.1 (l2cache iva neon isp )

S.
