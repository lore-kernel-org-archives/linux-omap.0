From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: dspbridge and the omapl1x
Date: Wed, 11 Aug 2010 08:56:07 -0400
Message-ID: <AANLkTimDnC=BRtdGRGStYj-7XX8ZtehZvY6eK-v-6O5-@mail.gmail.com>
References: <AANLkTin7MAdSUmyja5=tp8TP+2mS53++yJT5T6+K27Lp@mail.gmail.com>
	<AANLkTinYLLf4a9p_zFfPZ5s_+-NbNi+zn8UO0G-=i1CK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43238 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab0HKM4J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 08:56:09 -0400
Received: by wyb32 with SMTP id 32so89185wyb.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 05:56:08 -0700 (PDT)
In-Reply-To: <AANLkTinYLLf4a9p_zFfPZ5s_+-NbNi+zn8UO0G-=i1CK@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <hari.kanigeri@gmail.com>
Cc: ErnestoRamos <ernesto@ti.com>, ArmandoUribe <x0095078@ti.com>, NishanthMenon <nm@ti.com>, KulikovVasiliy <segooon@gmail.com>, ReneSapiens <rene.sapiens@ti.com>, AndyShevchenko <andy.shevchenko@gmail.com>, FelipeContreras <felipe.contreras@gmail.com>, OmarRamirezLuna <omar.ramirez@ti.com>, OhadBen-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org

Hello Hari,

Thank you for reading and replying to our email.

On Tue, Aug 10, 2010 at 6:12 PM, Hari Kanigeri <hari.kanigeri@gmail.com> wrote:
> Do you mean dynamic memory management ? Can you please elaborate on
> what feature you are referring to ?

Yes, dynamic memory management. With DSP Link on the OMAPL138 the
memory allocated to the DSP must be specified as a 'hole' in Linux
memory at boot-time [1[2][3]. It seems (perhaps this is wishful
thinking) that dspbridge does not have this limitation.

Also dynamic application loading. With DSP Link it is possible to run
multiple linux processes concurrently communicating with DSP tasks but
the image loaded and executed on the DSP side must contain the code
for all of the tasks at load time [4]. It seems that dspbridge does
not have this limitation.

I am very interested in learning details about both dsplink and
dspbridge; please reply with more details or corrections as you see
fit.

Best Regards,
Ben Gardiner

[1] http://processors.wiki.ti.com/index.php/Changing_DSPLink_Memory_Map
[2] http://e2e.ti.com/support/dsp/omap_applications_processors/f/42/t/29571.aspx
[3] http://code.google.com/p/rowboat/wiki/DSP

[4] http://processors.wiki.ti.com/index.php/Using_DSPLink_from_multiple_processes

---
Nanometrics Inc.
http://www.nanometrics.ca
