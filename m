From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH v2 8/9] wlcore: sdio: get clocks from device tree
Date: Wed, 3 Jul 2013 00:38:45 +0300
Message-ID: <1372801125.21065.99.camel@cumari.coelho.fi>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
	 <1372776948-24840-9-git-send-email-coelho@ti.com>
	 <20130702153526.GI7013@arwen.pp.htv.fi>
	 <1372796394.21065.89.camel@cumari.coelho.fi>
	 <20130702213208.GC10388@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130702213208.GC10388@arwen.pp.htv.fi>
Sender: linux-doc-owner@vger.kernel.org
To: balbi@ti.com
Cc: linux-wireless@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, mturquette@linaro.org, mark.rutland@arm.com, grant.likely@linaro.org, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, 2013-07-03 at 00:32 +0300, Felipe Balbi wrote:
> On Tue, Jul 02, 2013 at 11:19:54PM +0300, Luciano Coelho wrote:
> > On Tue, 2013-07-02 at 18:35 +0300, Felipe Balbi wrote:
> > > Hi,
> > > 
> > > On Tue, Jul 02, 2013 at 05:55:47PM +0300, Luciano Coelho wrote:
> > > > @@ -294,6 +316,8 @@ static int wl1271_probe(struct sdio_func *func,
> > > >  	/* Use block mode for transferring over one block size of data */
> > > >  	func->card->quirks |= MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
> > > >  
> > > > +	sdio_set_drvdata(func, glue);
> > > 
> > > is this move really necessary ?
> > 
> > It is, because I use the glue in wlcore_get_pdata_from_of(), so I need
> > to call sdio_set_drvdata() earlier.  I reckoned it wouldn't hurt to move
> > this, so I wouldn't have to pass the glue in the
> > wlcore_get_pdata_from_of() call.
> 
> that's alright, it does look like it deserves a mention in changelog
> though. Other than that:

Uh, ok.  This was so tiny (and I thought so obvious) a change that I
didn't mention it.  But if you asked about it, it was not obvious
enough. ;) I'll add a small comment about it in the commit message.


> Reviewed-by: Felipe Balbi <balbi@ti.com>

Thanks!

--
Luca.

