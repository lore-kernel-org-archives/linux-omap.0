From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3/3] arm: dts: dra7: fixup qspi entry
Date: Wed, 09 Jul 2014 12:18:30 +0200
Message-ID: <53BD16F6.1030006@linutronix.de>
References: <1404844852-19980-1-git-send-email-bigeasy@linutronix.de> <1404844852-19980-3-git-send-email-bigeasy@linutronix.de> <53BD1444.6080603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39734 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbaGIKSe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2014 06:18:34 -0400
In-Reply-To: <53BD1444.6080603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sourav <sourav.poddar@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

On 07/09/2014 12:07 PM, sourav wrote:
> Hi,

Hello, Sourav,

> The number is correct and is complaining just because the crossbar stuff
> is not
> put in. I had already posted a patch[1] to remove interrupt binding as
> of now.
> 
> Hence, NAK for this patch.

Thank you for explanation. What is the status on the crossbar stuff? Is
this comming any time soon? It seems that it is also stalling the
networking pieces.

> 
> [1]: https://patchwork.kernel.org/patch/4364341/

Sebastian
