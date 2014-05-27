From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] ARM: dts: OMAP3 a83x: fix duplicate usb pin config
Date: Tue, 27 May 2014 13:40:25 -0700
Message-ID: <20140527204025.GD32336@atomide.com>
References: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
 <1400799986-20043-6-git-send-email-chf.fritz@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54292 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbaE0Uka (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 May 2014 16:40:30 -0400
Content-Disposition: inline
In-Reply-To: <1400799986-20043-6-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Pekon Gupta <pekon@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Christoph Fritz <chf.fritz@googlemail.com> [140522 16:07]:
> Node usbhshost is supporting pinctrl, so the deprecated
> quirk call can be removed.

Applying this too into omap-for-v3.16/dt-v2 thanks.

Tony
