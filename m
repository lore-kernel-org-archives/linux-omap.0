From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: Re: [patch 4/5] Add MMC password protection (lock/unlock) support
 V3
Date: Wed, 11 Jan 2006 09:32:17 -0400
Message-ID: <43C508E1.4080007@indt.org.br>
References: <43C2E0BD.5040601@indt.org.br> <43C35850.2020104@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751574AbWAKNbr@vger.kernel.org>
In-Reply-To: <43C35850.2020104@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org, "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, linux@arm.linux.org.uk, ext David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
List-Id: linux-omap@vger.kernel.org

Pierre Ossman wrote:
> Anderson Briglia wrote:
> 
> 
>>@@ -238,6 +295,11 @@ int mmc_register_card(struct mmc_card *c
>>			if (ret)
>>				device_del(&card->dev);
>>		}
>>+#ifdef CONFIG_MMC_PASSWORDS
>>+		ret = device_create_file(&card->dev, &mmc_dev_attr_lockable);
>>+		if (ret)
>>+			device_del(&card->dev);
>>+#endif
>>	}
>>	return ret;
>>}
>> 
>>
> 
> 
> It might be wise to also check the command classes here. I don't believe
> SDIO supports locking.

In this case, the lockable attribute will show "unlockable", which is the expected
behavior. The lockable attribute will always be present, the card being lockable or not.

Regards,

Anderson Briglia
INdT - Manaus
