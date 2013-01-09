From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: Help wanted with USB and OMAP3 off_mode
Date: Wed, 09 Jan 2013 13:08:30 +0100
Message-ID: <50ED5DBE.4000107@amarulasolutions.com>
References: <20130109092915.1c2077b5@notabene.brown> <50ED3FA5.9030905@compulab.co.il> <20130109211931.0e00db5d@notabene.brown> <50ED4549.6080802@amarulasolutions.com> <20130109223456.7832c2bd@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:64834 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756635Ab3AIMIi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jan 2013 07:08:38 -0500
Received: by mail-bk0-f49.google.com with SMTP id jm19so852385bkc.8
        for <linux-omap@vger.kernel.org>; Wed, 09 Jan 2013 04:08:37 -0800 (PST)
In-Reply-To: <20130109223456.7832c2bd@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org

Hi Neil

I forget to answer to your questions

On 01/09/2013 12:34 PM, NeilBrown wrote:
> On Wed, 09 Jan 2013 11:24:09 +0100 Michael Trimarchi
> <michael@amarulasolutions.com> wrote:
> 
>> Hi Neil
>>
>> On 01/09/2013 11:19 AM, NeilBrown wrote:
>>> On Wed, 09 Jan 2013 12:00:05 +0200 Igor Grinberg <grinberg@compulab.co.il>
>>> wrote:
>>>
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA1
>>>
>>>> Hi Neil,
>>>
>>>> On 01/09/13 00:29, NeilBrown wrote:
>>>>>
>>>>> Hi,
>>>>>  I'm trying to get off_mode working reliably on my gta04 mobile phone.
>>>>>
>>>>> My current stumbling block is USB.  The "Option" GSM module is attached via
>>>>> USB (there is a separate transceiver chip attached to port 1 which is placed
>>>>> in OMAP_EHCI_PORT_MODE_PHY).
>>>
>>>> Which PHY is this (vendor/model)?
>>>
>>> Hi Igor,
>>>   it is the SMSC USB3322
>>>
>>> http://www.smsc.com/media/Downloads_Public/Data_Sheets/3320.pdf
>>>
>>>
>>> BTW I subsequently discovered that keeping USBHOST out off off_mode only
>>> sometimes avoid the problem, not always.  So there are probably multiple
>>> issues :-(
>>
>> Are you sure that you don't have glitch on power, reset pin during suspend?
>>
> 
> No, I don't really have the equipment to measure such things.
> But is it likely?  Would enabling off_mode make it more likely?

I don't know the reason of the off_mode problem :(

> Can you suggest some way I could test the hypothesis?

I had the same problem on a rugged mobile phone, so it is just experience
Check the modem power and reset gpio too, but if you don't need to unblock it
with the pin after resume we know that modem is not the problem

Michael

> 
> The power pin is connected to a 3v3 regulator which certainly should stay on
> the whole time and other things which depend on it keep working.
> 
> The reset line is connected to GPIO174 which is configured:
> 
> # cat /sys/kernel/debug/omap_mux/mcspi1_cs0
> name: mcspi1_cs0.gpio_174 (0x480021ce/0x19e = 0x011c), b ac2, t NA
> mode: OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE4
> signals: mcspi1_cs0 | sdmmc2_dat7 | NA | NA | gpio_174 | NA | NA | safe_mode
> 
> The "PIN_INPUT" seems a bit odd, so I changed it to OMAP_PIN_OUTPUT but that
> didn't appear to make any difference.
> 
> Thanks,
> NeilBrown
> 

