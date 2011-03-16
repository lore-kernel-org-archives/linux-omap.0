From: Stephan Raue <mailinglists@openelec.tv>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Thu, 17 Mar 2011 00:49:06 +0100
Message-ID: <4D814C72.9010300@openelec.tv>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com> <1299764643.2017.177.camel@deskari> <4D78E3F5.2090600@openelec.tv> <1299827578.2567.1.camel@deskari> <4D79E0A0.9040900@openelec.tv> <1299849774.2479.3.camel@deskari> <4D7A4B44.2030801@openelec.tv> <1299868049.2479.33.camel@deskari> <4D7A6D0F.40906@openelec.tv> <AANLkTin+fnZfFte5v8+G0saDcjCqsT=oQ4U_oGSm-UGn@mail.gmail.com> <4D7CD588.3080100@openelec.tv> <4D7CEEC8.50803@openelec.tv> <1300258302.1917.32.camel@lappyti> <AANLkTinNynOpnJyHZeyA01E5oVMcs_PnAYRH4dSznJ_d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail01.solnet.ch ([212.101.4.135]:64285 "EHLO mail01.solnet.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765Ab1CPXtK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 19:49:10 -0400
In-Reply-To: <AANLkTinNynOpnJyHZeyA01E5oVMcs_PnAYRH4dSznJ_d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Am 16.03.2011 11:53, schrieb K, Mythri P:
> Hi Tomi,
>
> On Wed, Mar 16, 2011 at 12:21 PM, Tomi Valkeinen<tomi.valkeinen@ti.com>  wrote:
>> On Sun, 2011-03-13 at 11:20 -0500, Stephan Raue wrote:
>>> Am 13.03.2011 15:32, schrieb Stephan Raue:
>> <snip>
>>
>>>> i have tried this omap2plus defconfig now too, with some little
>>>> changes needed to boot my system (config:
>>>> http://paste.pocoo.org/show/352917/). Now i get this error (see also:
>>>> http://paste.pocoo.org/show/352915/)
>>>>
>>>> [    3.255065] omapdss HDMI: fallback to VGA
>>>> [    3.271636] omapdss HDMI error: Failed to set PHY_PWR_STATUS
>>>> [    3.277587] omapdss HDMI error: failed to power on device
>>>> [    3.283325] omapdss error: failed to power on
>>>> [    3.287902] omapfb omapfb: Failed to enable display 'hdmi'
>>>> [    3.293853] Console: switching to colour dummy device 80x30
>>>> [    3.304595] omapfb omapfb: failed to setup omapfb
>>>> [    3.309539] omapfb: probe of omapfb failed with error -5
>>> using omap2plus defconfig with my little changes i need to boot my
>>> system i get the error above, also if i remove CONFIG_ARCH_OMAP2. but if
>>> i remove CONFIG_ARCH_OMAP3 too i get the error i reported originally
>>> (the kernel begins to boot, but crashes) (diff between omap2plus
>>> defconfig without CONFIG_ARCH_OMAP2 and omap2plus defconfig without
>>> CONFIG_ARCH_OMAP2, CONFIG_ARCH_OMAP3: http://paste.pocoo.org/show/352960/)
>> I'm currently traveling for this week so I have quite limited ability to
>> test this. Mythri still haven't been able to reproduce any of these
>> errors, right?
>>
> That's right i have not been able to reproduce the error.  I have
> tried with 4 Panda Boards with atleast 4  - 5 Montiors connected (
> Also without connecting any monitor).
>
>> Anybody else there to test HDMI on Panda and/or Blaze? I pushed the
>> latest DSS + HDMI patches to a test branch for easier testing (I'll push
>> Panda DVI patches there also when I get the new version):
>>
>> git://gitorious.org/linux-omap-dss2/linux.git test
> Stephan,
> It would be great if you could try out with this tree with omap2plus_defconfig.
> Note : Please disable VENC , there is a known issue of kernel crash
> with VENC enabled.
>
> Thanks and regards,
> Mythri.
Hi,

i tried this test tree with omap2plus_defconfig.

it seems the kernel crashes and poweroff the board on loading this hdmi 
stuff, but dont print any crashlog. is there a way any backtraces will 
be printed?
output from serial console: http://paste.pocoo.org/show/354850/
kernel config (omap2plus_defconfig, added squashfs support, added 
support to include initramfs in kernel, build omapfb stuff statically 
into the kernel): http://paste.pocoo.org/show/354853/

i am using a own toolchain to crosscompile with gcc-4.5.2, binutils-2.21...

Stephan
