From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] regulator:TPS65910: VDD1/2 voltage selector count
Date: Fri, 4 Nov 2011 15:25:59 +0000
Message-ID: <20111104152559.GC28615@opensource.wolfsonmicro.com>
References: <1320410928-20349-1-git-send-email-afzal@ti.com>
 <20111104140422.GA28615@opensource.wolfsonmicro.com>
 <C8443D0743D26F4388EA172BF4E2A7A90194B0@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:38797 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752708Ab1KDP0B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 11:26:01 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A90194B0@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>, Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>

On Fri, Nov 04, 2011 at 02:26:05PM +0000, Mohammed, Afzal wrote:
> Hi Brown,

Ahem.

> On Fri, Nov 04, 2011 at 19:34:22, Mark Brown wrote:
> > On Fri, Nov 04, 2011 at 06:18:48PM +0530, Afzal Mohammed wrote:

> > >  		if (i == TPS65910_REG_VDD1 || i == TPS65910_REG_VDD2) {
> > >  			pmic->desc[i].ops = &tps65910_ops_dcdc;
> > > +			pmic->desc[i].n_voltages = VDD1_2_NUM_VOLTS * 3;

> > This looks suspicous - what's the * 3 about?

> Gain in voltage possible is x1, 0x2 & 0x3, I am shaky
> about this change, but voltage could be changed with this,

That doesn't really clarify things - the question is why the number of
voltages we can set is three times a constant called _NUM_VOLTS?
