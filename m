From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP: I2C: prepare to use hwmod reset in driver
Date: Mon, 19 Dec 2011 17:32:20 +0100
Message-ID: <4EEF6714.2040208@ti.com>
References: <alpine.DEB.2.00.1112160254320.12660@utopia.booyaka.com> <20111216195002.GL32251@atomide.com> <alpine.DEB.2.00.1112161314180.12660@utopia.booyaka.com> <20111216204123.GM32251@atomide.com> <alpine.DEB.2.00.1112161357250.12660@utopia.booyaka.com> <20111217002409.GB6464@atomide.com> <4EED9DD4.3020506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50966 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab1LSQc1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 11:32:27 -0500
In-Reply-To: <4EED9DD4.3020506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Shubhro,

On 12/18/2011 9:01 AM, Shubhrajyoti wrote:

[...]

> The driver does a reset in the error path.
> Since we are not supposed to access the sysc reg the function is needed.

I'm just wondering what will happen to the driver if this callback is 
not provided during the device creation? This is what will happen during 
DT boot for example?

Is it a mandatory function?

Thanks,
Benoit
