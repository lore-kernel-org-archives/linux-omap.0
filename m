From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Subject: Re: [PATCHv4 0/4] OMAP: Serial: remove magic and diplicates
Date: Fri, 12 Nov 2010 15:20:07 +0200
Message-ID: <AANLkTin-j1Aww+Nu4zRdAP5TH-t+ftpW6VEWUdejb1Pn@mail.gmail.com>
References: <1289567043-6213-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DC24F05C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC24F05C@dbde02.ent.ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm@lists.arm.linux.org.uk" <linux-arm@lists.arm.linux.org.uk>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 12, 2010 at 3:17 PM, G, Manjunath Kondaiah <manjugk@ti.com>=
 wrote:
>
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>> Emeltchenko Andrei
>> Sent: Friday, November 12, 2010 6:34 PM
>> To: linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org;
>> linux-arm@lists.arm.linux.org.uk; linux-serial@vger.kernel.org
>> Subject: [PATCHv4 0/4] OMAP: Serial: remove magic and diplicates
>
> s/diplicates/duplicates
>
>>
>> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>>
>> Add MDR1 Serial register definition to serial_reg and remove
>> duplicated
>> code, remove magic MDR1 register numbers from serial drivers.
>>
>> *v2 add OMAP keyword to MDR1 definition
>> *v3 remove magic from serial drivers
>> *v4 taking comments from Manjunath and Govindraj: typos, CC
>>
>> Andrei Emeltchenko (4):
>> =A0 OMAP: Serial: Define OMAP uart MDR1 register definitions
>> =A0 OMAP1: Serial: remove magic numbers for MDR1 reg
>> =A0 OMAP2: Serial: remove magic numbers for MDR1 reg
>> =A0 OMAP: Serial: remove redefined MDR1 register definitions
>>
>> =A0arch/arm/mach-omap1/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A06 ++++--
>> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 15 +++++++++------
>> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A03 ---
>> =A0drivers/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A06 +++---
>> =A0include/linux/serial_reg.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 12 ++++++++++++
>> =A05 files changed, 28 insertions(+), 14 deletions(-)
>
> Do you think patch series is required for these changes? How about
> merging with single patch?

I can merge, sometimes somebody need patches to be split, merging is ea=
sy.

-- Andrei
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
