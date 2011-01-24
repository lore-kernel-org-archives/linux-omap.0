From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 00/13] OMAP: Basic DVFS Framework
Date: Mon, 24 Jan 2011 11:31:20 +0530
Message-ID: <08a041d030691db0dd00737a6342d3d1@mail.gmail.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com> <20110122171805.GA14774@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53398 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751241Ab1AXGBh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 01:01:37 -0500
Received: by mail-fx0-f53.google.com with SMTP id 11so4154923fxm.26
        for <linux-omap@vger.kernel.org>; Sun, 23 Jan 2011 22:01:21 -0800 (PST)
In-Reply-To: <20110122171805.GA14774@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, patches@linaro.org

Balbi,

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: Saturday, January 22, 2011 10:48 PM
> To: Vishwanath BS
> Cc: linux-omap@vger.kernel.org; patches@linaro.org
> Subject: Re: [PATCH 00/13] OMAP: Basic DVFS Framework
>
> Hi,
>
> On Fri, Jan 21, 2011 at 07:30:52PM +0530, Vishwanath BS wrote:
> > This patch series introduces support for Dynamic Voltage and
> Frequency Scaling
> > (DVFS) for OMAP devices.
> >
> > For detailed design details, refer to DVFS Documentation.
>
> If this is supposed to be used by drivers I would rather not as it's yet
> another OMAP-specific API to use.
>
> Before you reply with "you can pass function pointers via platform_data"
> let me say that even that is a burden, specially on devices which are
> used by several archs.
>
> Why don't you make it more generic like the OPP layer was created ?
> Isn't it better to just build on top of the OPP layer and make this one
> also generic ?
I do not think DVFS layer can be made a generic layer outside OMAP because
of the fact that DVFS is closely coupled with OMAP device layer (for
getting hwmod related data and clock handling), OMAP voltage layer (for
voltage scaling and handling of dependency voltage domains) and smart
reflex layer.

Vishwa

>
> --
> balbi
