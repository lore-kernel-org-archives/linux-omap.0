From: Felipe Balbi <balbi@ti.com>
Subject: Re: USB Ethernet gadget seems doesn't work with current mainline
Date: Fri, 5 Nov 2010 14:28:01 +0200
Message-ID: <20101105122801.GB1952@legolas.emea.dhcp.ti.com>
References: <AANLkTimeU1+F5F+Bpfh0E3E7S6=aZ=bbK0=6zmpJcm_H@mail.gmail.com>
 <AANLkTinVb5Rf-P+UU5gGVnE8uf=qjiuZDDM4UsfksmN3@mail.gmail.com>
 <AANLkTik7wMEvQODefZ7xRJZct_qExDMDp=hH74VxknOp@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35935 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284Ab0KEM1h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 08:27:37 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTik7wMEvQODefZ7xRJZct_qExDMDp=hH74VxknOp@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Enric =?iso-8859-1?Q?Balletb=F2?= i Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>

On Fri, Nov 05, 2010 at 05:09:57AM -0500, Ming Lei wrote:
>2010/11/5 Grazvydas Ignotas <notasas@gmail.com>:
>> hi,
>>
>> On Fri, Nov 5, 2010 at 10:39 AM, Enric Balletb=F2 i Serra
>> <eballetbo@gmail.com> wrote:
>>> Hello all,
>>>
>>> With current mainline and stable 2.6.35.y branch I've some strange
>>> features with USB ethernet gadget ...
>>>
>>> =A0root@igep0020:~# uname -a
>>> =A0Linux igep0020 2.6.37-rc1+ #1 Fri Nov 5 09:22:53 CET 2010 armv7l
>>> unknown unknown GNU/Linux
>>>
>>> =A0root@igep0020:~# ifconfig
>>> =A0usb0 =A0 =A0 =A0Link encap:Ethernet =A0HWaddr 5A:A9:54:25:4C:04
>>> =A0 =A0 =A0 =A0 =A0inet addr:192.168.7.2 =A0Bcast:192.168.7.255 =A0=
Mask:255.255.255.0
>>> =A0 =A0 =A0 =A0 =A0inet6 addr: fe80::58a9:54ff:fe25:4c04/64 Scope:L=
ink
>>> =A0 =A0 =A0 =A0 =A0UP BROADCAST RUNNING MULTICAST =A0MTU:1500 =A0Me=
tric:1
>>> =A0 =A0 =A0 =A0 =A0RX packets:0 errors:0 dropped:0 overruns:0 frame=
:0
>>> =A0 =A0 =A0 =A0 =A0TX packets:28 errors:0 dropped:0 overruns:0 carr=
ier:0
>>> =A0 =A0 =A0 =A0 =A0collisions:0 txqueuelen:1000
>>> =A0 =A0 =A0 =A0 =A0RX bytes:0 (0.0 B) =A0TX bytes:4951 (4.8 KiB)
>>>
>>> Pinging seems not work
>>>
>>> =A0root@igep0020:~# ping -c5 192.168.7.1
>>> =A0PING 192.168.7.1 (192.168.7.1): 56 data bytes
>>> =A0--- 192.168.7.1 ping statistics ---
>>> =A05 packets transmitted, 0 packets received, 100% packet loss
>>>
>>> Curiously if I unplug and plug the USB cable, and ping again ...
>>>
>>> =A0root@igep0020:~# ping -c5 192.168.7.1
>>> =A0PING 192.168.7.1 (192.168.7.1): 56 data bytes
>>> =A064 bytes from 192.168.7.1: seq=3D0 ttl=3D64 time=3D0.397 ms
>>> =A064 bytes from 192.168.7.1: seq=3D1 ttl=3D64 time=3D0.489 ms
>>> =A064 bytes from 192.168.7.1: seq=3D2 ttl=3D64 time=3D0.397 ms
>>> =A064 bytes from 192.168.7.1: seq=3D3 ttl=3D64 time=3D0.366 ms
>>> =A064 bytes from 192.168.7.1: seq=3D4 ttl=3D64 time=3D0.396 ms
>>>
>>> =A0--- 192.168.7.1 ping statistics ---
>>> =A05 packets transmitted, 5 packets received, 0% packet loss
>>> =A0round-trip min/avg/max =3D 0.366/0.409/0.489 ms
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
>No, the patch is not merged to now.
>
>Felipe,  seems it is time to send out this musb bugfix patches.

already queued.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
