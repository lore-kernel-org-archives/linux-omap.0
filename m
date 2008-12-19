From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: RE: OMAP: Initialize XCCR and RCCR registers in McBSP DAI driver
Date: Thu, 18 Dec 2008 21:01:39 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705A484AADE@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705A484AAD7@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58456 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752598AbYLSDBu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 22:01:50 -0500
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705A484AAD7@dlee07.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, Jarkko Nikula <jarkko.nikula@nokia.com>

> This patch explicitly initializes McBSP Transmit 
> Configuration Control Register (XCCR) and Receive 
> Configuration Control Register (RCCR) to their reset values. 
> Reset values are 26 ns of DX delay and Transmit DMA disabled 
> for XCCR register; receive full cycle mode enabled and 
> Receive DMA disabled for RCCR register.

ASoC change is now in a separate patch. I'll resend this patch to
alsa-devel mailing list when McBSP change gets accepted.

-Misa