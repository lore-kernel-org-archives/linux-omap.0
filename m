From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 0/8] OMAP: OMAP3 DSS related clock patches
Date: Thu, 27 Feb 2014 18:23:55 +0100
Message-ID: <530F74AB.5030109@epfl.ch>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:57608 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753916AbaB0RYA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Feb 2014 12:24:00 -0500
In-Reply-To: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>

Hi Tomi,

On 02/13/2014 11:03 AM, Tomi Valkeinen wrote:
> Hi,
> 
> I've been debugging OMAP3 related issues with DSS clocks, and I hopefully have
> them all fixed with this series. This fixes the problems for both non-DT boot,
> but also for DT boot with DSS DT support (which is not merged yet).
> 
> The non-DT boot related fixes should be merged for 3.14, but I'd like the DT
> boot related fixes to be merged for 3.14 also, as that'll make handling the DSS
> DT support easier.
> 

I hit this issue when developing on top of 3.14-rc4, the DSS failed to
set fck. Your patches made the Overo (both OMAP35xx and OMAP36xx) to get
a working DVI output when booting via DT. And the board did not catch on
fire, contrary to what Mike hopped :)

Tested-by: Florian Vaussard <florian.vaussard@epfl.ch>
