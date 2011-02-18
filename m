From: archit taneja <archit@ti.com>
Subject: Re: OMAP4 Mux FW question
Date: Fri, 18 Feb 2011 10:38:14 +0530
Message-ID: <4D5DFEBE.4020902@ti.com>
References: <4D5CFA13.7030608@ti.com> <1af78c6718e8f15c87c4ab50bfa04a41@mail.gmail.com> <1e14f38aeaa635e1c2374931fd406736@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51722 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab1BRFG6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 00:06:58 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1I56tRB006809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 23:06:57 -0600
In-Reply-To: <1e14f38aeaa635e1c2374931fd406736@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "R, Sricharan" <r.sricharan@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thursday 17 February 2011 05:11 PM, Shilimkar, Santosh wrote:
> (Avoid top posting please)
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Sricharan R
>> Sent: Thursday, February 17, 2011 5:05 PM
>> To: Archit Taneja; Benoit Cousson; linux-omap@vger.kernel.org
>> Subject: RE: OMAP4 Mux FW question
>>
>> Hi Archit,
>>   Those control registers are not a part of the mux list.
>>   So the mux framework does not support configuring them.
>>   Only the pad mux registers are configured.
>
> [....]
>
> If they are not part of MUX registers then you could
> use control APIs directly. They should work.
>
> omap4_ctrl_pad_readl() and omap4_ctrl_pad_writel()

I tried this out, it works fine with this.

Thanks,
Archit

