From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH] omap:hwmod-remove prm header from prm-regbits-xxxx
 headers
Date: Thu, 20 May 2010 13:25:34 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4BD7717A@dlee03.ent.ti.com>
References: <1274307029-22032-1-git-send-email-h-kanigeri2@ti.com>
 <87bpcafqf2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53856 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652Ab0ETSZi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 14:25:38 -0400
In-Reply-To: <87bpcafqf2.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, Linux Omap <linux-omap@vger.kernel.org>

Hi Kevin

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, May 20, 2010 12:13 PM
> To: Kanigeri, Hari
> Cc: Paul Walmsley; Linux Omap
> Subject: Re: [PATCH] omap:hwmod-remove prm header from prm-regbits-xxxx
> headers
> 
> Hari Kanigeri <h-kanigeri2@ti.com> writes:
> 
> > The prm-regbits-xxxx.h header files are not dependent on prm.h
> > header file.
> >
> > Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
> 
> This file is not in mailine, or linux-omap master.  Please
> state any dependencies in this part of the changelog.
> 

This is based on the latest omap4_next branch on dev.omapzoom.org, so most probably didn't make it to linux omap yet.

I came to know through Benoit that this file is auto-generated using Perl script, so I guess this change can be handled in the generator script.

Thank you,
Best regards,
Hari
