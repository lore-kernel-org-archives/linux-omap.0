From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [RFC/PATCH 1/1] ASoC: Add drivers for the Texas Instruments
 OMAP processors
Date: Tue, 22 Apr 2008 09:48:45 +0300
Message-ID: <20080422094845.722a949c.jarkko.nikula@nokia.com>
References: <1207300948-11598-1-git-send-email-jarkko.nikula@nokia.com>
	<1207300948-11598-2-git-send-email-jarkko.nikula@nokia.com>
	<20080421181614.GZ12099@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58219 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861AbYDVGs0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2008 02:48:26 -0400
In-Reply-To: <20080421181614.GZ12099@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Mon, 21 Apr 2008 11:16:14 -0700
"ext Tony Lindgren" <tony@atomide.com> wrote:

> > +static struct platform_device *n810_snd_device;
> > +
> > +static int __init n810_soc_init(void)
> > +{
> > +	int err;
> > +	struct device *dev;
> > +
> > +	if (!machine_is_nokia_n810())
> > +		return -ENODEV;
> > +
> > +	n810_snd_device = platform_device_alloc("soc-audio", -1);
> > +	if (!n810_snd_device)
> > +		return -ENOMEM;
> > +
> 
> The platform_device_register() should be done in board-*.c files.
> 
> This way you will know which board has this snd_device when
> compiling in support for multiple boards into the same kernel,
> and you don't need to use machine_is_some_arm() in drivers.
> 
This is a valid point. I think it should be possible to have also in
ASoC v1 e.g n810_mcbsp_aic33 driver whose probe function would be more
or less like n810_soc_init now. At least sound/soc/fsl/mpc8610_hpcd.c is
doing similar thing.

Mark, any thoughts?

> You probably also will want to pass the struct clk * in the
> platform_data so the driver can then do clk_enable/disable as needed.
> 
Makes sense since only sys_clkout2 is used here and other two
sys_clkout2_src and func96m_clk are used to setup it to correct rate.


Jarkko
