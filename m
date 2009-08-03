From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RFC][PATCH 0/4] TWL6030 patch series
Date: Mon, 3 Aug 2009 11:45:58 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B5BF2678@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E739404329D66BE@dbde02.ent.ti.com>
 <20090720121157.GA13867@nokia.com> <20090720121526.GB5215@sirena.org.uk>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B59F2A0F@dbde02.ent.ti.com>
 <20090724092034.GB27429@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47767 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558AbZHCGQS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 02:16:18 -0400
In-Reply-To: <20090724092034.GB27429@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Felipe Balbi <felipe.balbi@nokia.com>
Cc: "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "Nayak, Rajendra" <rnayak@ti.com>

Mark, Felipe,
> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Friday, July 24, 2009 2:51 PM
> To: Shilimkar, Santosh
> Cc: Felipe Balbi; Krishnamoorthy, Balaji T; linux-omap@vger.kernel.org;
> tony@atomide.com; khilman@deeprootsystems.com; david-b@pacbell.net; Nayak,
> Rajendra
> Subject: Re: [RFC][PATCH 0/4] TWL6030 patch series
> 
> On Fri, Jul 24, 2009 at 09:46:27AM +0530, Shilimkar, Santosh wrote:
> 
> > Mark, Liam,
> > Can you please your comments of regulator patches.
> 
> I'd really like to see the ifdefs go as someone else requested earlier
> in the thread.  Allowing both twl4030 and twl6030 support to be built
> simultaneously is much nicer from a maintinance perspective and will
> scale better as further devices are added to the family.

Can you please provide your comments on the v2 version of the patches in which Balaji has fixed the "ifdef's"

Thanks!!

Regards,
Santosh
