From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problems while designing TPS65023 regulator driver
Date: Fri, 3 Apr 2009 09:53:36 +0100
Message-ID: <20090403085335.GA3759@sirena.org.uk>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FAA91D06@dbde02.ent.ti.com> <20090226140450.GB8595@sirena.org.uk> <5A47E75E594F054BAF48C5E4FC4B92AB02FB102A76@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:55662 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbZDCIxp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 04:53:45 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FB102A76@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Apr 03, 2009 at 01:33:58PM +0530, Aggarwal, Anuj wrote:

> I could not find the commit in linux-OMAP git where the init data is 
> passed as a parameter to the regulator_register(). I am dependent 
> on this commit for my TPS65023 regulator driver and could not push 
> my patch without the commit being in l-o.

> Any idea when this would be available in l-o?

I can't speak for the OMAP tree but the patch should appear in
2.6.30-rc1 so presumably it'll get merged into OMAP some time after that
is released.
