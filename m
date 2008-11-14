From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: Re: [PATCH] HSMMC: Add MMC configuration for pandora
Date: Fri, 14 Nov 2008 22:57:41 +0200
Message-ID: <6ed0b2680811141257g66f451b6k51c9b9c97e67a71b@mail.gmail.com>
References: <1226691917-6577-1-git-send-email-notasas@gmail.com>
	 <1226691917-6577-2-git-send-email-notasas@gmail.com>
	 <200811141211.23183.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:5477 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbYKNU5n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 15:57:43 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1763318ugf.37
        for <linux-omap@vger.kernel.org>; Fri, 14 Nov 2008 12:57:41 -0800 (PST)
In-Reply-To: <200811141211.23183.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Fri, Nov 14, 2008 at 10:11 PM, David Brownell <david-b@pacbell.net> wrote:
> On Friday 14 November 2008, Grazvydas Ignotas wrote:
>> This patch enables both SD slots with support of card detect and
>> write protect switch on OMAP3 Pandora.
>
> Nice milestone for a Friday.  :)
May be, but it still needs some nasty hack in the host driver to work.
The driver relies on voltage setting in the host controller register,
but that is fixed to 1.8V for MMC2 and doesn't represent real voltage
used for the card.

> Weren't you working on getting the SDIO WLAN adapter on the third
> slot to behave too?
yeah, not much progress with that yet, though..
