From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH] usb otg: TWL4030_USB depends on USB_MUSB_OMAP2PLUS in Kconfig
Date: Fri, 24 Aug 2012 15:48:24 +0530
Message-ID: <CAAe_U6KK0=W4SAM4pqe4Zy55Vva=-32cDHNgaRGG0JFfegd+mw@mail.gmail.com>
References: <20120820113624.GP17455@arwen.pp.htv.fi>
	<1345754324-12068-1-git-send-email-pmeerw@pmeerw.net>
	<20120824072729.GE3334@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:54349 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751356Ab2HXKSZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Aug 2012 06:18:25 -0400
Received: by vcdd16 with SMTP id d16so4183024vcd.16
        for <linux-omap@vger.kernel.org>; Fri, 24 Aug 2012 03:18:24 -0700 (PDT)
In-Reply-To: <20120824072729.GE3334@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Peter Meerwald <pmeerw@pmeerw.net>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hi,

On Fri, Aug 24, 2012 at 12:57 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Thu, Aug 23, 2012 at 10:38:44PM +0200, Peter Meerwald wrote:
>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
>
> I need a commit log explaining why we need to add this extra depend ;-)
>
>> ---
>>  drivers/usb/otg/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
>> index 13fd1ddf..fefca18 100644
>> --- a/drivers/usb/otg/Kconfig
>> +++ b/drivers/usb/otg/Kconfig
>> @@ -58,7 +58,7 @@ config USB_ULPI_VIEWPORT
>>
>>  config TWL4030_USB
>>       tristate "TWL4030 USB Transceiver Driver"
>> -     depends on TWL4030_CORE && REGULATOR_TWL4030
>> +     depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS

Can you add this for twl6030 also?

Thanks
Kishon
