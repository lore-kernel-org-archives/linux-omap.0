From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 09/15] ata: ti_sata: Add Texas Instruments SATA Wrapper
 driver
Date: Wed, 25 Sep 2013 16:29:01 +0300
Message-ID: <5242E51D.1020602@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com> <1379595943-14622-10-git-send-email-rogerq@ti.com> <5608096.0pgFIteLqQ@amdc1032> <3930265.gHe05HETI5@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3930265.gHe05HETI5@amdc1032>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 09/25/2013 03:49 PM, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday, September 25, 2013 02:37:19 PM Bartlomiej Zolnierkiewicz wrote:
> 
> [...]
> 
>>> +#ifdef CONFIG_PM
>>> +
>>> +static int ti_sata_resume(struct device *dev)
>>> +{
>>> +	pm_runtime_disable(dev);
>>> +	pm_runtime_set_active(dev);
>>> +	pm_runtime_enable(dev);
>>
>> This doesn't look like a correct ->resume method:
>> * it shouldn't touch runtime PM at all
>> * for each ->resume method there should be a corresponding ->suspend method
>>
>> Moreover this whole wrapper driver seems strange, why not just add a proper
>> runtime PM support to ahci_platform driver instead?
> 
> Hmm, even this shouldn't be needed as this wrapper driver doesn't have
> ->runtime_suspend and ->runtime resume methods.
> 
> What exactly is the purpose of the existence of this wrapper driver?

This is the weirdness of OMAP hwmod framework :).

The OMAP hwmod framework tries to manage the module clocks by itself and needs
a runtime_resume to enable the relevant clocks.

hwmod framework will be deprecated in the near future and this is the place where
we need to handle the resources.

But since we are not yet there, I can get rid of this wrapper driver for now
and add the necessary pm_runtime calls in the ahci_platform driver.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
