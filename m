From: "arun c" <arun.edarath@gmail.com>
Subject: Re: USB-webcam support
Date: Tue, 12 Aug 2008 16:48:09 +0530
Message-ID: <c656a4d20808120418y1b53316fgb86f13bf833512fe@mail.gmail.com>
References: <c656a4d20808120332v224c5053r7225c086acd8c2cd@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB0256A366A2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:53433 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbYHLLSL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 07:18:11 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1277645tic.23
        for <linux-omap@vger.kernel.org>; Tue, 12 Aug 2008 04:18:09 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0256A366A2@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Aug 12, 2008 at 4:20 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
>> Hi All,
>>
>> If I have a USB camera with good Linux support, can I connect it
>> to omap3evm(or any omap2) and make it functional?
>
> I don't see why not. Do you expect a problem with using it? You could
> use MUSB in host or OTG mode and connect the camera to the MUSB port.
>
I have a Creative webcam and a fedora9 host machine. If I connect
my webcam to my PC it happily gives me /dev/video0 to play with(I can grab
photos, use xawtv). Can I expect the same with the OMAP3EVM?


Regards,
Arun C
> - Anand--
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
