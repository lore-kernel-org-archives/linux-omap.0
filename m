From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: 2430SDP booting problem with the latest git
Date: Fri, 9 May 2008 16:46:17 +0200
Message-ID: <82523908-9B09-42C1-8393-181C463503B1@student.utwente.nl>
References: <c656a4d20805090613l1ecf4201m4385bb4ee75e9d90@mail.gmail.com> <30da4de7f0df635e44381efc88211bb4@felipebalbi.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:38133 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbYEIOv7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2008 10:51:59 -0400
In-Reply-To: <30da4de7f0df635e44381efc88211bb4@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 9 mei 2008, om 15:42 heeft Felipe Balbi het volgende geschreven:
>
>
> On Fri, 9 May 2008 18:43:40 +0530, "arun c"

<snip>

>> TWL4030 GPIO Demux: IRQ Range 384 to 402, Initialization Failed
>> omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
>> omapflash.0: Found 1 x16 devices at 0x2000000 in 16-bit bank
>> Intel/Sharp Extended Query Table at 0x010A
>> Intel/Sharp Extended Query Table at 0x010A
>> Intel/Sharp Extended Query Table at 0x010A
>> Intel/Sharp Extended Query Table at 0x010A
>> Intel/Sharp Extended Query Table at 0x010A
>> Intel/Sharp Extended Query Table at 0x010A
>> Using buffer write method
>> Using auto-unlock on power-up/resume
>> cfi_cmdset_0001: Erase suspend on write enabled
>> OMAP2 OneNAND driver initializing
>> input: omap_twl4030keypad as /class/input/input0
>> omap_twl4030keypad omap_twl4030keypad: Could not write TWL4030: 0 -
>> ret -121[ff]OMAP Watchdog Timer Rev 0x22: initial timeout 60 sec
>> mmci-omap: probe of mmci-omap.1 failed with error -22
>
> Besides the omapfb, this took my attention as well.
> MMC is failing on 2430sdp, could anyone take a look at it ?

Lots of TWL related stuff is failing (from log above):

>> TWL4030 GPIO Demux: IRQ Range 384 to 402, Initialization Failed

>> omap_twl4030keypad omap_twl4030keypad: Could not write TWL4030: 0 -

So the mmc problem might be the twl acting up: http://thread.gmane.org/gmane.linux.ports.arm.omap/8173

regards,

Koen




>
>
>> TCP cubic registered
>> NET: Registered protocol family 17
>> NET: Registered protocol family 15
>> RPC: Registered udp transport module.
>> RPC: Registered tcp transport module.
>> Power Management for OMAP2 initializing
>> PRCM revision 1.0
>> eth0: link up
>> Sending DHCP requests ., OK
>> IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.13.153
>> IP-Config: Complete:
>>     device=eth0, addr=192.168.13.153, mask=255.255.255.0,
>> gw=192.168.13.188,
>>     host=192.168.13.153, domain=, nis-domain=(none),
>>     bootserver=0.0.0.0, rootserver=192.168.10.135, rootpath=
>> Looking up port of RPC 100003/2 on 192.168.10.135
>> ###########################################
>>
>> Regards,
>> Arun C
>
> --  
> Best Regards,
>
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIJGO7MkyGM64RGpERArnUAJ9IZCnp3dMFr8c8glPATMs0ZnCPpQCgrkys
XMdm6x3WbJYwJsEHq99iwa4=
=3M2b
-----END PGP SIGNATURE-----
