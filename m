From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: OMAP5: voltagedomain data: remove temporary OMAP4 voltage data
Date: Wed, 26 Jun 2013 16:52:53 +0200
Message-ID: <201306261652.53632.arnd@arndb.de>
References: <1372204560-1304-1-git-send-email-nm@ti.com> <87sj05sp0p.fsf@linaro.org> <20130626073056.GS5523@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56490 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab3FZOxS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jun 2013 10:53:18 -0400
In-Reply-To: <20130626073056.GS5523@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

On Wednesday 26 June 2013, Tony Lindgren wrote:
> * Kevin Hilman <khilman@linaro.org> [130625 17:24]:
> > Nishanth Menon <nm@ti.com> writes:
> > 
> > > commit 20d49e9ccfece526db755940721aa13e331936d4
> > > (ARM: OMAP5: voltagedomain data: Add OMAP5 voltage domain data)
> > >
> > > Introduced dummy volt data for OMAP5 with OMAP4460 voltage information.
> > >
> > > However with the fixes introduced in later patches
> > >
> > > commit cd8abed1da91a3250aa4b3857479613a2b446f84
> > > (ARM: OMAP2+: Powerdomain: Remove the need to always have a voltdm
> > >  associated to a pwrdm)
> > >
> > > We are no longer restricted in that respect. Further, OPP voltage
> > > information is supposed to be provided by dts information. This needs
> > > to be added in future patches as various voltage modules are converted
> > > to dts.
> > >
> > > This also fixes the build breakage for voltagedomains54xx_data.c when just
> > > OMAP5 SoC is enabled: https://patchwork.kernel.org/patch/2764191/
> > >
> > > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > > Cc: Benoit Cousson <b-cousson@ti.com>
> > > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > Cc: Paul Walmsley <paul@pwsan.com>
> > > Cc: Tony Lindgren <tony@atomide.com>
> > > Cc: linux-omap@vger.kernel.org
> > 
> > Acked-by: Kevin Hilman <khilman@linaro.org>
> > 
> > Arnd, to make it easy, below is a pull request for this fix on top of
> > arm-soc/omap/omap5.
> 
> This can get easily lost, might be best to send a new email with
> [GIT PULL] in the subject.

Good idea in general. I've got this one and pulled it into next/soc.

	Arnd
