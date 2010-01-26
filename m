From: "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>
Subject: RE: [alsa-devel] [PATCHv2 5/6] ASoC: OMAP4: Add support for McPDM
Date: Tue, 26 Jan 2010 11:55:58 -0600
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B8C569C03@dlee01.ent.ti.com>
References: <2256F256009DAA4CBE661E9F41EAC84B8C43A8B4@dlee01.ent.ti.com>
 <1264211090.3480.141.camel@odin>
 <2256F256009DAA4CBE661E9F41EAC84B8C4CEF35@dlee01.ent.ti.com>
 <20100126095730.GA15759@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39854 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754667Ab0AZR4L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 12:56:11 -0500
In-Reply-To: <20100126095730.GA15759@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Mark Brown wrote:
> 
> On Mon, Jan 25, 2010 at 03:06:27PM -0600, Candelaria 
> Villareal, Jorge wrote:
> > Liam Girdwood wrote:
> 
> > > What does this do and why is it not static ?
> 
> > It enables and configures offset cancelation for the analog 
> headset path. It is supposed to be called by the codec 
> driver, so it should'nt be static. But, offset cancelation is 
> probably not going to be used at first.
> 
> So this is a DC offset in the output?
> 

Yes, its purpose is to get rid of the DC offset in the output