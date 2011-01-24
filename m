From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 00/13] OMAP: Basic DVFS Framework
Date: Mon, 24 Jan 2011 19:55:21 +0530
Message-ID: <f5a0abe43775faf0ecbb4cf08c842bb7@mail.gmail.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
 <20110122171805.GA14774@legolas.emea.dhcp.ti.com> <08a041d030691db0dd00737a6342d3d1@mail.gmail.com>
 <20110124061847.GH2756@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:37599 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751346Ab1AXOZ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 09:25:28 -0500
Received: by mail-ew0-f45.google.com with SMTP id 10so2358552ewy.18
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 06:25:27 -0800 (PST)
In-Reply-To: <20110124061847.GH2756@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, patches@linaro.org

Balbi,

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: Monday, January 24, 2011 11:49 AM
> To: Vishwanath Sripathy
> Cc: balbi@ti.com; linux-omap@vger.kernel.org; patches@linaro.org
> Subject: Re: [PATCH 00/13] OMAP: Basic DVFS Framework
>
> Hi,
>
> On Mon, Jan 24, 2011 at 11:31:20AM +0530, Vishwanath Sripathy
> wrote:
> > I do not think DVFS layer can be made a generic layer outside OMAP
> because
> > of the fact that DVFS is closely coupled with OMAP device layer (for
> > getting hwmod related data and clock handling), OMAP voltage layer
> (for
> > voltage scaling and handling of dependency voltage domains) and
> smart
> > reflex layer.
>
> that an implementation detail. If you:
>
> 	a. make the DVFS layer so that you need a HW-glue layer which
> 	will use OMAP-specific APIs; or
>
> 	b. pass function pointers for the generic DVFS layer to use
>
> (note that I'd rather have option (a)), you solve the problem, no ?
It is not just implementation. Even the underlying design of DVFS is
closely coupled with these layers. If we try to split this DVFS framework
into generic and OMAP specific part, then the flow will become too
cumbersome since there are will be too many interactions between common
and OMAP part. Also it will reduce the code readability aspect as well.
I do not think it's worth adding some much of complexity and effort just
to avoid a driver using platform specific function pointers to call these
APIs.

Vishwa

>
> --
> balbi
