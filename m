From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: dspbridge and the omapl1x
Date: Wed, 11 Aug 2010 11:10:16 -0400
Message-ID: <AANLkTinuQsE8x3PSrqgXFr95CjQiTrW9S7GqmL+Sf82k@mail.gmail.com>
References: <AANLkTin7MAdSUmyja5=tp8TP+2mS53++yJT5T6+K27Lp@mail.gmail.com>
	<AANLkTinYLLf4a9p_zFfPZ5s_+-NbNi+zn8UO0G-=i1CK@mail.gmail.com>
	<AANLkTimDnC=BRtdGRGStYj-7XX8ZtehZvY6eK-v-6O5-@mail.gmail.com>
	<AANLkTinVQW7acb9Q_-17oVgP_DFAeeWrEg2qxojvXa2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40260 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362Ab0HKPKS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 11:10:18 -0400
Received: by eya25 with SMTP id 25so105768eya.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 08:10:16 -0700 (PDT)
In-Reply-To: <AANLkTinVQW7acb9Q_-17oVgP_DFAeeWrEg2qxojvXa2Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Hari Kanigeri <hari.kanigeri@gmail.com>, ErnestoRamos <ernesto@ti.com>, ArmandoUribe <x0095078@ti.com>, NishanthMenon <nm@ti.com>, KulikovVasiliy <segooon@gmail.com>, ReneSapiens <rene.sapiens@ti.com>, AndyShevchenko <andy.shevchenko@gmail.com>, OmarRamirezLuna <omar.ramirez@ti.com>, OhadBen-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org

Hello Felipe,

On Wed, Aug 11, 2010 at 10:01 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Hi,
>
> On Wed, Aug 11, 2010 at 3:56 PM, Ben Gardiner
> <bengardiner@nanometrics.ca> wrote:
>> Yes, dynamic memory management. With DSP Link on the OMAPL138 the
>> memory allocated to the DSP must be specified as a 'hole' in Linux
>> memory at boot-time [1[2][3]. It seems (perhaps this is wishful
>> thinking) that dspbridge does not have this limitation.
>
> The dsp-bridge can map scattered user-space pages just fine.
>
>> Also dynamic application loading. With DSP Link it is possible to run
>> multiple linux processes concurrently communicating with DSP tasks but
>> the image loaded and executed on the DSP side must contain the code
>> for all of the tasks at load time [4]. It seems that dspbridge does
>> not have this limitation.
>
> Indeed, you can dynamically load socket-nodes.

Thank you kindly for the confirmations. It's good to know our
comprehension of the current state of dspbridge is correct.

>> I am very interested in learning details about both dsplink and
>> dspbridge; please reply with more details or corrections as you see
>> fit.
>
> Have you looked into dsp-gateway[1]? The code is very simple and AFAIK
> it was close to getting merged upstream, but it's unmaintained
> nowadays. It was used on OMAP1 and OMAP2 by Nokia, and shares code
> with dsp-bridge, like mailbox and soon iommu. So it might be possible
> to port the OMAP1 stuff from dsp-gateway into dsp-bridge.

That's a good suggestion, thanks. Now that you mention it the OMAP1
and OMAPL1x have similarities other than their names [1]: they both
have ARM9 cores for GPP but the OMAP1 has a C55x where the L1x has a
C67x for DSP. I must admit that I'm not sure how I could extract the
platform specific information from the files made available by the
dspgateway project [2] yet. Nevertheless, I appreciate you pointing
out this similarity and I hope I can make use of it in the future.

Best Regards,
Ben Gardiner

[1] http://en.wikipedia.org/wiki/Texas_Instruments_OMAP
[2] http://sourceforge.net/projects/dspgateway/files/

---
Nanometrics Inc.
http://www.nanometrics.ca
