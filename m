From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: omapfb: no driver for display
Date: Sat, 19 Feb 2011 15:41:05 +0800
Message-ID: <AANLkTik_H0vAEjB8tOyJNC4oDS1+Tp5ick0mq4jhhqMV@mail.gmail.com>
References: <AANLkTi=f=SKE=QR97ttPnBrpW=2wNGd03+q4agmu6Uap@mail.gmail.com>
	<AANLkTikpCcpkjb8i_8Gk5ey1FtgsaUenmKNDhrtjLqon@mail.gmail.com>
	<AANLkTinoLOyqBCMNKbpcJMhZHnncX1T07nbfsTThA_a4@mail.gmail.com>
	<4D5DF547.7010703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:59323 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab1BSHlG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Feb 2011 02:41:06 -0500
Received: by yib18 with SMTP id 18so1928925yib.19
        for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 23:41:06 -0800 (PST)
In-Reply-To: <4D5DF547.7010703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit taneja <archit@ti.com>
Cc: Sung Hee Park <shpark7@stanford.edu>, Bryan Wu <bryan.wu@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>

Hi,

2011/2/18 archit taneja <archit@ti.com>:
> Hi,
>
> On Friday 18 February 2011 09:46 AM, Sung Hee Park wrote:
>>
>> Bryan,
>>
>> I've already tried that patch but didn't work. The omapdss is not
>> showing any error message, but omapfb still does.
>>
>> Thanks,
>> Sung Hee
>>
>> On Thu, Feb 17, 2011 at 7:46 PM, Bryan Wu<bryan.wu@canonical.com> =A0=
wrote:
>>>
>>> Sung Hee,
>>>
>>> Could you please try the patch I forwarded to L-O yesterday?
>>> https://patchwork.kernel.org/patch/569501/
>>>
>>> Thanks,
>>> -Bryan
>>>
>>> On Fri, Feb 18, 2011 at 11:17 AM, Sung Hee Park<shpark7@stanford.ed=
u>
>>> =A0wrote:
>>>>
>>>> Hi,
>>>>
>>>> I found my frame buffer is not working while I'm testing the linux
>>>> kernel 2.6.38-rc5 on omap3evm, which used to work fine with 2.6.37=
=2E
>>>>
>>>> Kernel command line: mem=3D128M console=3DttyO0,115200n8 noinitrd =
rw
>>>> root=3D/dev/mmcblk0p2 rootfstype=3Dext3 rootwait omapfb.rot
>>>> ate=3D3 omapfb.vrfb=3Dy vram=3D8M earlyprintk=3Dserial,uart0,11520=
0n8
>>>> omapdss.debug=3D1 omapfb.debug=3D1
>>>> OMAPFB: omapfb_init
>>>> OMAPFB: omapfb_probe
>>>> omapfb omapfb: no driver for display
>>>> omapfb omapfb: failed to setup omapfb
>
> It looks like an issue with what you have selected in the menuconfig.=
 Could
> you ensure you have DPI and VENC selected, and in displays Generic DP=
I panel
> and sharp-ls panel selected.

Even after enabling all this options above, there is still the failure
message on my pandaboard(2.6.38-rc5-next-20110217):

[    0.000000] Kernel command line: console=3DttyO2,115200n8 vram=3D16M
root=3D/dev/mmcblk0p2 rw earlyprintk rootfstype=3Dext3 rootwait
=2E.....
[    2.847625] omapfb omapfb: no displays
[    2.851562] omapfb omapfb: failed to setup omapfb
[    2.856719] omapfb: probe of omapfb failed with error -22


thanks,
--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
