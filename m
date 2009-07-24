From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH 0/4] TWL6030 patch series
Date: Fri, 24 Jul 2009 10:20:34 +0100
Message-ID: <20090724092034.GB27429@rakim.wolfsonmicro.main>
References: <19F8576C6E063C45BE387C64729E739404329D66BE@dbde02.ent.ti.com>
 <20090720121157.GA13867@nokia.com>
 <20090720121526.GB5215@sirena.org.uk>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B59F2A0F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36944 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752255AbZGXJUg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jul 2009 05:20:36 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B59F2A0F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "Nayak, Rajendra" <rnayak@ti.com>

On Fri, Jul 24, 2009 at 09:46:27AM +0530, Shilimkar, Santosh wrote:

> Mark, Liam,
> Can you please your comments of regulator patches.

I'd really like to see the ifdefs go as someone else requested earlier
in the thread.  Allowing both twl4030 and twl6030 support to be built
simultaneously is much nicer from a maintinance perspective and will
scale better as further devices are added to the family.
