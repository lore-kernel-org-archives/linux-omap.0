From: Archit Taneja <a0393947@ti.com>
Subject: Re: NFS mount issue with OMAP4 on linux-next
Date: Tue, 24 Jul 2012 12:37:45 +0530
Message-ID: <500E49C1.3000703@ti.com>
References: <500E3B9B.9080702@ti.com> <500E3E4E.1060809@ti.com> <CANfBPZ_EJJk_HRCpUpZHauJCjJ8HgQO=YC104roEcKsAAw=iMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34814 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab2GXHJD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 03:09:03 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q6O792hT011588
	for <linux-omap@vger.kernel.org>; Tue, 24 Jul 2012 02:09:03 -0500
In-Reply-To: <CANfBPZ_EJJk_HRCpUpZHauJCjJ8HgQO=YC104roEcKsAAw=iMA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tuesday 24 July 2012 12:23 PM, S, Venkatraman wrote:
> On Tue, Jul 24, 2012 at 11:48 AM, Archit Taneja <a0393947@ti.com> wrote:
>> Hi,
>>
>> Comparing with working logs, I see this difference:
>>
>> [    1.502166] spi spi1.0: no RX DMA engine channel for McSPI
>> [    1.507904] omap2_mcspi omap2_mcspi.1: can't setup spi1.0, status -11
>> [    1.514862] omap2_mcspi omap2_mcspi.1: can't create new device for ks8851
>>
>> I guess that's why it isn't working?
>>
> Most likely yes. SPI is needed for ethernet on OMAP4.
> Please include this patch in your build and check..
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commit;h=55936cdfaaf11ac352b56bc58e42d6661e65ee13

It works fine with this.

Thanks,
Archit

>
>

