From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ASoC: Replace snd_soc_machine by snd_soc_card structure
 in SDP3430 machine driver
Date: Tue, 10 Feb 2009 11:41:59 +0200
Message-ID: <20090210114159.ed51d30d.jarkko.nikula@nokia.com>
References: <2C7D3DF36ADFFC479B44490D912B616705D6175435@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40353 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbZBJJl5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 04:41:57 -0500
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705D6175435@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nagalla, Hari" <hnagalla@ti.com>

On Tue, 10 Feb 2009 09:05:07 +0100
"ext Lopez Cruz, Misael" <x0052729@ti.com> wrote:

> This patch replaces "snd_soc_machine" structure by "snd_soc_card" in
> SP3430 driver. This change is needed in SDP3430 driver to reflect
> changes introduced by "ASoC: Rename snd_soc_card to snd_soc_machine"
> patch (875065491fba8eb13219f16c36e79a6fb4e15c68).
> 
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> ---
>  sound/soc/omap/sdp3430.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
IMO, this is for 2.6.29-rc since it fixes a compilation error.

Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
