From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: DRA7: Add aliases for all serial ports
Date: Tue, 21 Oct 2014 15:07:07 -0500
Message-ID: <5446BCEB.3020708@ti.com>
References: <1413908295-699-1-git-send-email-nm@ti.com> <3461773.MMIsJQMVIu@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3461773.MMIsJQMVIu@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, "Franklin Cooper Jr." <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

On 10/21/2014 02:57 PM, Arnd Bergmann wrote:
> On Tuesday 21 October 2014 11:18:15 Nishanth Menon wrote:
>> Add serial port aliases for consoles > 6.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>  arch/arm/boot/dts/dra7.dtsi |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index 9cc9843..208dd83 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -34,6 +34,10 @@
>>                 serial3 = &uart4;
>>                 serial4 = &uart5;
>>                 serial5 = &uart6;
>> +               serial6 = &uart7;
>> +               serial7 = &uart8;
>> +               serial8 = &uart9;
>> +               serial9 = &uart10;
>>
> 
> I think this was wrong to start with: The aliases should be in the per-board
> .dts file and only list the ones that are actually connected to the outside.
> 
> Otherwise the numbering won't match what's written on the board.

At least in the case of DRA7 boards, they are not written specifically
since they come out over onboard FTDI usb2serial.

This will at least ensure that /dev/ttyO9 will always point to uart10
no matter the board, instead of having ttyO0 always pointing to
console serial port no matter the board (and having to guess which
figure out it actually was aliased to).

-- 
Regards,
Nishanth Menon
