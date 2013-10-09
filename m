From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: pdata-quirks: add legacy display init
 for IGEPv2 board
Date: Wed, 09 Oct 2013 09:36:26 +0200
Message-ID: <5255077A.4010702@collabora.co.uk>
References: <1380941496-26899-1-git-send-email-javier.martinez@collabora.co.uk> <20131008211108.GQ8313@atomide.com> <5254F15B.5050207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:42026 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab3JIHhF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 03:37:05 -0400
In-Reply-To: <5254F15B.5050207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org

On 10/09/2013 08:02 AM, Tomi Valkeinen wrote:
> Hi Tony,
> 
> On 09/10/13 00:11, Tony Lindgren wrote:
>> * Javier Martinez Canillas <javier.martinez@collabora.co.uk> [131004 20:00]:
>>> IGEPv2 board has both an DVI and TFP410 video interfaces but
>>> DSS support for DeviceTree has not yet landed in mainline so
>>> is necessary to init the displays using legacy platform code.
>> 
>> Thanks, applying into omap-for-v3.13/quirk.
> 
> Can you remove the patch from your branch? It had bug, and I had some
> questions related to it.
> 
>  Tomi
> 
> 

Hi Tomi,

I noticed about the bug (a duplicated pdata_quirks) just after sending the patch
so I fixed on a v2 [1].

Thanks a lot and best regards,
Javier

[1]: http://www.spinics.net/lists/linux-omap/msg98257.html
