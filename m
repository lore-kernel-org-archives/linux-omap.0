From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] USB: otg: twl4030: fix phy initialization(v1)
Date: Fri, 10 Sep 2010 15:31:19 +0300
Message-ID: <20100910123119.GB31230@legolas.emea.dhcp.ti.com>
References: <AANLkTiksb1AudCzs8-TWdXb11T-QcPx1G_qu6eUtJ74C@mail.gmail.com>
 <AANLkTin7eVyosgK4XhuB_yqR2ao=YJGVidHB1x2802cr@mail.gmail.com>
 <AANLkTinrecJXH+uDxtBsskFLpBCz0VSZMtSiWGFW9YCr@mail.gmail.com>
 <AANLkTinkhY-y6Qv6HJnGbggksdEmULgQ9DTOrNmu1tLp@mail.gmail.com>
 <AANLkTikZK=8HCtXDR_2dSBce1E10xNfBtyXGOJqykV83@mail.gmail.com>
 <AANLkTin8bXvPqdkYQq++wf0iCK=ZAfZ2jnqbgL=xj8yq@mail.gmail.com>
 <AANLkTimwMiOfvCpUfeXPSF8zh3t3YsM_8nDZbuWFcKM4@mail.gmail.com>
 <AANLkTimBBRC7-kg_L7FpS1E5i63NPMi08g9rrG=jtWeD@mail.gmail.com>
 <20100909060110.GC9098@legolas.emea.dhcp.ti.com>
 <AANLkTin87OTkBrqvStrk61jj8=z75ARBszituZdOQqWE@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52509 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753511Ab0IJMcd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Sep 2010 08:32:33 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin87OTkBrqvStrk61jj8=z75ARBszituZdOQqWE@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: venki kaps <venkiece2005@gmail.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Ming Lei <tom.leiming@gmail.com>, "greg@kroah.com" <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <me@felipebalbi.com>, "Gadiyar, Anand" <gadiyar@ti.com>

Hi,

On Thu, Sep 09, 2010 at 12:28:27PM -0500, venki kaps wrote:
>one thing i have not understood, why it requires to power down when
>the device is booted without
>a USB cable?

why would the phy be powered up for no use ?

>After booting, just attach/detach the usb cable, then i have not seen
>any issue with power numbers in off mode, RETENTION and active states.

that's because if you boot without cable the phy is left alive,
consuming power for nothing.

-- 
balbi
