From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCHv2 5/6] ASoC: OMAP4: Add support for McPDM
Date: Tue, 26 Jan 2010 09:57:31 +0000
Message-ID: <20100126095730.GA15759@rakim.wolfsonmicro.main>
References: <2256F256009DAA4CBE661E9F41EAC84B8C43A8B4@dlee01.ent.ti.com>
 <1264211090.3480.141.camel@odin>
 <2256F256009DAA4CBE661E9F41EAC84B8C4CEF35@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:33747 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750758Ab0AZJ5d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jan 2010 04:57:33 -0500
Content-Disposition: inline
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B8C4CEF35@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Jan 25, 2010 at 03:06:27PM -0600, Candelaria Villareal, Jorge wrote:
> Liam Girdwood wrote:

> > What does this do and why is it not static ?

> It enables and configures offset cancelation for the analog headset path. It is supposed to be called by the codec driver, so it should'nt be static. But, offset cancelation is probably not going to be used at first.

So this is a DC offset in the output?
