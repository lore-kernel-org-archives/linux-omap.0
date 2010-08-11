From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: dspbridge and the omapl1x
Date: Wed, 11 Aug 2010 17:01:43 +0300
Message-ID: <AANLkTinVQW7acb9Q_-17oVgP_DFAeeWrEg2qxojvXa2Q@mail.gmail.com>
References: <AANLkTin7MAdSUmyja5=tp8TP+2mS53++yJT5T6+K27Lp@mail.gmail.com>
	<AANLkTinYLLf4a9p_zFfPZ5s_+-NbNi+zn8UO0G-=i1CK@mail.gmail.com>
	<AANLkTimDnC=BRtdGRGStYj-7XX8ZtehZvY6eK-v-6O5-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52106 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab0HKOBp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 10:01:45 -0400
Received: by bwz3 with SMTP id 3so127289bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 07:01:44 -0700 (PDT)
In-Reply-To: <AANLkTimDnC=BRtdGRGStYj-7XX8ZtehZvY6eK-v-6O5-@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: Hari Kanigeri <hari.kanigeri@gmail.com>, ErnestoRamos <ernesto@ti.com>, ArmandoUribe <x0095078@ti.com>, NishanthMenon <nm@ti.com>, KulikovVasiliy <segooon@gmail.com>, ReneSapiens <rene.sapiens@ti.com>, AndyShevchenko <andy.shevchenko@gmail.com>, OmarRamirezLuna <omar.ramirez@ti.com>, OhadBen-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org

Hi,

On Wed, Aug 11, 2010 at 3:56 PM, Ben Gardiner
<bengardiner@nanometrics.ca> wrote:
> On Tue, Aug 10, 2010 at 6:12 PM, Hari Kanigeri <hari.kanigeri@gmail.com> wrote:
>> Do you mean dynamic memory management ? Can you please elaborate on
>> what feature you are referring to ?
>
> Yes, dynamic memory management. With DSP Link on the OMAPL138 the
> memory allocated to the DSP must be specified as a 'hole' in Linux
> memory at boot-time [1[2][3]. It seems (perhaps this is wishful
> thinking) that dspbridge does not have this limitation.

The dsp-bridge can map scattered user-space pages just fine.

> Also dynamic application loading. With DSP Link it is possible to run
> multiple linux processes concurrently communicating with DSP tasks but
> the image loaded and executed on the DSP side must contain the code
> for all of the tasks at load time [4]. It seems that dspbridge does
> not have this limitation.

Indeed, you can dynamically load socket-nodes.

> I am very interested in learning details about both dsplink and
> dspbridge; please reply with more details or corrections as you see
> fit.

Have you looked into dsp-gateway[1]? The code is very simple and AFAIK
it was close to getting merged upstream, but it's unmaintained
nowadays. It was used on OMAP1 and OMAP2 by Nokia, and shares code
with dsp-bridge, like mailbox and soon iommu. So it might be possible
to port the OMAP1 stuff from dsp-gateway into dsp-bridge.

Cheers.

[1] http://dspgateway.sourceforge.net/pub/index.php

-- 
Felipe Contreras
