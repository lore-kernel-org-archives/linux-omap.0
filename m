From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [RFC PATCH 00/20] HWMOD Adaptation for DSS
Date: Tue, 31 Aug 2010 18:33:51 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703114AA769@dbde02.ent.ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
 <87occprkp6.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48357 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757358Ab0HaNEA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 09:04:00 -0400
In-Reply-To: <87occprkp6.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>

 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Friday, August 27, 2010 5:28 AM
> To: Guruswamy, Senthilvadivu
> Cc: linux-omap@vger.kernel.org; tomi.valkeinen@nokia.com; 
> paul@pwsan.com
> Subject: Re: [RFC PATCH 00/20] HWMOD Adaptation for DSS
> 
> Guruswamy Senthilvadivu <svadivu@ti.com> writes:
> 
> > RFC focus on the proposed design of the HWMOD adaptation to 
> the current DSS
> > driver.  DSS, DISPC, DSI, RFBI, VENC are made as platform 
> drivers each 
> > corresponding to the HWMOD class in the HWMOD database.
> 
> Hi Senthi,
> 
> Nice job on this series.  I have a handful of small comments on the
> individual patches, but I also wanted to say thanks for doing an
> excellent job of breaking this up into small, self-contained patches.
> It makes it so much easier to review small patches with well-written
> changelogs.
[Senthil]  Thanks!
> 
> Thanks!
> 
> Kevin
> 