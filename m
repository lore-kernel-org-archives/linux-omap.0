From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH] Add support for Newflow NanoBone board
Date: Sun, 11 Aug 2013 13:35:26 +0200
Message-ID: <CAAwP0s2xHVNOBayEx-WnjB-XVbXco14tW5nOt17ZuLCuQ_qH1A@mail.gmail.com>
References: <51DB0B85.7000102@newflow.co.uk> <52074AEA.4070205@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62483 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194Ab3HKLfr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Aug 2013 07:35:47 -0400
Received: by mail-vc0-f174.google.com with SMTP id gd11so2095089vcb.5
        for <linux-omap@vger.kernel.org>; Sun, 11 Aug 2013 04:35:46 -0700 (PDT)
In-Reply-To: <52074AEA.4070205@newflow.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@newflow.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>

On Sun, Aug 11, 2013 at 10:27 AM, Mark Jackson <mpfj-list@newflow.co.uk> wrote:
> On 08/07/13 19:57, Mark Jackson wrote:
>> NanoBone Specification:
>> -----------------------
>> CPU:
>>   TI AM335x @ 720MHz
>>
>> Memory:
>>   256MB DDR3
>>   128MB NOR flash
>>   128KB FRAM
>>
>> Ethernet:
>>   2 x 10/100 connected to SMSC LAN8710 PHY
>>
>> USB:
>>   1 x USB2.0 Type A
>>
>> I2C:
>>   2Kbit EEPROM (Microchip 24AA02)
>>   RTC (Maxim DS1338)
>>   GPIO Expander (Microchip MCP23017)
>>
>> Expansion connector:
>>   6 x UART
>>   1 x MMC/SD
>>   1 x USB2.0
>>
>> Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
>> ---
>>  MAINTAINERS                       |    6 +
>>  arch/arm/boot/dts/Makefile        |    1 +
>>  arch/arm/boot/dts/am335x-nano.dts |  388 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 395 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/am335x-nano.dts
>
> Any comments on this new board file ?

Hi Mark,

Overall it looks very good to me, I just have one small comment.
Please don't redefine device nodes that are already defined in the
included am33xx.dtsi file (pinmux, ocp, gpmc, etc). You should just
use what is defined there instead of defining it again in your board
DT file.

Also these are IP modules that are internal details of the SoC so is
better to keep them outside of board DT files definition.

Please take a look to my am33xx cleanups series [1] to see how it
should be defined. Once you have made that changes feel free to add
my:

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Benoit seems to be on holidays so please be patient with him taking your patch.

[1]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg93738.html

Thanks a lot and best regards,
Javier
