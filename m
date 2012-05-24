From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: MFD USB host: prevents CORE retention in idle
Date: Thu, 24 May 2012 12:35:35 +0530
Message-ID: <CAP05o4KNnrKdmgJ=Ky=MS4pwEoEErH+Agkm2EwN1i1UDb-CbPQ@mail.gmail.com>
References: <87zk8yxx9l.fsf@ti.com>
	<4FBD7FDC.9050307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:55020 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750721Ab2EXHFg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 May 2012 03:05:36 -0400
Received: by obfk16 with SMTP id k16so16510608obf.30
        for <linux-omap@vger.kernel.org>; Thu, 24 May 2012 00:05:35 -0700 (PDT)
In-Reply-To: <4FBD7FDC.9050307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Thu, May 24, 2012 at 5:55 AM, Kevin Hilman <khilman@ti.com> wrote:
> On 05/23/2012 05:01 PM, Kevin Hilman wrote:
>>
>> Hi Keshava,
>>
>> Using current l-o master, I noticed that CORE was not hitting retent=
ion
>> in idle on my 3530/Overo. =A0CORE hits retention on suspend just fin=
e.
>>
>> Debugging this, I found that usbtll_fck was still enabled during idl=
e,
>> thus preventing CORE from hitting retention.
>>
>> To test, I disabled USB host (CONFIG_MFD_OMAP_USB_HOST=3Dn in .confi=
g) and
>> was then started seeing CORE hit retention in idle again.
>>
>> I have nothing plugged into the USB host port on this board, so I
>> would've expected that runtime PM would've kicked in and shutdown th=
is
>> clock.
>>
>> Any ideas what's going on here? =A0Is this expected behavior?
>>
>
> If it helps, attached is a bootlog after enabling debug for
> mfd/omap-usb-host.c as well. =A0Notice there's a couple of clock-rela=
ted
> warnings from this driver as well. =A0Not sure if they're relevant:
>
> usbhs_omap: alias fck already exists
> usbhs_omap usbhs_omap: xclk60mhsp2_ck set parentfailed error:-22

these clocks were specific to omap4 and it should not cause any
problem to omap3 boards.

I will try to reproduce this on 3430 sdp to explore further.


>
> With debug enabled, I see the runtime resume during init followed by =
the
> runtime suspend.
>
> [ =A0 =A00.936248] usbhs_omap usbhs_omap: xclk60mhsp2_ck set parentfa=
iled
> error:-22
> [ =A0 =A00.944152] usbhs_omap usbhs_omap: starting TI HSUSB Controlle=
r
> [ =A0 =A00.944335] usbhs_omap usbhs_omap: usbhs_runtime_resume
> [ =A0 =A00.944641] usbhs_omap usbhs_omap: OMAP UHH_REVISION 0x10
> [ =A0 =A00.944641] usbhs_omap usbhs_omap: OMAP3 ES version > ES2.1
> [ =A0 =A00.944671] usbhs_omap usbhs_omap: UHH setup done,ry
> uhh_hostconfig=3D8000121d
> [ =A0 =A00.947082] usbhs_omap usbhs_omap: usbhs_runtime_suspend
>
> However, later in the boot I see a runtime_resume and never see anoth=
er
> suspend. =A0That seems to be the root cause of CORE not hitting reten=
tion.
>
> From the boot log:
>
> [ =A0 =A02.018707] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI=
) Driver
> [ =A0 =A02.025787] ehci_hcd: block sizes: qh 64 qtd 96 itd 160 sitd 9=
6
> [ =A0 =A02.026306] ehci-omap ehci-omap.0: failed to get ehci port1 re=
gulator
> [ =A0 =A02.026519] usbhs_omap usbhs_omap: usbhs_runtime_resume
> [ =A0 =A03.030639] ehci-omap ehci-omap.0: phy reset operation timed o=
ut
> [ =A0 =A03.030700] ehci-omap ehci-omap.0: reset hcs_params 0x1313 dbg=
=3D0 cc=3D1
> pcc=3D3 ordered ports=3D3
> [ =A0 =A03.030731] ehci-omap ehci-omap.0: reset hcc_params 0016 thres=
h 1 uframes
> 256/512/1024 park
> [ =A0 =A03.030761] ehci-omap ehci-omap.0: reset command 0080b02 =A0pa=
rk=3D3
> ithresh=3D8 period=3D1024 Reset HALT
> [ =A0 =A03.030792] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
>
> Since the only get/puts I see are in omap_usbhs_init(), I'm not sure =
how
> this driver is being runtime resumed. =A0Presumably it's due to how t=
he rest
> of the USB stack works, which I'm not at all familiar with.
>
> Hopefully, the above is enough to debug the problem,
>
> Thanks,
>
> Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
