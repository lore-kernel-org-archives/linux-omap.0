From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: Help wanted with USB and OMAP3 off_mode
Date: Wed, 16 Jan 2013 11:28:02 +0200
Message-ID: <50F672A2.6010500@compulab.co.il>
References: <20130109092915.1c2077b5@notabene.brown> <50ED3FA5.9030905@compulab.co.il> <20130109211931.0e00db5d@notabene.brown> <50ED4549.6080802@amarulasolutions.com> <20130109223456.7832c2bd@notabene.brown> <50ED5DBE.4000107@amarulasolutions.com> <50ED6868.1080900@compulab.co.il> <20130116182606.5249db0c@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:40669 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758688Ab3APJ2K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jan 2013 04:28:10 -0500
In-Reply-To: <20130116182606.5249db0c@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/16/13 09:26, NeilBrown wrote:
> On Wed, 09 Jan 2013 14:54:00 +0200 Igor Grinberg <grinberg@compulab.co.il>
> wrote:
> 
>> On 01/09/13 14:08, Michael Trimarchi wrote:
>>> Hi Neil
>>>
>>> I forget to answer to your questions
>>>
>>> On 01/09/2013 12:34 PM, NeilBrown wrote:
>>>> On Wed, 09 Jan 2013 11:24:09 +0100 Michael Trimarchi
>>>> <michael@amarulasolutions.com> wrote:
>>>>
>>>>> Hi Neil
>>>>>
>>>>> On 01/09/2013 11:19 AM, NeilBrown wrote:
>>>>>> On Wed, 09 Jan 2013 12:00:05 +0200 Igor Grinberg <grinberg@compulab.co.il>
>>>>>> wrote:
>>>>>>
>>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>>>> Hash: SHA1
>>>>>>
>>>>>>> Hi Neil,
>>>>>>
>>>>>>> On 01/09/13 00:29, NeilBrown wrote:
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>  I'm trying to get off_mode working reliably on my gta04 mobile phone.
>>>>>>>>
>>>>>>>> My current stumbling block is USB.  The "Option" GSM module is attached via
>>>>>>>> USB (there is a separate transceiver chip attached to port 1 which is placed
>>>>>>>> in OMAP_EHCI_PORT_MODE_PHY).
>>>>>>
>>>>>>> Which PHY is this (vendor/model)?
>>>>>>
>>>>>> Hi Igor,
>>>>>>   it is the SMSC USB3322
>>>>>>
>>>>>> http://www.smsc.com/media/Downloads_Public/Data_Sheets/3320.pdf
>>>>>>
>>>>>>
>>>>>> BTW I subsequently discovered that keeping USBHOST out off off_mode only
>>>>>> sometimes avoid the problem, not always.  So there are probably multiple
>>>>>> issues :-(
>>
>> We have the same PHY and it has some issues with the OMAP USB code.
>> First issue we experience is that if we reset the PHY more then once
>> w/o power cycling it, the PHY dies until next power cycle.
>> So, we stop providing the reset GPIO to the usb code and do the reset
>> in the board code.
> 
> I've tried various change w.r.t the resetting and  I cannot fault it.
> Resetting or not resetting neither causes a problem while the USB is
> otherwise working, not fixed the USB while  it is otherwise failing.
> So I don't think this is my problem - thanks.
> 
>>
>>>>>
>>>>> Are you sure that you don't have glitch on power, reset pin during suspend?
>>>>>
>>>>
>>>> No, I don't really have the equipment to measure such things.
>>>> But is it likely?  Would enabling off_mode make it more likely?
>>>
>>> I don't know the reason of the off_mode problem :(
>>
>> We have the equipment to check this and no - this is not the case.
>>
>>>
>>>> Can you suggest some way I could test the hypothesis?
>>>
>>> I had the same problem on a rugged mobile phone, so it is just experience
>>> Check the modem power and reset gpio too, but if you don't need to unblock it
>>> with the pin after resume we know that modem is not the problem
>>
>> I don't think modem is the problem...
>> We have plain USB connector ports that are dead after the resume from off-mode.
>>
>> The good news are that we have the off-mode working on v3.6.1,
>> including the USB, but we had to do some horrible ugly hacking for this.
>>
> 
> I assume this  means "some patches on top of 3.6.1" ??
> Care to share your code?  Even horribly ugly hacks can be educational.

We are not ready to share these patches (this will happen eventually
after some work is finished), but I can explain what they do...

We split the ehci_run function to separate the debugfs and sysfs stuff from
other initializations, so we can run the new version without the debugfs and
sysfs stuff multiple times.

Then we implement the suspend/resume ehci callbacks:
on suspend, assert phy reset,
on resume, deassert phy reset, write EHCI_INSNREG04_DISABLE_UNSUSPEND to
EHCI_INSNREG04, and call the new ehci_run() function.

That does the job for USB host to resume from off mode.

- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJQ9nKiAAoJEBDE8YO64Efa7U4QAKFXRyyNR5Q7jjwVG6UwITWq
6kJyNXJKQTqn6GLEV7xJmT4SZAtxq+dRDl/XE9dcXFK3RTebttXxyVz1X0vXZQud
h6QLenH8jHczNubfn6CTLI38PKprl1F2zpZtjKpHfNmD5cLWzJ1EIoTH19ENsJ4v
zV3KI3RgiFuq02vxOULtp9gP/x0WZSHwBEGm/ToqqsEaX7wAJc2BDFOSS8NpSGbb
VLPFA1doMrFOYkL+oMS2IVudM0wEYCBGhGxMi/Y++RY1omlonhEGCoVxaxzGoHrk
H/ZpxFheIGBKwo+VX1eSgW9oQZyzbPZttyEWXXNCRh/6oejXCBSS3zkKrWrctmVD
ONu1gzoaC9p/c1n2GDioIfxC41dPKdjCETMbTi9rR5shc12ZmwtrgUOU80mpzWj3
6fY+TRW4x8qYbsFL89T6TWGpDz7JrBdtdJiBD/TPtJW05ikn9DTL5/GNVjeeoRk0
5DJ06pHh+rQFKThEvoDdLAH3PZdtDVSdXnAg+gF4D7/BMZ14TLHmW2l471I95S2I
eKxZxIwFa2IscTbGKhTlrdPF4UShEvLuFgO6NCb1ea1FT7m3ih8rwA5ObI4676DG
Y5kokqi9dpzMB/6T/SDk/gySTg9WUDXFlhS6x/b89f1xC71GzGTJkkqqH4u6KfX8
GcqI3wEFlqpG4FM39XAw
=nynZ
-----END PGP SIGNATURE-----
