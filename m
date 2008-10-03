From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5 v2] ASoC Add TLV320AIC23 codec driver
Date: Fri, 3 Oct 2008 11:18:57 +0300
Message-ID: <20081003081856.GC25482@atomide.com>
References: <dfeb90390810020215y605ce8a4v43331cb852bd6018@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62946 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbYJCIQE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 04:16:04 -0400
Content-Disposition: inline
In-Reply-To: <dfeb90390810020215y605ce8a4v43331cb852bd6018@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arun KS <arunks@mistralsolutions.com>
Cc: alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@nokia.com>, troy.kisky@boundarydevices.com, felipe.balbi@nokia.com

Hi,

* Arun KS <arunks@mistralsolutions.com> [081002 12:18]:
> ASoC codec driver for TLV320AIC23 device

One comment below based on a quick browse.

<snip>

> +static void tlv320aic23_shutdown(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_device *socdev = rtd->socdev;
> +	struct snd_soc_codec *codec = socdev->codec;
> +
> +	/* deactivate */
> +	if (!codec->active) {
> +		udelay(50);
> +		tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x0);
> +	}
> +}
> +

What's the purpose of the udelay() here? Looks like if needed it should
be after the twl32aic23_write().. Otherwise the problem is probably
somewhere else.

Tony
