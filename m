From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH RFC 3/9] ASoC: davinci-evm: HDMI audio support for
 TDA998x trough McASP I2S bus
Date: Tue, 19 Nov 2013 16:07:54 +0100
Message-ID: <20131119160754.7307a763@skate>
References: <cover.1384862950.git.jsarha@ti.com>
	<737bab348e15c6c2aba01ecd91e84c870aafe242.1384862950.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47112 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750980Ab3KSPID (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 10:08:03 -0500
In-Reply-To: <737bab348e15c6c2aba01ecd91e84c870aafe242.1384862950.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, detheridge@ti.com, broonie@kernel.org

Dear Jyri Sarha,

On Tue, 19 Nov 2013 14:12:23 +0200, Jyri Sarha wrote:

> -- compatible : "ti,da830-evm-audio" : forDM365/DA8xx/OMAPL1x/AM33xx
> +- compatible : "ti,da830-evm-audio" : for DM365/DA8xx/OMAPL1x/AM33xx
> +               "ti,am33xx-beaglebone-black" : for Beaglebone-black HDMI audio

The compatible string namespace is a global namespace, and in the
compatible string you've chosen, there's nothing that makes it specific
to audio. "ti,am33xx-beaglebone-black" could be used for any other
device, or even for the board as a whole, no? Maybe you need to suffix
it with "-audio", like the existing compatible string for audio in this
driver.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
