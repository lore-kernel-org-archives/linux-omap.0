From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: Oops on ehci_hcd when booting 3.0.0-rc2 on panda
Date: Tue, 9 Aug 2011 22:19:30 +0530
Message-ID: <CAP05o4KqzddgNXouGjT6GbSA=B81+DPR2rm4jVDm1VLW2Ua1=Q@mail.gmail.com>
References: <1307356643.23002.413.camel@cumari>
	<20110606104417.GP18731@legolas.emea.dhcp.ti.com>
	<20110606110218.GS18731@legolas.emea.dhcp.ti.com>
	<1307358348.23002.419.camel@cumari>
	<1312889168.2407.148.camel@cumari>
	<20110809144739.GZ32212@legolas.emea.dhcp.ti.com>
	<CAP05o4LyyjXFHyoug1d-CDS_S2VdEgngT-X4iQ8jwbOJ1S42dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAP05o4LyyjXFHyoug1d-CDS_S2VdEgngT-X4iQ8jwbOJ1S42dg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 9, 2011 at 8:30 PM, Munegowda, Keshava
<keshava_mgowda-l0cyMroinI0@public.gmane.org> wrote:
> yes! I have started this.
>
> regards
> keshava
>
>
> On Tue, Aug 9, 2011 at 8:17 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
>> Hi,
>>
>> Keshava this one is for you (sorry for the top-post)
>>
>> On Tue, Aug 09, 2011 at 02:26:08PM +0300, Luciano Coelho wrote:
>>> Hi,
>>>
>>> On Mon, 2011-06-06 at 14:05 +0300, Luciano Coelho wrote:
>>> > On Mon, 2011-06-06 at 14:02 +0300, Felipe Balbi wrote:
>>> > > On Mon, Jun 06, 2011 at 01:44:18PM +0300, Felipe Balbi wrote:
>>> > > > looks like this is resulting from the missing hwmod conversio=
n in
>>> > > > mainlnie. Check if reverting 7e6502d577106fb5b202bbaac64c5f1b=
065e6daa
>>> > > > helps.
>>> > >
>>> > > I verified off-list with Luca that reverting that commit does m=
ake it
>>> > > work. Keshava, care to send a revert patch to Sam until we get =
all the
>>> > > hwmod stuff in.
>>> >
>>> > Yes, I confirm that I'm not getting the oops anymore, after rever=
ting
>>> > this patch.
>>> >
>>> > Thanks a lot for the quick answer, dude! :)
>>>
>>> I'm again getting a very similar oops with 3.1-rc1 on my pandaboard=
:
>>>
>>> [ =A0 =A02.054351] usbcore: registered new interface driver cdc_ncm
>>> [ =A0 =A02.061431] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EH=
CI) Driver
>>> [ =A0 =A02.068664] Unhandled fault: imprecise external abort (0x140=
6) at 0x00000000
>>> [ =A0 =A02.076110] Internal error: : 1406 [#1] SMP
>>> [ =A0 =A02.080505] Modules linked in:
>>> [ =A0 =A02.083709] CPU: 0 =A0 =A0Not tainted =A0(3.1.0-rc1-wl+ #283=
)
>>> [ =A0 =A02.089233] PC is at omap_usbhs_enable+0x148/0x590
>>> [ =A0 =A02.094299] LR is at trace_hardirqs_off+0x14/0x18
>>> [ =A0 =A02.099243] pc : [<c02a8640>] =A0 =A0lr : [<c007fea0>] =A0 =A0=
psr: 60000093
>>> [ =A0 =A02.099243] sp : df871dc8 =A0ip : df871d80 =A0fp : df871dec
>>> [ =A0 =A02.111328] r10: 80000013 =A0r9 : df9ef9e0 =A0r8 : df9ef9ec
>>> [ =A0 =A02.116821] r7 : dfa32800 =A0r6 : dfa316f8 =A0r5 : c06f5da8 =
=A0r4 : dfa316a0
>>> [ =A0 =A02.123687] r3 : 00000000 =A0r2 : 00000000 =A0r1 : 00000001 =
=A0r0 : 00000000
>>> [ =A0 =A02.130584] Flags: nZCv =A0IRQs off =A0FIQs on =A0Mode SVC_3=
2 =A0ISA ARM =A0Segment kernel
>>> [ =A0 =A02.138366] Control: 10c53c7d =A0Table: 8000404a =A0DAC: 000=
00015
>>> [ =A0 =A02.144409] Process swapper (pid: 1, stack limit =3D 0xdf870=
2f8)
>>> [ =A0 =A02.150543] Stack: (0xdf871dc8 to 0xdf872000)
>>> [ =A0 =A02.155120] 1dc0: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 df1054=
00 dfa32808 df105400 dfa32800 df9ef9ec 00000003
>>> [ =A0 =A02.163726] 1de0: df871e8c df871df0 c0321d60 c02a8504 df871e=
2c df10a588 df1075a0 df10a588
>>> [ =A0 =A02.172363] 1e00: df871e2c df871e10 df10a588 00000000 df10a6=
08 dfa28e88 0000006d fc064c00
>>> [ =A0 =A02.180969] 1e20: df871e6c df871e30 c015654c c0155c08 c00820=
98 c0071f74 00000001 dfa32898
>>> [ =A0 =A02.189575] 1e40: dfa28e88 00000000 dfa32808 dfa32810 000000=
00 00000000 73757368 00003062
>>> [ =A0 =A02.198181] 1e60: df871e7c dfa32808 c0716da8 c0716da8 000000=
00 00000000 00000000 00000000
>>> [ =A0 =A02.206787] 1e80: df871e9c df871e90 c0298cfc c0321bb8 df871e=
c4 df871ea0 c0297650 c0298ce4
>>> [ =A0 =A02.215423] 1ea0: df871ec4 dfa32808 dfa3283c dfa32808 dfa328=
3c c0716da8 df871ee4 df871ec8
>>> [ =A0 =A02.224029] 1ec0: c02977ec c0297504 00000000 c0716da8 c02977=
74 00000000 df871f0c df871ee8
>>> [ =A0 =A02.232635] 1ee0: c0296c00 c0297780 df891658 dfa31670 c023ac=
60 c0716da8 df1075a0 c070d6f8
>>> [ =A0 =A02.241241] 1f00: df871f1c df871f10 c0297334 c0296bb0 df871f=
4c df871f20 c02963ec c0297318
>>> [ =A0 =A02.249847] 1f20: c05b84a8 df871f30 c0716da8 c0c7e4c0 c0014b=
a0 00000000 00000000 00000000
>>> [ =A0 =A02.258483] 1f40: df871f74 df871f50 c0297f00 c0296320 c0298d=
44 c0c7df14 c0c7e4c0 c0014ba0
>>> [ =A0 =A02.267089] 1f60: 00000000 00000000 df871f84 df871f78 c02991=
e0 c0297e54 df871fa4 df871f88
>>> [ =A0 =A02.275695] 1f80: c069904c c0299198 000000a0 00000060 c06c4e=
40 c0698fa4 df871fdc df871fa8
>>> [ =A0 =A02.284301] 1fa0: c0008854 c0698fb0 c0014ba0 c009960c df871f=
dc df871fc0 c06c4e40 c06c49dc
>>> [ =A0 =A02.292907] 1fc0: c0014ba0 00000013 00000000 00000000 df871f=
f4 df871fe0 c06792d4 c00087b8
>>> [ =A0 =A02.301513] 1fe0: 00000000 c067924c 00000000 df871ff8 c0014b=
a0 c0679258 882bf20f 3184000e
>>> [ =A0 =A02.310150] [<c02a8640>] (omap_usbhs_enable+0x148/0x590) fro=
m [<c0321d60>] (ehci_hcd_omap_probe+0x1b4/0x568)
>>> [ =A0 =A02.320526] [<c0321d60>] (ehci_hcd_omap_probe+0x1b4/0x568) f=
rom [<c0298cfc>] (platform_drv_probe+0x24/0x28)
>>> [ =A0 =A02.330780] [<c0298cfc>] (platform_drv_probe+0x24/0x28) from=
 [<c0297650>] (driver_probe_device+0x158/0x27c)
>>> [ =A0 =A02.341033] [<c0297650>] (driver_probe_device+0x158/0x27c) f=
rom [<c02977ec>] (__driver_attach+0x78/0x9c)
>>> [ =A0 =A02.351043] [<c02977ec>] (__driver_attach+0x78/0x9c) from [<=
c0296c00>] (bus_for_each_dev+0x5c/0x8c)
>>> [ =A0 =A02.360565] [<c0296c00>] (bus_for_each_dev+0x5c/0x8c) from [=
<c0297334>] (driver_attach+0x28/0x30)
>>> [ =A0 =A02.369903] [<c0297334>] (driver_attach+0x28/0x30) from [<c0=
2963ec>] (bus_add_driver+0xd8/0x260)
>>> [ =A0 =A02.379180] [<c02963ec>] (bus_add_driver+0xd8/0x260) from [<=
c0297f00>] (driver_register+0xb8/0x144)
>>> [ =A0 =A02.388702] [<c0297f00>] (driver_register+0xb8/0x144) from [=
<c02991e0>] (platform_driver_register+0x54/0x68)
>>> [ =A0 =A02.399047] [<c02991e0>] (platform_driver_register+0x54/0x68=
) from [<c069904c>] (ehci_hcd_init+0xa8/0xfc)
>>> [ =A0 =A02.409149] [<c069904c>] (ehci_hcd_init+0xa8/0xfc) from [<c0=
008854>] (do_one_initcall+0xa8/0x17c)
>>> [ =A0 =A02.418487] [<c0008854>] (do_one_initcall+0xa8/0x17c) from [=
<c06792d4>] (kernel_init+0x88/0x134)
>>> [ =A0 =A02.427764] [<c06792d4>] (kernel_init+0x88/0x134) from [<c00=
14ba0>] (kernel_thread_exit+0x0/0x8)
>>> [ =A0 =A02.437011] Code: e59f0414 e1a01005 e59f2424 ebffac8d (e5943=
03c)
>>>
>>> This seems to be very similar (if not identical) to the oops I was
>>> getting before (with 3.0-rc2). =A0I checked the git log and the rev=
ert
>>> that fixed my problem with 3.0-rc2 is now included in 3.1-rc1, so i=
t
>>> seems that something else is broken now.
>>>
>>> I tried to revert the revert, with the idea that maybe the hwmod ch=
anges
>>> were also included in 3.1-rc1, but it didn't help and I'm still get=
ting
>>> a similar oops.
>>>
>>> Any clues?
>>>
>>> --
>>> Cheers,
>>> Luca.
>>>
>>
>> --
>> balbi
>>

I not seeing this issue in 4430 sdp with 3.1-rc1( but there are random
oops not because of usbhs).
I will try the same thing in omap4 panda and update.

keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
