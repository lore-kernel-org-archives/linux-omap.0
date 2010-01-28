From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] omap: dss2: Reintroduce Overo display support
 (DVI/HDMI)
Date: Thu, 28 Jan 2010 11:31:30 +0200
Message-ID: <1264671090.2701.218.camel@tubuntu.research.nokia.com>
References: <20091125213058.GA4698@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:35865 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab0A1J2j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 04:28:39 -0500
In-Reply-To: <20091125213058.GA4698@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Olof Johansson <olof@lixom.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sakoman@gmail.com" <sakoman@gmail.com>, "tony@atomide.com" <tony@atomide.com>

Hi,

On Wed, 2009-11-25 at 22:30 +0100, ext Olof Johansson wrote:
> Refreshed version of previous patch from Tomi, so keeping his S-o-b.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> ---
> 
> 
> I'm not 100% sure how to wire up the power supplies. I'm still missing
> the one required for VENC to work.

What's the problem with vdda_dac regulator? You can look for an example
from the board-3430sdp.c.

> Tomi, I also noticed that DSS2 seems a bit fragile; if one subsystem
> doesn't initialize properly (VENC in this case), the console doesn't
> come up at all. It would be nice if the rest of the console did come up
> with what was available.

True, there's room for improvement =).

 Tomi


