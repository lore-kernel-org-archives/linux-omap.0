From: "Paul Chiha" <paul.chiha@greyinnovation.com>
Subject: RE: Help with interfacing to OMAP2+: McBSP
Date: Thu, 20 Oct 2011 11:41:35 +1100
Message-ID: <51A4F524D105AA4C93787F33E2C90E62EE5BBD@greysvr02.GreyInnovation.local>
References: <51A4F524D105AA4C93787F33E2C90E62EE5B4D@greysvr02.GreyInnovation.local> <20111019095450.edaefce276ef5c03c454cfbb@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eth1683.vic.adsl.internode.on.net ([150.101.217.146]:58837 "EHLO
	greyinnovation.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751154Ab1JTAkm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Oct 2011 20:40:42 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20111019095450.edaefce276ef5c03c454cfbb@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-omap@vger.kernel.org

On Wed, 19 Oct 2011 5:55 PM "Jarkko Nikula" <jarkko.nikula@bitmer.com>
wrote:
> On Wed, 19 Oct 2011 17:18:54 +1100
> "Paul Chiha" <paul.chiha@greyinnovation.com> wrote:
> 
> > Hi,
> >
> > I need to write a simple driver sends and receives packets over
McBSP3
> > on the DM3730 processor, and was wondering if anyone has already
this.
> > I understand that the functions in arch/arm/plat-omap/mcbsp.c need
to
> > be used, and so I would like to see an example driver which uses
them
> > that I can base mine one.
> > Any help would be appreciated.
> >
> Only public user at the moment is sound/soc/omap/omap-mcbsp.c.
> 
> --
> Jarkko
> --

Thanks Jarkko.
I've looked at your OMAP ALSA SoC driver (well written by the way).
I'll use it as an example, but if anyone has a simpler driver they would
like to share, I would appreciate it.

Paul
