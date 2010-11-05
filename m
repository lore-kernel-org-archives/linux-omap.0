From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: USB Ethernet gadget seems doesn't work with current mainline
Date: Fri, 5 Nov 2010 11:23:18 +0100
Message-ID: <AANLkTikR_qLtUNsvzbxg0FJwiMQHvJS_+LZWRpRue56=@mail.gmail.com>
References: <AANLkTimeU1+F5F+Bpfh0E3E7S6=aZ=bbK0=6zmpJcm_H@mail.gmail.com>
	<AANLkTinVb5Rf-P+UU5gGVnE8uf=qjiuZDDM4UsfksmN3@mail.gmail.com>
	<AANLkTik7wMEvQODefZ7xRJZct_qExDMDp=hH74VxknOp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:38516 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027Ab0KEKXT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 06:23:19 -0400
In-Reply-To: <AANLkTik7wMEvQODefZ7xRJZct_qExDMDp=hH74VxknOp@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Hi,

2010/11/5 Ming Lei <tom.leiming@gmail.com>:
> 2010/11/5 Grazvydas Ignotas <notasas@gmail.com>:
>> hi,
>>
>> On Fri, Nov 5, 2010 at 10:39 AM, Enric Balletb=C3=B2 i Serra
>> <eballetbo@gmail.com> wrote:
>>> Hello all,
>>>
>>> With current mainline and stable 2.6.35.y branch I've some strange
>>> features with USB ethernet gadget ...
>>>
>>> =C2=A0root@igep0020:~# uname -a
>>> =C2=A0Linux igep0020 2.6.37-rc1+ #1 Fri Nov 5 09:22:53 CET 2010 arm=
v7l
>>> unknown unknown GNU/Linux
>>>
>>> =C2=A0root@igep0020:~# ifconfig
>>> =C2=A0usb0 =C2=A0 =C2=A0 =C2=A0Link encap:Ethernet =C2=A0HWaddr 5A:=
A9:54:25:4C:04
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inet addr:192.168.7.2 =C2=A0Bcast=
:192.168.7.255 =C2=A0Mask:255.255.255.0
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inet6 addr: fe80::58a9:54ff:fe25:=
4c04/64 Scope:Link
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING MULTICAST =C2=
=A0MTU:1500 =C2=A0Metric:1
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:0 errors:0 dropped:0 o=
verruns:0 frame:0
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:28 errors:0 dropped:0 =
overruns:0 carrier:0
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:1000
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:0 (0.0 B) =C2=A0TX bytes=
:4951 (4.8 KiB)
>>>
>>> Pinging seems not work
>>>
>>> =C2=A0root@igep0020:~# ping -c5 192.168.7.1
>>> =C2=A0PING 192.168.7.1 (192.168.7.1): 56 data bytes
>>> =C2=A0--- 192.168.7.1 ping statistics ---
>>> =C2=A05 packets transmitted, 0 packets received, 100% packet loss
>>>
>>> Curiously if I unplug and plug the USB cable, and ping again ...
>>>
>>> =C2=A0root@igep0020:~# ping -c5 192.168.7.1
>>> =C2=A0PING 192.168.7.1 (192.168.7.1): 56 data bytes
>>> =C2=A064 bytes from 192.168.7.1: seq=3D0 ttl=3D64 time=3D0.397 ms
>>> =C2=A064 bytes from 192.168.7.1: seq=3D1 ttl=3D64 time=3D0.489 ms
>>> =C2=A064 bytes from 192.168.7.1: seq=3D2 ttl=3D64 time=3D0.397 ms
>>> =C2=A064 bytes from 192.168.7.1: seq=3D3 ttl=3D64 time=3D0.366 ms
>>> =C2=A064 bytes from 192.168.7.1: seq=3D4 ttl=3D64 time=3D0.396 ms
>>>
>>> =C2=A0--- 192.168.7.1 ping statistics ---
>>> =C2=A05 packets transmitted, 5 packets received, 0% packet loss
>>> =C2=A0round-trip min/avg/max =3D 0.366/0.409/0.489 ms
>>>
>>> Works, anyone knows if the ethernet gadget is broken in current
>>> mainline or have observed this feature ?
>>
>> Please try this patch:
>> http://marc.info/?l=3Dlinux-usb&m=3D128576496614332&w=3D2
>>
>> Report back if it works, maybe then that patch will finally get merg=
ed..
>>
>
> No, the patch is not merged to now.
>
> Felipe, =C2=A0seems it is time to send out this musb bugfix patches.

Thanks, the patch is working for me in mainline on my IGEP's board.

Also the issue is fixed on my linux-2.6.35.y branch applying the patch
and cherry-picking

f11d893de444965dfd3e55f726533ae1df5c6471 usb: musb: support ISO high
bandwidth for gadget mode
b0fca50f5a94a268ed02cfddf44448051ed9343f usb gadget: don't save bind
callback in struct usb_gadget_driver

Cheers,
   Enric
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
