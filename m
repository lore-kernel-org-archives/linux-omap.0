From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCHv3 00/20] OMAP ASoC changes in DMA utilization
Date: Mon, 17 Aug 2009 11:22:30 +0300
Message-ID: <200908171122.30731.peter.ujfalusi@nokia.com>
References: <1250174133-451-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:20855 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757223AbZHQIWp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 04:22:45 -0400
In-Reply-To: <1250174133-451-1-git-send-email-eduardo.valentin@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>

On Thursday 13 August 2009 17:35:13 Valentin Eduardo (Nokia-D/Helsinki) wrote:
> Hello again guys,
>
> Here is version 3 of these changes. I've changed just 2
> things:
> - all mcbsp instances are in element mode by default
> - moved all mcbsp related code to omap-mcbsp.c
> (although a single callback is still needed)
>
> Jarkko, I think we can add your patch for reading strings
> for dma op mode later on.

In my opinion we can take this series as it is now, what do you think Jarkko?
At least I don't see too (any?) big problems with it...


Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

