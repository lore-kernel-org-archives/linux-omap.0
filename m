From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: bluetooth in v4.13-rc1: lock init missing somewhere?
Date: Sun, 23 Jul 2017 20:44:38 +0200
Message-ID: <6609C072-31C4-41DE-986E-D6E9C49CA1DE@holtmann.org>
References: <20170721085551.GA22993@amd>
 <022531FF-11AA-4D6B-A92B-146F5E6BE31F@holtmann.org>
 <20170721111058.GB9448@amd>
 <D0C772B3-4C90-414C-84E5-1DE14054A40A@holtmann.org>
 <20170723082654.GA31857@amd>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170723082654.GA31857@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

>>> I guess output just after boot will be more interesting?
>>> 
>>> root@n900:/my/modules# insmod hci_nokia.ko
>>> root@n900:/my/modules#
>>> Message from syslogd@localhost at Jul 19 12:24:00 ...
>>> kernel:[  174.363037] BUG: rwlock bad magic on CPU#0,
>>> kworker/u3:0/3027, c2665a48
>>> 
>>> root@n900:/my/modules# ../bluez-5.26/tools/btmgmt public-addr
>>> 01:02:03:04:05:06
>>> Set Public Address for hci0 failed with status 0x0b (Rejected)
>>> root@n900:/my/modules# ../bluez-5.26/tools/btmgmt power on
>>> Set Powered for hci0 failed with status 0x11 (Invalid Index)
>>> root@n900:/my/modules#
>> 
>> if you manage to get a recent btmon then it will also decode all the
>> the unknown packets. That would be interesting since it tells you
>> exactly what mgmt sends and what also legacy tools do at any given
>> time.
> 
> Let me try:
> 
> pavel@n900:/my/bluez$ autoconf
> configure.ac:4: error: possibly undefined macro: AM_INIT_AUTOMAKE
>      If this token and others are legitimate, please use m4_pattern_allow.
>      See the Autoconf documentation.
> configure.ac:11: error: possibly undefined macro: AM_MAINTAINER_MODE
> configure.ac:24: error: possibly undefined macro: AM_PROG_CC_C_O
> configure.ac:25: error: possibly undefined macro: AC_PROG_CC_PIE
> configure.ac:32: error: possibly undefined macro: AC_DISABLE_STATIC
> configure.ac:33: error: possibly undefined macro: AC_PROG_LIBTOOL
> configure.ac:41: error: possibly undefined macro: AM_CONDITIONAL
> pavel@n900:/my/bluez$ ./configure 
> ./configure: line 2189: syntax error near unexpected token `foreign'
> ./configure: line 2189: `AM_INIT_AUTOMAKE(foreign subdir-objects color-tests silent-rules'
> pavel@n900:/my/bluez$ 
> 
> automake; autoconf results in less warnings out of autoconf.
> 
> In the end I just deleted the offending line.
> 
> But then it ends here:
> 
> ./configure: line 4043: AM_PROG_CC_C_O: command not found
> ./configure: line 4044: AC_PROG_CC_PIE: command not found
> configure: error: cannot find install-sh, install.sh, or shtool in "."
> "./.." "./../.."
> pavel@n900:/my/bluez$

you have you tried ./bootstrap or ./bootstrap-configure?

>>> While btmon says:
>>> 
>>> ...begining of buffer lost :-(
>> 
>> I really need to find my patches for the monitor ring-buffer and
>> replay support so that you can keep these in kernel memory and
>> configure this with a kernel cmdline option. In theory however
>> starting btmon before insmod should be plenty to get the full
>> trace.
> 
> That was my fault, not kernel fault. I just relied on scrollback
> buffer, and it was not big enough.
> 
>> 
>> Actually I just realize that this is special anyway. Since this is Nokia manufacture ID, but Broadcom vendor decoding. I think that we need to add some special handling for this to make sure user space is able to decode this properly.
>> 
> 
> Aha. Ok, I guess I can test out the patches... if I manage to compile
> it. Adding a hint how to compile from git (-> configure not present)
> would be nice.

you can hack btmon to treat Nokia ID 2 as Broadcom ID 15 and then you would see the decoding.

>> While we do this the btbcm_set_bdaddr might be actually empty.
>> 
>> config BT_HCIUART_NOKIA                                                          
>>        tristate "UART Nokia H4+ protocol support"                               
>>        depends on BT_HCIUART                                                    
>>        depends on BT_HCIUART_SERDEV                                             
>>        depends on PM                                                            
>>        select BT_HCIUART_H4                                                     
>> 
>> This is missing the select BT_BCM like what we have for the hci_bcm.c support.
>> 
>> config BT_HCIUART_BCM                                                            
>>        bool "Broadcom protocol support"                                         
>>        depends on BT_HCIUART                                                    
>>        select BT_HCIUART_H4                                                     
>>        select BT_BCM
>> 
>> Can you try to enable btbcm.ko module and load that first.
> 
> Actually, I guess I can just make it build-in. But I'm not sure how it
> is supposed to help: I'd expect undefined symbols on broken
> dependency, not silent failure.

The helper modules are designed to be selected. So they fail gracefully if not. So this is just a bug. Make sure to have btbcm built-in or btbcm.ko available.

Regards

Marcel
