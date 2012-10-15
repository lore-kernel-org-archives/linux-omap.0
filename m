From: Vivek Gautam <gautamvivek1987@gmail.com>
Subject: Re: [PATCH] USB: DWC3: Shutdown usb_phy when removing the device
Date: Mon, 15 Oct 2012 19:22:11 +0530
Message-ID: <CAFp+6iFg=qvUv7fR-LH_qz4MHwiPTEb=1BHcre5CWgcm6aQwKg@mail.gmail.com>
References: <1350136218-25678-1-git-send-email-gautam.vivek@samsung.com>
	<20121015121403.GK24333@arwen.pp.htv.fi>
	<CAFp+6iGCRop0Q0M4q5Za1F819Wk7cqnBGfgnnnWBkUNcBPyjpg@mail.gmail.com>
	<20121015132412.GS24333@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:44714 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073Ab2JONwN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 09:52:13 -0400
In-Reply-To: <20121015132412.GS24333@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Vivek Gautam <gautam.vivek@samsung.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, rob.herring@calxeda.com

Hi,

On Mon, Oct 15, 2012 at 6:54 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Mon, Oct 15, 2012 at 06:56:13PM +0530, Vivek Gautam wrote:
>> Hi Felipe,
>>
>> On Mon, Oct 15, 2012 at 5:44 PM, Felipe Balbi <balbi@ti.com> wrote:
>> > On Sat, Oct 13, 2012 at 07:20:18PM +0530, Vivek Gautam wrote:
>> >> We do usb_phy_init() while doing core_init() in probe,
>> >> so adding usb_phy_shutdown() when we do core_exit()
>> >> while removing the device.
>> >>
>> >> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>> >
>> > I believe this needs to be sent to stable too for v3.6, right ?
>> >
>> As i can see, 51e1e7b usb: dwc3: add basic PHY support, is yet to be
>> merged in stable. Then only it will be possible to merge this in
>> stable, right ?
>
> oh indeed. that was added on v3.7 merge window. My bad. No need to Cc
> stable, I'll apply this as a fix.
>
Ok, Thank you.
> cheers
>
> --
> balbi

Regards
Vivek
