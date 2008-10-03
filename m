From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [alsa-devel] [patch] bugfix: SOUND: SOC: OMAP: Add support for Gumstix Overo
Date: Fri, 3 Oct 2008 16:18:47 +0100
Message-ID: <20081003151846.GA9127@sirena.org.uk>
References: <200810030811.33484.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3813 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbYJCPSv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 11:18:51 -0400
Content-Disposition: inline
In-Reply-To: <200810030811.33484.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>

On Fri, Oct 03, 2008 at 08:11:33AM -0700, David Brownell wrote:

> Get rid of bogus ASOC boot messages on non-Overo boards,
> such as with a kernel built for both Overo and Beagle.

<nitpick>It's ASoC, not ASOC.</nitpick>

> ---
> I'm not sure where the four patches for Overo support are
> in the ALSA queue (that's how they'll merge, yes?) but I'll
> suggest this one merge into the initial "overo.c" submit...

They're not queued in ALSA since they depend on the PMIC codec driver
which in turn depends on the PMIC core driver being merged.  The change
looks good, FWIW but...

> @@ -135,13 +135,12 @@ err1:
>  
>  	return ret;
>  }
> +module_init(overo_soc_init);
>  
>  static void __exit overo_soc_exit(void)
>  {
>  	platform_device_unregister(overo_snd_device);
>  }
> -
> -module_init(overo_soc_init);
>  module_exit(overo_soc_exit);

This is a reasonable change but unrelated to your patch description.
