From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Mon, 3 Nov 2008 15:36:14 -0800
Message-ID: <5e088bd90811031536o17969766o3632e99ed8add54d@mail.gmail.com>
References: <1225418657-31775-1-git-send-email-tony@atomide.com>
	 <200810302012.35317.david-b@pacbell.net>
	 <5e088bd90810302105n1132c280ga39179c057e55c3f@mail.gmail.com>
	 <200810310300.24515.david-b@pacbell.net>
	 <5e088bd90811031454q622f0ad9w274e0225dc885967@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:39505 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbYKCXgQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Nov 2008 18:36:16 -0500
Received: by ey-out-2122.google.com with SMTP id 6so966940eyi.37
        for <linux-omap@vger.kernel.org>; Mon, 03 Nov 2008 15:36:14 -0800 (PST)
In-Reply-To: <5e088bd90811031454q622f0ad9w274e0225dc885967@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Mon, Nov 3, 2008 at 2:54 PM, Steve Sakoman <sakoman@gmail.com> wrote:
> On Fri, Oct 31, 2008 at 2:00 AM, David Brownell <david-b@pacbell.net> wrote:
>> On Thursday 30 October 2008, Steve Sakoman wrote:
>>> > Overo has its SDIO WLAN chip (libertas) hard wired to the second controller,
>>> > as I understand things ... or maybe it's the third one.  :)
>>>
>>> Correct!  The wi2wi chip is connected to mmc2 with a 4 bit data path.
>>
>> With the appended patch on top of Tony's four, I get:
>>
>>  mmc1: new SDIO card at address 0001
>>  firmware: requesting sd8686_helper.bin
>>  ...
>>  libertas: can't load helper firmware
>>  libertas: failed to load helper firmware
>>  libertas_sdio: probe of mmc1:0001:1 failed with error -2
>>
>> So, progress.  What's the best place to get that stuff?
>> Do we know that this driver behaves with SDIO yet?
>
> After a bit more work I now have a wireless connection!
>
> So I guess we now have confirmation that the driver supports the
> second mmc slot even for SDIO!
>
> I used David's appended patch plus Tony's 4 HSMMC patches.
>
> I used version 8.73.7p3 of the Marvell SD8686 firmware and helper
> binaries and placed them in /lib/firmware.

I just tried version 9.70.3p24 of the firmware & helper and have
confirmed that it also works.

This version is much more easily available from the Marvell site.  Go to:

http://www.marvell.com/drivers/search.do

Select "Network Controller" for device type (it's the only choice),
and "Linux 2.6 - Fedora" for the OS.

You will then be offered two choices, pick
SD-8686-LINUX26-SYSKT-9.70.3.p24-26409.P45-GPL.  Extract (and then
extract the tar image contained within) and look in the FWImage
directory.  Copy both .bin files to your omap system's /lib/firmware
directory and rename helper_sd.bin to sd8686.bin.

Steve
