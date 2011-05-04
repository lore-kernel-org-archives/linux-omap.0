From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [RFC] About ARM expansion boards and others things
Date: Wed, 04 May 2011 14:20:30 +0300
Message-ID: <4DC1367E.3010603@compulab.co.il>
References: <BANLkTimjWtqLsWA1Gthix6RZYMzNRdC7rg@mail.gmail.com> <4DC13032.5010404@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:59128
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753150Ab1EDLUc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 May 2011 07:20:32 -0400
In-Reply-To: <4DC13032.5010404@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: =?UTF-8?B?RW5yaWMgQmFsbGV0YsOyIGkgU2VycmE=?= <eballetbo@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>

Sorry for the second send attempt, the first one was

accidentally sent to wrong addresses.


On 05/04/11 13:53, Igor Grinberg wrote:

> On 05/03/11 20:25, Enric Balletb=C3=B2 i Serra wrote:
>
>> Hi guys,
>> I'm thinking probably in a crazy idea, I hope someone can help me or
>> kill definitely this idea from my mind.
> This is not that crazy as you think it is...
>
>> I'll explain a little more, the real problem is I don't know how to
>> add support for an expansion board for IGEP v2 board. I see most of
>> boards adds the support inside the board-xxxxx.c file, for example i=
f
>> the expansion board has a Touchscreen interface using ADS7846/TSC204=
6
>> they register ads7846 platform data in board-xxxx.c file. This is ok
>> beacause the ads7846 can be detected and if expansion board is not
>> present  the detection fails, but maybe other devices in expansion
>> board can't be detected (for example an I/O expansion). So which is
>> the best form to do this ?
>>
>> I'm thinking in create a kernel module for the expansion board that
>> add all the new features, the expansion board should come with a I2C
>> E2PROM for board ID storage, so the idea is create an i2c driver tha=
t
>> reads the E2PROM and if found the Board ID inits all the expansion
>> board devices.
> Why do you need to create a new driver? Why don't you use the existin=
g one?
> at24 works nice with most i2c EEPROMs.
>
> Let me generalize:
> 1) Lets call each board that actually has SoC, like IGEP, a System On=
 Module (SoM)
> 2) SoM has on-board and on-SoC devices
> 3) expansion has additional on-board devices
> 4) We are talking about X SoMs and Y extensions
> 5) Each SoM can be connected to each extension and communicate with i=
ts devices.
> 6) We are looking for a solution to be able to detect the expansion a=
nd register
>    the devices it has assembled.
>
>> I have done a few experiments, I've created a kernel module (driver)
>> for a custom expansion board for IGEP v2,  the expansion board has :
>>    - I2C E2PROM
>>    - ADS7846 touch controller (spi)
>>    - Seiko 7.0inch LCD
>>    - General purpose I/O
>>
>> The driver is capable to register correctly i2c and spi devices and
>> seems is working but I have problems with the Seiko 7.0inch LCD and
>> configuring the MUX from driver.
> Like Tony already said the generic MUX API should solve the problem o=
f MUX.
> But, you will still have a problem with devices that have to be initi=
alized
> very early, like IO chips.
>
>> Basically I wonder if it's possible add another omap_dss_device from
>> kernel module to the omap DSS driver (something like
>> omap_dss_register_new_device). Is a good or bad idea ? Why ? Is any
>> reason to not export the MUX functionality to be used for other
>> drivers ?
> ...
>
>> All of this is a crazy idea ? What's the best form to solve the prob=
lem ?
> This is not crazy at all.
> We already use this concept in our BSP, we detect the expansion
> by reading data from EEPROM, and register the devices accordingly.
> We solve the MUX problem by initializing the pins to some default sta=
te
> and once the expansion detection is done, we reconfigure the pins
> to their right state as required by connected devices.
>
> And yes the above is done from board file.
> I don't see any reason to create a driver for the expansion,
> unless it can be removed/attached "on the fly" while the SoM is up an=
d running.
>
> Nevertheless, some framework or at least an agreement on how we shoul=
d
> separate the SoM code from the expansion code.
>
> I thought of some convention like board-*.c will stay the code for th=
e SoM
> and exp-*.c will be used for the expansion code.
> Now, the code in board-*.c will do the detection of the expansion and
> run the appropriate exp_*_init() function, which will do the initiali=
zation steps
> for the detected expansion.
> A bit more complicated solution will be needed if there are several e=
xpansions
> connected all together.
>
> I have had this in my mind for very long time, but did not want to bo=
ther,
> because there were discussions about a totally different approach whi=
ch uses
> device trees (DT), where the detection of expansion is moved away
> from the kernel code.
>
> With the DT approach, the kernel (should) get(s) all the information =
regarding
> the devices and how they are wired for free (no detection).
> If I understand correctly, the information about devices
> (whether on SoM or expansion) could be either statically added to the=
 DT
> structures or dynamically detected by the bootloader and passed to th=
e
> kernel (like ATAGS work now).
>
> I still doubt what approach would be better...
>

--=20
Regards,
Igor.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
