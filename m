From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP HSMMC problems with off-mode
Date: Tue, 7 Dec 2010 16:33:45 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012071627410.13430@utopia.booyaka.com>
References: <alpine.DEB.2.00.1012071101590.13430@utopia.booyaka.com> <4CFE9059.1080202@nokia.com> <AANLkTimKCBm0+NTgJWvyivBqv0DoQhwMbsU2uxruoDot@mail.gmail.com> <alpine.DEB.2.00.1012071548490.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59999 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770Ab0LGXdq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 18:33:46 -0500
In-Reply-To: <alpine.DEB.2.00.1012071548490.13430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sawant@ti.com" <sawant@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>

Hi,

> Looks like 0xfa09c014 is the MMC SYSSTATUS register... maybe there's 
> something wrong with the clock control.

Just sent a patch for this one, it's relatively minor.

After applying it and the 'brutal context save/restore test' patch, HSMMC 
off-mode indeed seems to work much better.

Are there are any remaining fixes that anyone is aware of that need to go 
in for this driver to work reliably in off-mode?  Or is it considered to 
be in good shape for off-mode in mainline once the OMAP PM no-op context 
loss tracking code is fixed?

regards


- Paul
