From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH 01/20] DSS HWMOD database generation for OMAP3
Date: Tue, 31 Aug 2010 18:29:08 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703114AA767@dbde02.ent.ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
	<1282579089-10487-2-git-send-email-svadivu@ti.com>
 <87eidluf31.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40318 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754073Ab0HaNDW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 09:03:22 -0400
In-Reply-To: <87eidluf31.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>

 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Friday, August 27, 2010 5:01 AM
> To: Guruswamy, Senthilvadivu
> Cc: linux-omap@vger.kernel.org; tomi.valkeinen@nokia.com; 
> paul@pwsan.com
> Subject: Re: [PATCH 01/20] DSS HWMOD database generation for OMAP3
> 
> Guruswamy Senthilvadivu <svadivu@ti.com> writes:
> 
> > From: Senthilvadivu Guruswamy <svadivu@ti.com>
> >
> > OMAP3 HWMOD database for DSS is added and is applicable for 
> 34xx and 36xx.
> >
> > Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> minor nit Re: $SUBJECT.  Please title the hwmod data patches using
> something like this:
> 
>       OMAP3: hwmod data: add DSS, DISPC, DSI, RFBI, VENC
[Senthil]  Thanks, I would change it.
> 
> Kevin
> 