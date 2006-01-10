From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [patch 4/5] Add MMC password protection (lock/unlock) support
 V3
Date: Tue, 10 Jan 2006 07:46:40 +0100
Message-ID: <43C35850.2020104@drzeus.cx>
References: <43C2E0BD.5040601@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750752AbWAJGqz@vger.kernel.org>
In-Reply-To: <43C2E0BD.5040601@indt.org.br>
Sender: linux-kernel-owner@vger.kernel.org
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: linux-kernel@vger.kernel.org, "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, linux@arm.linux.org.uk, ext David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
List-Id: linux-omap@vger.kernel.org

Anderson Briglia wrote:

>@@ -238,6 +295,11 @@ int mmc_register_card(struct mmc_card *c
> 			if (ret)
> 				device_del(&card->dev);
> 		}
>+#ifdef CONFIG_MMC_PASSWORDS
>+		ret = device_create_file(&card->dev, &mmc_dev_attr_lockable);
>+		if (ret)
>+			device_del(&card->dev);
>+#endif
> 	}
> 	return ret;
> }
>  
>

It might be wise to also check the command classes here. I don't believe
SDIO supports locking.

Rgds
Pierre
