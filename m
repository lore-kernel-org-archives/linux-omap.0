From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Wed, 9 Sep 2009 19:33:58 +0100
Message-ID: <20090909183358.GC5235@n2100.arm.linux.org.uk>
References: <20090817173343.GA17323@debian> <20090817174718.GU10764@n2100.arm.linux.org.uk> <20090817180145.GA17378@debian> <20090817180455.GW10764@n2100.arm.linux.org.uk> <A24693684029E5489D1D202277BE89444A8201BE@dlee02.ent.ti.com> <20090818030148.GA2283@debian> <A24693684029E5489D1D202277BE89444B781B03@dlee02.ent.ti.com> <0680EC522D0CC943BC586913CF3768C0037CF20A00@dbde02.ent.ti.com> <20090909071711.GF23361@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C0037CF20AA2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48913 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbZIISfH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Sep 2009 14:35:07 -0400
Content-Disposition: inline
In-Reply-To: <0680EC522D0CC943BC586913CF3768C0037CF20AA2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, Rabin Vincent <rabin@rab.in>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Sep 09, 2009 at 01:16:48PM +0530, Syed Mohammed, Khasim wrote:
> Hi Russell,
> 
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > Sent: Wednesday, September 09, 2009 12:47 PM
> > To: Syed Mohammed, Khasim
> > Cc: Aguirre Rodriguez, Sergio Alberto; Rabin Vincent; linux-arm-
> > kernel@lists.arm.linux.org.uk; linux-omap@vger.kernel.org
> > Subject: Re: Exception while handling MEM Hole on OMAP3 / ARM Cortex A8
> > 
> > And how about my revised version, which is the version which is going
> > to be merged?
> 
> Sorry for missing this out. This works, no issues reported.

And so can I add a:

Tested-by: Khasim Syed Mohammed <khasim@ti.com>

or is it a just a Reviewed-by: ?
