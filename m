From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/4] ASoC: cx20442: add bias control over a platform
 provided regulator
Date: Mon, 2 Jan 2012 12:47:19 +0000
Message-ID: <20120102124719.GF4300@opensource.wolfsonmicro.com>
References: <1325214296-2888-3-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48554 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751887Ab2ABMrY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jan 2012 07:47:24 -0500
Content-Disposition: inline
In-Reply-To: <1325214296-2888-3-git-send-email-jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org

On Fri, Dec 30, 2011 at 04:04:54AM +0100, Janusz Krzysztofik wrote:
> Now that a regulator device for controlling the codec chip reset state
> over a platform agnostic regulator API is available on the only board
> using this driver so far, extend the driver with a bias control function
> which will request virtual power to the codec chip from that virtual
> regulator, and will supersede the present implementation existing at the
> sound card level.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
