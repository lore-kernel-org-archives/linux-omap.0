From: Nishanth Menon <nm@ti.com>
Subject: Re: [OMAP 1710] Mainline Broken
Date: Fri, 17 Dec 2010 06:52:31 -0600
Message-ID: <4D0B5D0F.9030403@ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB037395C74E@dbde02.ent.ti.com>	<AANLkTi=Shtqm36=_zSa37Fgan9NJYX3oKvoZzN35mi98@mail.gmail.com> <87r5dhfxwh.fsf@deeprootsystems.com> <5A47E75E594F054BAF48C5E4FC4B92AB0373A9363D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:53212 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753933Ab0LQMwl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 07:52:41 -0500
Received: by ywi6 with SMTP id 6so296862ywi.20
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 04:52:38 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0373A9363D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Belisko Marek <marek.belisko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

DebBarma, Tarun Kanti had written, on 12/17/2010 02:22 AM, the following:
>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> Sent: Thursday, December 16, 2010 10:39 PM
>> To: Belisko Marek
>> Cc: DebBarma, Tarun Kanti; linux-omap@vger.kernel.org
>> Subject: Re: [OMAP 1710] Mainline Broken
>>
>> Belisko Marek <marek.belisko@gmail.com> writes:
>>
>>> Hi,
>>>
>>> On Thu, Dec 16, 2010 at 4:30 PM, DebBarma, Tarun Kanti
>>> <tarun.kanti@ti.com> wrote:
>>>> Did anyone observe this? I am using omap_generic_1710_defconfig
>>>>
>>>> [...]
>>>> input: omap-keypad as /devices/platform/omap-keypad/input/input0
>>>> TCP cubic registered
>>>> NET: Registered protocol family 17
>>>> Registering the dns_resolver key type
>>>> eth0: link up
>>>> IP-Config: Complete:
>>>>     device=eth0, addr=172.24.191.106, mask=255.255.252.0,
>> gw=172.24.188.1,
>>>>     host=myomap, domain=, nis-domain=(none),
>>>>     bootserver=172.24.191.66, rootserver=172.24.191.66, rootpath=
>>>> VFS: Mounted root (nfs filesystem) on device 0:10.
>>>> Freeing init memory: 128K
>>>> Kernel panic - not syncing: Attempted to kill init!
>>> Seems your userspace is broken. Try add user_debug=31 to command line
>>> to see what exactly happens.
>> Looks like you're mounting an NFS rootfs.  Was it compiled for armv5?
>> My hunch would be you're trying to run an armv6/armv7 userspace on the
>> 1710 which is armv5.
>>
>> To get more debugging, ensure these are enabled in your defconfig:
>>
>> CONFIG_DEBUG_BUGVERBOSE=y
>> CONFIG_DEBUG_USER=y
>> CONFIG_DEBUG_ERRORS=y
>>
>> and in addition to cmdline suggested by Marek, add user_debug=0xf
>>
>> This will give verbose output for userspace exceptions as well and
>> possibly confirm my hunch.
>>
>> Kevin
> 
> I checked .config and it shows: CONFIG_CPU_32v5=y
> 
> With regard to additional log here they are!!
> 
> [...]
> [1] init: obsolete system call 00000000.
> Code: e08f1001 e1a0c000 e3a0702d ef000000 (e3700a01)
> Kernel panic - not syncing: Attempted to kill init!
> Backtrace:
> [...]
I wonder if the age old
http://linux.omap.com/pub/documentation/Howto_build_Linux_on_H3.pdf
and
http://linux.omap.com/pub/filesystem/ might help?


-- 
Regards,
Nishanth Menon
