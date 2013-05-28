From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH v3 0/5] ARM: dts: OMAP2+: use preprocessor for device
 trees
Date: Tue, 28 May 2013 10:41:20 +0200
Message-ID: <51A46DB0.5020508@epfl.ch>
References: <1369666354-29152-1-git-send-email-florian.vaussard@epfl.ch>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:50604 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933529Ab3E1IlY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 May 2013 04:41:24 -0400
In-Reply-To: <1369666354-29152-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org


On 05/27/2013 04:52 PM, Florian Vaussard wrote:
> Hello,
>
> Following a similar proposal by Stephen Warren for tegra [1], this series
> makes use of the C preprocessor when compiling OMAP DT files, and
> accomplishes some improvements to improve overall readability.
>

I realized that I should also address am* devices. I will wait for comments
on this version, then post a v4. Sorry for the noise.

Regards,

Florian
