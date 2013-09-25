From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RFC PATCH 09/15] ata: ti_sata: Add Texas Instruments SATA Wrapper
 driver
Date: Wed, 25 Sep 2013 14:49:56 +0200
Message-ID: <3930265.gHe05HETI5@amdc1032>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <1379595943-14622-10-git-send-email-rogerq@ti.com>
 <5608096.0pgFIteLqQ@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-reply-to: <5608096.0pgFIteLqQ@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, bcousson@baylibre.com, tony@atomide.com, balajitk@ti.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Tejun Heo <tj@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday, September 25, 2013 02:37:19 PM Bartlomiej Zolnierkiewicz wrote:

[...]

> > +#ifdef CONFIG_PM
> > +
> > +static int ti_sata_resume(struct device *dev)
> > +{
> > +	pm_runtime_disable(dev);
> > +	pm_runtime_set_active(dev);
> > +	pm_runtime_enable(dev);
> 
> This doesn't look like a correct ->resume method:
> * it shouldn't touch runtime PM at all
> * for each ->resume method there should be a corresponding ->suspend method
> 
> Moreover this whole wrapper driver seems strange, why not just add a proper
> runtime PM support to ahci_platform driver instead?

Hmm, even this shouldn't be needed as this wrapper driver doesn't have
->runtime_suspend and ->runtime resume methods.

What exactly is the purpose of the existence of this wrapper driver?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

