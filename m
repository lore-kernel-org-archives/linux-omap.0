From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [omap-for-linus] Un-used DSS regulator data
Date: Mon, 28 Feb 2011 10:59:52 +0200
Message-ID: <1298883592.9809.1.camel@deskari>
References: <a46904cc06b5f68124e65086b9961d02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60125 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752955Ab1B1I75 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 03:59:57 -0500
In-Reply-To: <a46904cc06b5f68124e65086b9961d02@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Semwal, Sumit" <sumit.semwal@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Hi,

On Mon, 2011-02-28 at 02:50 -0600, Shilimkar, Santosh wrote:
> Tomi/Sumit,
> 
> Today while building Tony's 'omap-for-linus' branch I came
> across below build warning.
> warning: 'sdp3430_vdda_dac_supply' defined but not used
> 
> It seems the DSS regulator data is not being used. Are you missing
> any patch which will use it eventually?

It was an accidental left over from conflict resolving. I have a patch
in DSS tree which removes the regulator supply.

 Tomi


