From: pekon <pekon@pek-sem.com>
Subject: Re: [PATCH] mtd: nand: omap: Fix NAND enumeration on 3430 LDP
Date: Sat, 15 Nov 2014 16:42:17 +0530
Message-ID: <54673511.80205@pek-sem.com>
References: <1415185258-11747-1-git-send-email-rogerq@ti.com> <20141106180333.GZ31454@atomide.com> <545C9267.7060301@ti.com> <545C97AB.4040402@ti.com> <20141107224832.GG31454@atomide.com> <545FC08D.8000008@pek-sem.com> <20141112180253.GJ26481@atomide.com> <54649612.8090402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <54649612.8090402@ti.com>
Sender: stable-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, "Rini, Tom" <trini@ti.com>
Cc: computersforpeace@gmail.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 13 November 2014 04:59 PM, Roger Quadros wrote:
[...]
>
> What about performance impact? OMAP3 doesn't have ELM module. So error location
> for BCH8 has to be done in software.
>

Performance impact happens only when there are bit-flips in an page.
- For BCH8_HW ECC schemes
ELM comes in the picture only when during reads there is an ECC 
mis-match, if there is no ECC mis-match GPMC engine alone handles all 
the decoding part.

- For BCH8_SW ECC schemes
Same-way, lib/bch.8: decode_bch() path is taken only when ECC mismatch 
is detected on the read path, for normal read/write GPMC engine handles 
everything.

Yes, you may argue that with aging of the NAND the occurrence of 
bit-flips is common. That's true, but for new devices especially for SLC 
NAND the occurrence is usually rare on fresh parts. Also considering 
that most SLC are now manufactured in matured technologies.

Also, if you are using UBIFS on top of NAND, then it will scrub the data 
on first detection of bit-flips, thereby reducing the accumulation of 
bit-flips and thereby conserving read performance.


>>
>>
[...]
>> Right no objections to using BCH8 for rootfs, except it stopped working
>> over past year or so.
>
> This would be BCH8-sw on OMAP3 right? AM3xx uses BCH8-hw and that seems to work fine.
> So it seems nobody has used/tested BCH8-sw.
>
I have tested BCH8_SW on both AM335x and later SoC, and checked its 
compatibility with various combinations of u-boot. [1] should give you 
some indications of various combinations users can try ..


with regards, pekon

[1]
http://processors.wiki.ti.com/index.php/Linux_Core_NAND_User%27s_Guide#ECC_schemes_support


------------------------
Powered by BigRock.com
