From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH RESEND 1/4] ARM: OMAP2+: AM33XX: Add tps65910 device
 tree data
Date: Mon, 23 Jul 2012 07:06:48 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13E9FAF74@DBDE01.ent.ti.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
 <1342766789-28148-2-git-send-email-anilkumar@ti.com>
 <20120720095935.GQ4495@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9FA91E@DBDE01.ent.ti.com>
 <20120720113806.GW4495@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49633 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753038Ab2GWHHD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jul 2012 03:07:03 -0400
In-Reply-To: <20120720113806.GW4495@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Jul 20, 2012 at 17:08:06, Mark Brown wrote:
> On Fri, Jul 20, 2012 at 11:27:36AM +0000, AnilKumar, Chimata wrote:
> > On Fri, Jul 20, 2012 at 15:29:36, Mark Brown wrote:
> 
> > > Every regulator here has a rather large voltage range specified with no
> > > consumers added.  Are you sure these voltage ranges make sense in your
> > > design and you've not just cut'n'pasted the entire voltage range that
> > > your regulator supports without reference to what your board can do?
> 
> > tps65217.dtsi is a generic file to be used by the SoCs so these constraints
> > were taken from the regulator itself. SoC specific limits can be added in
> > SoC specific .dts file to tighten the constraints to require limit. I have
> > tested the driver with this approach.
> 
> No, this is not a sane approach.  You've no idea if any of these
> settings are safe or sane for the board.  Boards should enable things
> they know are safe, not remove those they know are broken.
> 

Unsterstood, I will send v2 with constraints updated.

Regards
AnilKumar