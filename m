From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: Help wanted with USB and OMAP3 off_mode
Date: Wed, 09 Jan 2013 14:54:00 +0200
Message-ID: <50ED6868.1080900@compulab.co.il>
References: <20130109092915.1c2077b5@notabene.brown> <50ED3FA5.9030905@compulab.co.il> <20130109211931.0e00db5d@notabene.brown> <50ED4549.6080802@amarulasolutions.com> <20130109223456.7832c2bd@notabene.brown> <50ED5DBE.4000107@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:34725 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757522Ab3AIMyI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Jan 2013 07:54:08 -0500
In-Reply-To: <50ED5DBE.4000107@amarulasolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: NeilBrown <neilb@suse.de>, linux-omap@vger.kernel.org

On 01/09/13 14:08, Michael Trimarchi wrote:
> Hi Neil
> 
> I forget to answer to your questions
> 
> On 01/09/2013 12:34 PM, NeilBrown wrote:
>> On Wed, 09 Jan 2013 11:24:09 +0100 Michael Trimarchi
>> <michael@amarulasolutions.com> wrote:
>>
>>> Hi Neil
>>>
>>> On 01/09/2013 11:19 AM, NeilBrown wrote:
>>>> On Wed, 09 Jan 2013 12:00:05 +0200 Igor Grinberg <grinberg@compulab.co.il>
>>>> wrote:
>>>>
>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>> Hash: SHA1
>>>>
>>>>> Hi Neil,
>>>>
>>>>> On 01/09/13 00:29, NeilBrown wrote:
>>>>>>
>>>>>> Hi,
>>>>>>  I'm trying to get off_mode working reliably on my gta04 mobile phone.
>>>>>>
>>>>>> My current stumbling block is USB.  The "Option" GSM module is attached via
>>>>>> USB (there is a separate transceiver chip attached to port 1 which is placed
>>>>>> in OMAP_EHCI_PORT_MODE_PHY).
>>>>
>>>>> Which PHY is this (vendor/model)?
>>>>
>>>> Hi Igor,
>>>>   it is the SMSC USB3322
>>>>
>>>> http://www.smsc.com/media/Downloads_Public/Data_Sheets/3320.pdf
>>>>
>>>>
>>>> BTW I subsequently discovered that keeping USBHOST out off off_mode only
>>>> sometimes avoid the problem, not always.  So there are probably multiple
>>>> issues :-(

We have the same PHY and it has some issues with the OMAP USB code.
First issue we experience is that if we reset the PHY more then once
w/o power cycling it, the PHY dies until next power cycle.
So, we stop providing the reset GPIO to the usb code and do the reset
in the board code.

>>>
>>> Are you sure that you don't have glitch on power, reset pin during suspend?
>>>
>>
>> No, I don't really have the equipment to measure such things.
>> But is it likely?  Would enabling off_mode make it more likely?
> 
> I don't know the reason of the off_mode problem :(

We have the equipment to check this and no - this is not the case.

> 
>> Can you suggest some way I could test the hypothesis?
> 
> I had the same problem on a rugged mobile phone, so it is just experience
> Check the modem power and reset gpio too, but if you don't need to unblock it
> with the pin after resume we know that modem is not the problem

I don't think modem is the problem...
We have plain USB connector ports that are dead after the resume from off-mode.

The good news are that we have the off-mode working on v3.6.1,
including the USB, but we had to do some horrible ugly hacking for this.

-- 
Regards,
Igor.
