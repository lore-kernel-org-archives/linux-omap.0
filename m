From: Jeroen Hofstee <linux-arm@myspectrum.nl>
Subject: Re: [PATCH] ARM: dts: AM35xx: fix system control module clocks
Date: Sun, 07 Jun 2015 11:41:48 +0200
Message-ID: <557411DC.9020109@myspectrum.nl>
References: <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com> <1433172627-28052-1-git-send-email-t-kristo@ti.com> <556C8ED5.5050000@myspectrum.nl> <20150601173126.GY30984@atomide.com> <alpine.DEB.2.02.1506011733180.14902@utopia.booyaka.com> <5571576E.6020207@myspectrum.nl> <557157FA.7080305@myspectrum.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from orange.myspectrum.nl ([149.210.134.247]:51473 "EHLO
	orange.myspectrum.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbbFGJlv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Jun 2015 05:41:51 -0400
In-Reply-To: <557157FA.7080305@myspectrum.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jeroen Hofstee <jeroen@myspectrum.nl>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Paul,

On 05-06-15 10:04, Jeroen Hofstee wrote:
>
> On 05-06-15 10:01, Jeroen Hofstee wrote:
>>
>> On 01-06-15 19:44, Paul Walmsley wrote:
>>> The best way to make this work IMHO would be for us not to accept 
>>> any new
>>> feature addition patches as long as there are warnings reported in the
>>> test results.  The only real exception that I would foresee is if those
>>> warnings are due to something outside of our control, e.g., a crappy
>>> bootloader, as I suspect the USB_OTG initiator warnings are for the
>>> CM-T3517.
>>>
>>
>> I doubt this is related to the bootloader. I have the suspicion that 
>> is actually
>> a bug in linux but only triggered depending on whether the ROMcode setup
>> the USB OTG or not. Here is some data to backup my statement:
>>

Turns out my suspicion was wrong. This is what I know at the moment,
depending on the bootpins, u-boot will trigger a bad access when loading
a file over ethernet, but only the first time. Clearing the pending 
interrupt
before booting linux make the "USB_OTG address hole seen" go away.

Regards,
Jeroen

U-Boot 2015.04-00098-g487ee34-dirty (Jun 05 2015 - 13:14:48)

AM35XX-GP ES2.0, CPU-OPP2, L3-165MHz, Max CPU Clock 600 Mhz
ccgx + LPDDR/NAND
I2C:   ready
DRAM:  256 MiB
NAND:  512 MiB
MMC:   OMAP SD/MMC: 0
In:    serial
Out:   serial
Err:   serial
Die ID #2276000100000000014e0fb21500b024
Net: DaVinci-EMAC
Hit any key to stop autoboot:  0
ccgx=> echo $clear_l3_int
mw 68004428 0x11000000; mw 6800442C 0x00000000; mw 68004458 0xFFFFFFFF; 
mw 6800445C 0xFFFFFFFF
ccgx=> md 0x68000510 2
68000510: 00000000 00000000                      ........
ccgx=> tftp ccgx/zImage; tftp 80000000 ccgx/am3517-ccgx.dtb;
Using DaVinci-EMAC device
TFTP from server 10.0.0.103; our IP address is 10.0.0.250
Filename 'ccgx/zImage'.
Load address: 0x80300000
Loading: #################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
          ##########
          863.3 KiB/s
done
Bytes transferred = 4040072 (3da588 hex)
Using DaVinci-EMAC device
TFTP from server 10.0.0.103; our IP address is 10.0.0.250
Filename 'ccgx/am3517-ccgx.dtb'.
Load address: 0x80000000
Loading: ###########
          825.2 KiB/s
done
Bytes transferred = 54112 (d360 hex)
ccgx=> md 0x68000510 2
68000510: 04000000 00000000                      ........
ccgx=> run clear_l3_int
ccgx=> md 0x68000510 2
68000510: 00000000 00000000                      ........
ccgx=> boot

# USB_OTG error is gone...

