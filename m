From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: SR1: VDD autocomp is not active
Date: Wed, 2 Dec 2009 00:16:09 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD5AA0DF@dbde02.ent.ti.com>
References: <48239d390912010353l44f8e6d9w7ff963c7fb41ecf3@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE879FB1@dbde02.ent.ti.com>,<48239d390912010904r25b7246bx529b5132c65ef46a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53598 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132AbZLASuf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 13:50:35 -0500
In-Reply-To: <48239d390912010904r25b7246bx529b5132c65ef46a@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergey Lapin <slapinid@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


________________________________________
From: Sergey Lapin [slapinid@gmail.com]
Sent: Tuesday, December 01, 2009 10:34 PM
To: Premi, Sanjeev
Cc: linux-omap@vger.kernel.org
Subject: Re: SR1: VDD autocomp is not active

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

I did notice an earlier mail where you mentioned about using an older
kernel version. have to back-ported patches specific to silicon
identification on this kernel/

It appears that efuse data required for SmartReflex to work may not
be available on this silicon... leading to these messages.

Right now, I am away from source code, will be able to verify in the
morning.

S.
