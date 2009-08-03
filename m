From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH 0/4] TWL6030 patch series
Date: Mon, 3 Aug 2009 15:25:34 +0100
Message-ID: <20090803142534.GB4265@rakim.wolfsonmicro.main>
References: <19F8576C6E063C45BE387C64729E739404329D66BE@dbde02.ent.ti.com>
 <20090720121157.GA13867@nokia.com>
 <20090720121526.GB5215@sirena.org.uk>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B59F2A0F@dbde02.ent.ti.com>
 <20090724092034.GB27429@rakim.wolfsonmicro.main>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B5BF2678@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57918 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755047AbZHCOZf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 10:25:35 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B5BF2678@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "Nayak, Rajendra" <rnayak@ti.com>

On Mon, Aug 03, 2009 at 11:45:58AM +0530, Shilimkar, Santosh wrote:

> Can you please provide your comments on the v2 version of the patches in which Balaji has fixed the "ifdef's"

They're basically OK from a regulator API point of view but the series
appears to depend on the renaming patch and possibly some others.
