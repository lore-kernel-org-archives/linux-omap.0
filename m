From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: how to specify dma_mask and coherent_dma_mask in hwmod
Date: Thu, 28 Jun 2012 21:28:50 +0530
Message-ID: <CAAe_U6L7hMyxEYTOHShkcivdB91PxKa5OA7Q0w2Lw6zyXjXYXw@mail.gmail.com>
References: <EB1619762EAF8B4E97A227FB77B7E0293E9BDE96@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:36020 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753824Ab2F1P6y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 11:58:54 -0400
Received: by vcbgb30 with SMTP id gb30so3052924vcb.16
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 08:58:51 -0700 (PDT)
In-Reply-To: <EB1619762EAF8B4E97A227FB77B7E0293E9BDE96@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "N, Mugunthan V" <mugunthanvnm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

On Wed, Jun 27, 2012 at 11:11 AM, N, Mugunthan V <mugunthanvnm@ti.com> wrote:
>> -----Original Message-----
>> From: N, Mugunthan V
>> Sent: Thursday, June 07, 2012 9:52 PM
>> To: 'linux-omap@vger.kernel.org'
>> Cc: 'linux-arm-kernel@lists.infradead.org'
>> Subject: how to specify dma_mask and coherent_dma_mask in hwmod
>>
>> Hi
>>
>> While converting platform device registry to Hwmod for CPSW Ethernet
>> driver which is present in AM335X (OMAP2+), I am not finding a way to
>> specify
>> dma_mask and coherent_dma_mask.
>> Is there a way to specify dma_mask and coherent_dma_mask in hwmod?
>
> Ping, any one has comment on this?
>
Nope. You can specify dma_mask after creating the device as done in
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-omap2/usb-musb.c;h=c4a576856661014ea3bec9acc70f80e32d62c33b;hb=HEAD

Regards
Kishon
