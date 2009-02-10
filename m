From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ASoC: Replace snd_soc_machine by snd_soc_card structure
 in SDP3430 machine driver
Date: Tue, 10 Feb 2009 09:51:46 +0200
Message-ID: <20090210095146.63a77c83.jarkko.nikula@nokia.com>
References: <2C7D3DF36ADFFC479B44490D912B616705D6175398@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:63650 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbZBJHvo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 02:51:44 -0500
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705D6175398@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel-request@alsa-project.org" <alsa-devel-request@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nagalla, Hari" <hnagalla@ti.com>

On Tue, 10 Feb 2009 00:57:00 +0100
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
Looks like you haven't subscribed to alsa-devel since I don't see your
patch there? You can subscribe but have mail delivery disabled if you
don't want to get mailing list traffic to your account.

Patch itself looks like for 2.6.29-rc since it fixes a compilation
error. Ack from me, compile tested on linux-omap.

Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
