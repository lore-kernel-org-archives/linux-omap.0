From: Hari Kanigeri <hari.kanigeri@gmail.com>
Subject: Re: dspbridge and the omapl1x
Date: Wed, 11 Aug 2010 11:55:56 -0500
Message-ID: <AANLkTinyg1+FMLBDgMTpfOK2iy=yzGqsd1XA+xsZ9sse@mail.gmail.com>
References: <AANLkTin7MAdSUmyja5=tp8TP+2mS53++yJT5T6+K27Lp@mail.gmail.com>
	<AANLkTinYLLf4a9p_zFfPZ5s_+-NbNi+zn8UO0G-=i1CK@mail.gmail.com>
	<AANLkTimDnC=BRtdGRGStYj-7XX8ZtehZvY6eK-v-6O5-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44515 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526Ab0HKQz6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 12:55:58 -0400
Received: by ywh1 with SMTP id 1so89896ywh.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 09:55:58 -0700 (PDT)
In-Reply-To: <AANLkTimDnC=BRtdGRGStYj-7XX8ZtehZvY6eK-v-6O5-@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: ErnestoRamos <ernesto@ti.com>, ArmandoUribe <x0095078@ti.com>, NishanthMenon <nm@ti.com>, KulikovVasiliy <segooon@gmail.com>, ReneSapiens <rene.sapiens@ti.com>, AndyShevchenko <andy.shevchenko@gmail.com>, FelipeContreras <felipe.contreras@gmail.com>, OmarRamirezLuna <omar.ramirez@ti.com>, OhadBen-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org

Ben,

> Yes, dynamic memory management. With DSP Link on the OMAPL138 the
> memory allocated to the DSP must be specified as a 'hole' in Linux
> memory at boot-time [1[2][3]. It seems (perhaps this is wishful
> thinking) that dspbridge does not have this limitation.

DSPBridge doesn't has this requirement.

>
> Also dynamic application loading. With DSP Link it is possible to run
> multiple linux processes concurrently communicating with DSP tasks but
> the image loaded and executed on the DSP side must contain the code
> for all of the tasks at load time [4]. It seems that dspbridge does
> not have this limitation.
>
> I am very interested in learning details about both dsplink and
> dspbridge; please reply with more details or corrections as you see
> fit.

DSPBridge and DSPLink IPCs are for 2 different purposes. So before you
make a switch to one of the IPC, I would recommend to you to make sure
your requirements are met.
To check the differences between DSPBridge and DSPLink, please check
this email thread contributed by Richard W.
http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/009850.html.

We are working on making some of core functionalities such as DMM,
resource Management,  reset Management of co-processors generic for
any IPC to use. So if DSPLink is missing DMM functionality then it
should be just the matter of DSPLink adapting to this.

I am not aware of the official word from T.I to support dspbridge on
OMAP1, but as the community you will have the support in case you want
to go with dspbridge option.

On a high level, this is what needs to be done to provide support for OMAP1.

1. Adapt to iommu. Add support if the support is not present for OMAP1.

2. Adapt to mailbox

3. Reset and Power management adaptation for OMAP1.


Thank you,
Best regards,
Hari

>
> Best Regards,
> Ben Gardiner
>
> [1] http://processors.wiki.ti.com/index.php/Changing_DSPLink_Memory_Map
> [2] http://e2e.ti.com/support/dsp/omap_applications_processors/f/42/t/29571.aspx
> [3] http://code.google.com/p/rowboat/wiki/DSP
>
> [4] http://processors.wiki.ti.com/index.php/Using_DSPLink_from_multiple_processes
>
> ---
> Nanometrics Inc.
> http://www.nanometrics.ca
>
