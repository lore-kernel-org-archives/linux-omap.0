From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: FSUSB Register access
Date: Tue, 4 Nov 2008 16:35:26 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE89671620369A1F136@dlee02.ent.ti.com>
References: <20081104160946.19071.44903.stgit@tubuntu>
 <20081104161038.19071.98198.stgit@tubuntu>
 <9D31108D62FAE54AA21AEF899D69931E0385A99E@AZ25EXM04.gddsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44155 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000AbYKDWff convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Nov 2008 17:35:35 -0500
In-Reply-To: <9D31108D62FAE54AA21AEF899D69931E0385A99E@AZ25EXM04.gddsi.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "York, Jeffrey-P56387" <Jeff.York@gdc4s.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of York, Jeffrey-P56387

> I am using Montavista Mobilinux 5 on OMAP2430 and I am trying to access
> the FSUSB register set and the kernel halts upon any attempt to access
> any of the registers in the FSUSB.

I seem to recall this mixed MUSB + FUSB was functional in ML4.1.  If you have access you might check the older code.

Regards,
Richard W.
