From: Michael Welling <mwelling@ieee.org>
Subject: Re: next-20150511 / omap2-mcspi: regression for sdp4430 boot
Date: Tue, 12 May 2015 12:22:53 -0500
Message-ID: <20150512172253.GA18821@deathray>
References: <5550DDCB.8010303@ti.com>
 <20150511170742.GA6616@deathray>
 <5550F47C.1030902@ti.com>
 <20150511183032.GA8085@deathray>
 <5550FC38.6020801@ti.com>
 <20150511201633.GA31117@deathray>
 <555235CC.9040706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <555235CC.9040706@ti.com>
Sender: linux-next-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mark Brown <broonie@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-next <linux-next@vger.kernel.org>, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, May 12, 2015 at 12:18:04PM -0500, Nishanth Menon wrote:
> On 05/11/2015 03:16 PM, Michael Welling wrote:
> [...]
> > Okay I have another patch that appears to fix the issue on my board.
> > 
> > Please test the attached patch and see if it fixes the issue on your board.
> > 
> > If it does, I will send it upstream.
> 
> Tested on: 20150512 http://paste.ubuntu.org.cn/2600365
> Works :). Thanks for rootcausing and providing a fix.

Phew.

Okay this patch or a revision of it should land upstream soon.

> 
> -- 
> Regards,
> Nishanth Menon
