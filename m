From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/8] McBSP: OMAP3: Add Sidetone feature
Date: Thu, 8 Oct 2009 14:17:02 +0100
Message-ID: <20091008131702.GC29176@rakim.wolfsonmicro.main>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
 <1255003137-1034-4-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36158 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758025AbZJHNRj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 09:17:39 -0400
Content-Disposition: inline
In-Reply-To: <1255003137-1034-4-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>

On Thu, Oct 08, 2009 at 02:58:52PM +0300, Eduardo Valentin wrote:

> +static const struct attribute *sidetone_attrs[] = {
> +	&dev_attr_st_enable.attr,
> +	&dev_attr_st_taps.attr,
> +	&dev_attr_st_ch0gain.attr,
> +	&dev_attr_st_ch1gain.attr,
> +	NULL,
> +};

This stuff, particularly the enable, probably wants to be pushed out via
an ALSA API rather than via random sysfs stuff.  It'd be better to
publish a control API here and then use that from within ALSA.
