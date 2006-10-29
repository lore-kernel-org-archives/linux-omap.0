From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [patch 2/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V5
Date: Sun, 29 Oct 2006 10:31:59 +0100
Message-ID: <4544750F.4000301@drzeus.cx>
References: <20061020164914.012378000@localhost.localdomain> <20061020165134.378993000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932128AbWJ2JcD@vger.kernel.org>
In-Reply-To: <20061020165134.378993000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: linux-kernel@vger.kernel.org, linux-omap-open-source@linux.omap.com, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+lkml@arm.linux.org.uk>, ilias.biris@indt.org.br
List-Id: linux-omap@vger.kernel.org

Carlos Aguiar wrote:
> +int mmc_key_instantiate(struct key *key, const void *data, size_t datalen)
>   

static

> +int mmc_key_match(const struct key *key, const void *description)
>   

static

> +void mmc_key_destroy(struct key *key)
>   

static

> @@ -335,6 +403,15 @@ static int __init mmc_init(void)
>  		ret = class_register(&mmc_host_class);
>  		if (ret)
>  			bus_unregister(&mmc_bus_type);
> +#ifdef	CONFIG_MMC_PASSWORDS
> +		else {
> +			ret = register_key_type(&mmc_key_type);
> +			if (ret) {
> +				class_unregister(&mmc_host_class);
> +				bus_unregister(&mmc_bus_type);
> +			}
> +		}
> +#endif
>  	}
>  	return ret;
>  }
>   

We're starting to get a bit of code duplication here. Perhaps an error
handling section at the end of the function would be better.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
