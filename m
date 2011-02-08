From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2 3/9] omap4: powerdomain: Use intended PWRSTS_* flags
 instead of values
Date: Tue, 8 Feb 2011 12:07:10 +0530
Message-ID: <8dcdd90dcde5ddefc02b08dc2faf9169@mail.gmail.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
 <1296813544-25170-4-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1102071845140.21991@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:40725 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751647Ab1BHGhM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 01:37:12 -0500
Received: by mail-yx0-f181.google.com with SMTP id 39so2571474yxd.26
        for <linux-omap@vger.kernel.org>; Mon, 07 Feb 2011 22:37:11 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102071845140.21991@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, February 08, 2011 7:16 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; khilman@ti.com; b-cousson@ti.com;
> rnayak@ti.com; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v2 3/9] omap4: powerdomain: Use intended
> PWRSTS_* flags instead of values
>
> On Fri, 4 Feb 2011, Santosh Shilimkar wrote:
>
> > IVAHD and ABE power domain logic state is populated using directly
> > value instead of the capability flags.
> >
> > Fix the same.
> >
> > This was getting generated due to a bug 'gen_logicst' macro
> > in powerdomain autogen script bug which is fixed as well.
>
> Should we try to get this one into the -rc series, since it is a
> bug-fix ?
>
Make sense.
