From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [omap-for-linus] Un-used DSS regulator data
Date: Mon, 28 Feb 2011 14:33:05 +0530
Message-ID: <5d8d37713fb3fdbcae6bdcb3c198be38@mail.gmail.com>
References: <a46904cc06b5f68124e65086b9961d02@mail.gmail.com> <1298883592.9809.1.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:59492 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752978Ab1B1JDI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 04:03:08 -0500
Received: by qyk30 with SMTP id 30so3167790qyk.7
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 01:03:06 -0800 (PST)
In-Reply-To: <1298883592.9809.1.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@ti.com]
> Sent: Monday, February 28, 2011 2:30 PM
> To: Shilimkar, Santosh
> Cc: Semwal, Sumit; Guruswamy, Senthilvadivu; linux-
> omap@vger.kernel.org; tony@atomide.com
> Subject: Re: [omap-for-linus] Un-used DSS regulator data
>
> Hi,
>
> On Mon, 2011-02-28 at 02:50 -0600, Shilimkar, Santosh wrote:
> > Tomi/Sumit,
> >
> > Today while building Tony's 'omap-for-linus' branch I came
> > across below build warning.
> > warning: 'sdp3430_vdda_dac_supply' defined but not used
> >
> > It seems the DSS regulator data is not being used. Are you missing
> > any patch which will use it eventually?
>
> It was an accidental left over from conflict resolving. I have a
> patch in DSS tree which removes the regulator supply.
>
Ok.
