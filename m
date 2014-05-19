From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: dts: Enable mcpdm and mcbsp1 on DuoVero
Date: Mon, 19 May 2014 15:16:12 -0700
Message-ID: <20140519221612.GJ11945@atomide.com>
References: <1400328420-28384-1-git-send-email-manabian@gmail.com>
 <1400328420-28384-2-git-send-email-manabian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50145 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750852AbaESWQQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 18:16:16 -0400
Content-Disposition: inline
In-Reply-To: <1400328420-28384-2-git-send-email-manabian@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org, florian.vaussard@epfl.ch

* Joachim Eastwood <manabian@gmail.com> [140517 05:08]:
> Since commit 7adb0933b18debef3 (ARM: dts: omap4: Set all audio related
> IP's status to disabled as default) all audio related device are
> disabled by default. Most boards were updated to enable devices
> explicitly, but DuoVero was missed.

OK
 
> mcpdm is used for twl6040 and mcbsp1 is used for BlueTooth audio.

OK, applying into omap-for-v3.16/dt.

Tony
