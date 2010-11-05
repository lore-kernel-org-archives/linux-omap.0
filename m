From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] omap: dsp: remove shm from normal memory
Date: Fri, 5 Nov 2010 13:18:26 -0500
Message-ID: <AANLkTin2BDSE_4+Ry-1cAAbxpnjzTmrPwJMLGML6tfAT@mail.gmail.com>
References: <1287473844-6228-1-git-send-email-felipe.contreras@gmail.com>
	<1287473844-6228-2-git-send-email-felipe.contreras@gmail.com>
	<20101105163417.GI9264@atomide.com>
	<AANLkTi=4cT=JByCHmRiHBimoN55Kidt+deUhQLozGvez@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:35515 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752859Ab0KESXu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 14:23:50 -0400
Received: by mail-iw0-f171.google.com with SMTP id 38so2521010iwn.16
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 11:23:49 -0700 (PDT)
In-Reply-To: <AANLkTi=4cT=JByCHmRiHBimoN55Kidt+deUhQLozGvez@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi Tony,

On Fri, Nov 5, 2010 at 12:53 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, Nov 5, 2010 at 6:34 PM, Tony Lindgren <tony@atomide.com> wrote:
>> * Felipe Contreras <felipe.contreras@gmail.com> [101019 00:28]:
>>> Also, don't be picky about the location.
>>
>> As this code is in CONFIG_TIDSPBRIDGE block and AFAIK that is
>> not working, this should probably wait for the next merge window?
>
> I plan to send a patch to revert the iommu changes to staging so that
> it does work... But this patch would be needed as well.

Would it be possible to include this series too (if nothing is
missing)? The only open question was whether to move iva2dsp.h
contents into dsp.h

tidspbridge: SCM layer violation fixes [1]

Patch 4 is to be sent through staging path, once these are pushed.

Regards,

Omar

---
[1] http://marc.info/?l=linux-omap&m=128871356703161&w=2
