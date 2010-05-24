From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [pm-wip/uart][PATCH 2/6] Serial: Add UART4 hwmod data.
Date: Mon, 24 May 2010 18:26:33 +0530
Message-ID: <AANLkTimdcmNVLsV9G7Fs7wwYQME_HLhCfknsvDTclh8m@mail.gmail.com>
References: <47872.192.168.10.88.1274362704.squirrel@dbdmail.itg.ti.com>
	 <87y6fcerz1.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00c09f93dd40089a7a048756925d
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f183.google.com ([209.85.221.183]:34126 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab0EXM4f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 08:56:35 -0400
Received: by qyk13 with SMTP id 13so5326927qyk.1
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 05:56:34 -0700 (PDT)
In-Reply-To: <87y6fcerz1.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org

--00c09f93dd40089a7a048756925d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This happening because we are missing these patches:

https://patchwork.kernel.org/patch/84748/
https://patchwork.kernel.org/patch/84749/
https://patchwork.kernel.org/patch/84755/
https://patchwork.kernel.org/patch/84750/

Not part of LO yet.

But we need these patches for uart4 support for 3630.

I have rebased the patches on top of wip-uart and tested with 3630SDP.

Attaching the same.

Regards,
Govindraj R


On Sat, May 22, 2010 at 5:18 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Introduce UART4 hwmod data for OMAP3630
>>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> Just FYI...
>
> After adding UART4 to the master list, it hangs on 3630/Zoom3 (log below)
>
> I didn't dig into this one yet.
>
> Kevin
>
> [...]
> Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
> omap_hwmod: uart4: cannot clk_get main_clk uart4_fck
> omap_hwmod: uart4: cannot clk_get interface_clk uart4_ick
> omap_hwmod: l3_hwmod: cannot be enabled (3)
> omap_hwmod: l4_core_hwmod: cannot be enabled (3)
> omap_hwmod: l4_per_hwmod: cannot be enabled (3)
> omap_hwmod: l4_wkup_hwmod: cannot be enabled (3)
> Unhandled fault: external abort on non-linefetch (0x1028) at 0xfb042054
> Internal error: : 1028 [#1] PREEMPT
> last sysfs file:
> Modules linked in:
> CPU: 0 =A0 =A0Not tainted =A0(2.6.34-pm-next-default-10673-g60b93ed #3)
> PC is at omap_hwmod_readl+0x10/0x18
> LR is at _update_sysc_cache+0x44/0x74
> pc : [<c0523adc>] =A0 =A0lr : [<c05240bc>] =A0 =A0psr: a00001d3
> sp : c08c5f10 =A0ip : c08c5f20 =A0fp : c08c5f1c
> r10: 0000001f =A0r9 : 413fc082 =A0r8 : 80028340
> r7 : c08c82cc =A0r6 : c0524c98 =A0r5 : 00000001 =A0r4 : c08dcc2c
> r3 : fb042000 =A0r2 : 00000004 =A0r1 : 00000054 =A0r0 : c08dcc2c
> Flags: NzCv =A0IRQs off =A0FIQs off =A0Mode SVC_32 =A0ISA ARM =A0Segment =
kernel
> Control: 10c5387f =A0Table: 80004019 =A0DAC: 00000017
> Process swapper (pid: 0, stack limit =3D 0xc08c42e8)
> Stack: (0xc08c5f10 to 0xc08c6000)
> 5f00: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 c08c5f34 c08c5f20 c05240bc c0523ad8
> 5f20: 00000000 c08dcc2c c08c5f4c c08c5f38 c0524740 c0524084 00000012 c08d=
cc2c
> 5f40: c08c5f64 c08c5f50 c0524d28 c052463c c08dcc2c 00000000 c08c5f84 c08c=
5f68
> 5f60: c0523e14 c0524ca4 c090ae5c c08e4e30 c08e4e30 c050c014 c08c5f94 c08c=
5f88
> 5f80: c05241d0 c0523df0 c08c5fac c08c5f98 c000e530 c052417c c090a200 c050=
c018
> 5fa0: c08c5fbc c08c5fb0 c0013894 c000e460 c08c5fcc c08c5fc0 c000b438 c001=
386c
> 5fc0: c08c5ff4 c08c5fd0 c0008a6c c000b40c c00086b8 00000000 00000000 c050=
c018
> 5fe0: 10c53c7d c090a5a0 00000000 c08c5ff8 80008034 c0008914 00000000 0000=
0000
> Backtrace:
> [<c0523acc>] (omap_hwmod_readl+0x0/0x18) from [<c05240bc>] (_update_sysc_=
cache+)
> [<c0524078>] (_update_sysc_cache+0x0/0x74) from [<c0524740>] (_enable+0x1=
10/0x1)
> =A0r4:c08dcc2c r3:00000000
> [<c0524630>] (_enable+0x0/0x134) from [<c0524d28>] (_setup+0x90/0x100)
> =A0r4:c08dcc2c r3:00000012
> [<c0524c98>] (_setup+0x0/0x100) from [<c0523e14>] (omap_hwmod_for_each+0x=
30/0x7)
> =A0r5:00000000 r4:c08dcc2c
> [<c0523de4>] (omap_hwmod_for_each+0x0/0x78) from [<c05241d0>] (omap_hwmod=
_late_)
> =A0r6:c050c014 r5:c08e4e30 r4:c08e4e30 r3:c090ae5c
> [<c0524170>] (omap_hwmod_late_init+0x0/0x8c) from [<c000e530>] (omap2_ini=
t_comm)
> [<c000e454>] (omap2_init_common_hw+0x0/0x194) from [<c0013894>] (omap_zoo=
m_init)
> =A0r5:c050c018 r4:c090a200
> [<c0013860>] (omap_zoom_init_irq+0x0/0x50) from [<c000b438>] (init_IRQ+0x=
38/0x4)
> [<c000b400>] (init_IRQ+0x0/0x48) from [<c0008a6c>] (start_kernel+0x164/0x=
2d0)
> [<c0008908>] (start_kernel+0x0/0x2d0) from [<80008034>] (0x80008034)
> =A0r5:c090a5a0 r4:10c53c7d
> Code: e1a0c00d e92dd800 e24cb004 e5903038 (e7910003)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

--00c09f93dd40089a7a048756925d
Content-Type: application/zip; name="rebase_uart4_wip-uart.zip"
Content-Disposition: attachment; filename="rebase_uart4_wip-uart.zip"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9lawccw0

UEsDBBQAAgAIAIqQuDxC/zzHcQIAAAYGAABFAAAAcmViYXNlX3VhcnQ0X3dpcC11YXJ0LzAwMDEt
T01BUDM2MzAtUFJDTS1BZGQtVUFSVDQtY29udHJvbC1iaXRzLnBhdGNojZThb6IwGMY/X/+KN7kv
cwgUWosSc9Fzc1t23Ii43IfLhRRatIuAAbe45P74K3rbdHHOBlIKz/vw0t8TxlWZA8s47nYIEZhw
kYjU7XjC8yiWXUYE7VHWzaRwej0IygIiuQTHA4z9zQEuxg4aaxtfP6pmqoTh7FFVlYR+zfn2crBS
Vlrm39AFX0m/sWmDSyHgz7rcwdrPpz3fZWDgDsEoekweZLry4Xc4nI6uwbHpH7gLhiFhBPsQTkaB
D0Mh4H44mVJIy2JVlQtI1KpGaDpX9eYSuO5BrtPFY62eJJQZlDlfAmHrNWQ8V4vn5l46V8vaQihS
s0IKs8wyM3k+5VPeFVyVT6oQFX+wJtCfvS70yV9LTNNEuqt0bvMqt3Oezs2mJddOc7OSs6Zpk9D1
2prDX9DDBcM4XLCsdIn2zMtCi5uxU+BCphay1p/Gi5kUbaCgilpWK1UW9ZnRagMGIRdyuzZbCAmV
ZWCaM7UCbp/WYHKaDul9kGvghJOUY8vqEpowzwEHY0ZpsyOnvhEZhnHyWwcDMBnttXWimqkLgwGC
r0JmqpDbJFGC42gaB6PvUejGwTC6/aLHmQP9PuAWAgT2OYyCeHg/vbu5+HEZh5cTOLeRseei87hR
xJskvjk43dZRZRxd34ynWu50D/S10V2FN3dsx9FrHVW+OXrHdJ0dR9b6HPx+0JLPNf+Bp6yTuti1
LOERj6Xu58D3XT6Gva9rQFOXNqCb6QPQlz9fQL/sEn4j3NDVSdB82xAG8a/b7QLquf6BiO2v5CB4
rduH2dA8ItsPWRORg5Hcx3mY56vsnad3xLOz48k0CECOxSxiEYT+AVBLAwQUAAIACABSj7g8AalU
tVEDAACnCQAAUgAAAHJlYmFzZV91YXJ0NF93aXAtdWFydC8wMDAyLU9NQVAtY2xvY2stQWRkLXVh
cnQ0X2ljay1mY2stZGVmaW5pdGlvbnMtZm9yLTM2MzAucGF0Y2jNVdtu2zgQfTa/YtCHIIElWRfG
trztIkYubdE4DRwXCFAUAkVSMhtJNCS5cffy7yUp2xFyqY12H9aQIQ7nzHDmnKF9UcocBiwISczi
gUuHZOi5LAliThMesnAQM06wGzKMPR8msoAbvgBvAK47Mg/4ruuhC5VmBON0KcqSw1SyUqRL/pel
0GUqJIyzmJe1hNcVIQ3opBYOlfmf6IzUfASz+dICz4MJKVVGz9X5PTzyhtB11QfdLOOvnNYj+Hw9
np2+A7+Hv8DHyfgaaCbpnTqbMViSssaRoHe9hN4B44koRC1kUUEiSwj6gYvQbC4qUI8ssu/wjWSC
GafMyUIhVitISC6USyZA52JROQjdiLTgzJZJYsffR9uW1s0+09KjgLfymyhYSb46U3idbg31JdsQ
27YRkJLOe6TMezmhc1uX5PdMe8FqtYoYqYlD4R8A8H3oPvtB4EEiMl6p4kmRcmZprCgqxb4m4rB7
ZIGrqMl4Y9tHCDGRJGDbqaiB9PaqId4LhlSjfAUhjcnxcd9xMPFpjBPwXLePsW55z/OQ6mzfM09O
wPaPsWf1oWveXh/UXlWTWlD1Kpe0VjNzZ4YliPSgvIG/EXScklOS0U7nDRwkMsvk/YKUvKijZt9C
8O8fCFD3+Ux4m6nbcQqSc53n1dbzytL7clGZ9CpILSPTQcSSrI7uiagNpDnToBa8jPAw1+HGxQsS
Z1yVkyqvHv3odBJNz9+Oz86mh9oOcOBG1+fTaPLxzALlvDi9/HB+ddSOjkW9jtbXITq/ij6NpzMc
3bx7fzEzQFUcyyPTgupAF2F2mg52cdRVHKkhfMpRuqj9NtlbijYOlR92M2TUHYSNukN3l7riP1NX
vKiu+HV1MxP9i+K+/1+JG7a5bosbrgnaU9wA+64WN8DYtQZPtdVBumazMPdeGdXnL+ujFSeHV58u
L62OaS7s581sdQ5aptU5/RAFt7e3R9bTkPWN24RsLuBLIdtfER2wNdrw7mM4bsPxA7z/NPvD5egc
bNYvlqIAQQsc7ALjFhg/Bjda4KDRoo9/T4t0IaTfDII+bm28WNw9a+6uRm/WOxQQbQXETgVEWwHx
cwXCh8Kb9c9IHbbAw13gQQs8eAxW/47Ic/pO4AQI/QBQSwMEFAACAAgAUo+4PIDVBqVuAwAAMggA
AFUAAAByZWJhc2VfdWFydDRfd2lwLXVhcnQvMDAwMy1PTUFQMy1QUkNNLUNvbnNpZGVyLVVBUlQ0
LWZvci0zNjMwLWNoaXAtaW4tcHJjbV9zZXR1LnBhdGNo1VTvc9pGEP3M/RX7rdhIQr8MRklbUyCO
p1GsAdx6ptPRnKRDXCLpNCcpuG7++O4JTFwMSfqxGhiNbt+92337bt9IkYMb2XRIR1HMqGXGln0R
DSkumfbIcW1r6FCb0csodsAXBSxYCdYQTNNrf2CbpkXeII0H47ThUjKYi0TytGGPGqJlygWMs4jJ
WsDritIt6KrmRizyn8iU1syD5brRwLLApxIZLVPxW65njaBn4kMWTfSBxbUHfwTj5eQtOH33T7j1
x4HjQTCf+B5MRFHxhEm4G8+XLqyEBGfgmBCveQm8gFLGeVixuilDydKKkKWAqqZFQiV/ZEBzUaQg
6jUyNFTWFXQtwIydMw02DKo1zTIoxMYjBHSYFTTKWAt0gTa1SDh+Rrw2XkQ39CNr2gyC2bwNj7NM
bHZRPGEHwJPBD+4MQhY8LViii9VKj/7y9hLuxD0i4cGGa/GJF4mkH4w5vE73H/in+y26rhOgMl73
qcz7OY3XushpaffL3HEfHowYPgM+l9BrH4W2YIVFVigoLVKWaDDAoipsK0fluz3UyYaEZWz7rZ8R
kvDVCnQ95TXQ/lcPi74aJlgBewBGlRUiw3DNeGhGA7BMc+C6qpZv8BMs4VtnXF2BPnQutAH01GsE
uID+qHkMnwRPIAx5gYWoXU6Y2EnIk4x1VeiMADkGPXDcE/Zv0us0jr1lQoeGyj/h1g4/Qlw2Ia/C
p2D3DH7e+lwhx3fL23Drbw/MV4dErPg+mtn7f5EQ6PTP4f7+HuYM0wXl9M3HhJWVgfeSV2h+0WQJ
RAwSUTDYrFkBqkJOM/7IixQJ4BxKsWEywRPRFXDex8VS5uFG8pqFuUiUBl1T22bhYhY3v43t0L+d
ahD44e+/TmfB2au2C5e2pbpwabva8EQXTkjb6Uz8VqSb6bsZsmFfOvFhDqha55j2n9X+fXat1NfB
ze3gVODiVEBRqTpGpqlZLvRGpqve/7GSDnyRChu2I36xtsviCHpwgFYtd46i/ckvi8A+gLeLCq8f
x7uaEvJoBJleeFI7PBen4bPuz96rdikf4kRWDsQJiRMxfxqQgBMSp+MpX+1Zr+fBYvaurd8+otaR
+p/t+E59n+34v2j8ZcUPUcZtBbsLgppPRfED3vu6xrkIeC/xdtdMyqas25uM85VYxsBwDIeQfwBQ
SwMEFAACAAgAk5C4PK16fnyeAgAAQAUAAEkAAAByZWJhc2VfdWFydDRfd2lwLXVhcnQvMDAwNC1v
bWFwMy1zZXJpYWwtRml4LXVhcnQ0LWhhbmRsaW5nLWZvci0zNjMwLnBhdGNorVPbbtpAEH1mv+I8
QsFmfQVMkgbl0kotJQL6UFWVtXjXsMEX5EtC1Pbfu7YRRJGa9KErWzs7M+fMzujsbZbG4NwxbEFt
xxg6o5HpDCgfDFdD6q5caoys4SikZuCIANM0wULsYAxAqVd/MCk1yK2i8VQoW8sUk3Ups0zgLGes
MS8LqQdpfEGuWSG8iqYH08aUPSm4QRWfZ1ueYaBLHYuSRbm6F0Hh4fvdZHn1EXbf/oE0ZjvLQy4y
ySIPt3KPkmWFjQ1LeCSTNcI0g+UqPFluZI4dK4INYrYVOYqNUOEoSh9VokegYcJ5jljmeYV8VEnl
TiE4r46ZWMu8ENmRWq8QqqJiYsqZ8SDlAkWKMhe4u5kjTnkZCcy+fP4GNaOvk/nS0glZyHUiuJaG
obZ6+pf5vAB8SB9kwjN2r89xtj4e1M+OEE3TCFgWbPosi/sxCzZaNSqz30xKD/ALarnoVkvlGghl
pDoJVHdrwXtwIBOVXMg0ydvdTk9lcBGJ5qx1COEyDKFpa1mA9V8ttXo1TNT9xR6cjUIhXF3n7si2
Ri4MSl3brjp5g5+oDt6qcXkJzTbc3gDdZlOOvGCFDPCQSl7ryK+U40seCV8msmjnRVYGxbNQBRB4
V9kdgtazQHxEioStItGu3D3QzphAZcoQ7WBX+jL3a8Ha+32708FPorVapWVWQsE5apB2kZQxzs9h
dvAes+nkzrIt6is5+dPZNTxczeY3lTkm3b+AL2C8iUWDfdz6Mcu3Ck+PPqX3IE3Cg6+ZnOX0lFSq
Tb3L/zC6VutU+XjPxdKvn4g/nSw+1ddpPbvL3hiJxrnKBNvW7QdMvTTLq8yXhO6J0D4Qdl8QUm42
zgOh4v5dD6Ge5InvYI1PsRPLwRormYIYuqtbukXIH1BLAwQKAAAAAAB2kbg8AAAAAAAAAAAAAAAA
FgAAAHJlYmFzZV91YXJ0NF93aXAtdWFydC9QSwECFAAUAAIACACKkLg8Qv88x3ECAAAGBgAARQAk
AAAAAAABACAAAAAAAAAAcmViYXNlX3VhcnQ0X3dpcC11YXJ0LzAwMDEtT01BUDM2MzAtUFJDTS1B
ZGQtVUFSVDQtY29udHJvbC1iaXRzLnBhdGNoCgAgAAAAAAABABgAQJ1fbT37ygEwMOHtP/vKAVDX
53Y++8oBUEsBAhQAFAACAAgAUo+4PAGpVLVRAwAApwkAAFIAJAAAAAAAAQAgAAAA1AIAAHJlYmFz
ZV91YXJ0NF93aXAtdWFydC8wMDAyLU9NQVAtY2xvY2stQWRkLXVhcnQ0X2ljay1mY2stZGVmaW5p
dGlvbnMtZm9yLTM2MzAucGF0Y2gKACAAAAAAAAEAGAAAkpugPPvKAVBI6nY++8oBUEjqdj77ygFQ
SwECFAAUAAIACABSj7g8gNUGpW4DAAAyCAAAVQAkAAAAAAABACAAAACVBgAAcmViYXNlX3VhcnQ0
X3dpcC11YXJ0LzAwMDMtT01BUDMtUFJDTS1Db25zaWRlci1VQVJUNC1mb3ItMzYzMC1jaGlwLWlu
LXByY21fc2V0dS5wYXRjaAoAIAAAAAAAAQAYAEBjqKA8+8oBQAPvdj77ygFAA+92PvvKAVBLAQIU
ABQAAgAIAJOQuDyten58ngIAAEAFAABJACQAAAAAAAEAIAAAAHYKAAByZWJhc2VfdWFydDRfd2lw
LXVhcnQvMDAwNC1vbWFwMy1zZXJpYWwtRml4LXVhcnQ0LWhhbmRsaW5nLWZvci0zNjMwLnBhdGNo
CgAgAAAAAAABABgAgP6PeD37ygFAdPF2PvvKAUB08XY++8oBUEsBAhQACgAAAAAAdpG4PAAAAAAA
AAAAAAAAABYAJAAAAAAAAAAQAAAAew0AAHJlYmFzZV91YXJ0NF93aXAtdWFydC8KACAAAAAAAAEA
GABAdPF2PvvKASBdJQpA+8oBYBzjdj77ygFQSwUGAAAAAAUABQDlAgAArw0AAAAA
--00c09f93dd40089a7a048756925d--
