From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: [Regression?] Removed regulator support in ehci-omap
Date: Mon, 11 Apr 2011 10:06:22 -0700
Message-ID: <4DA3350E.2060400@gmail.com>
References: <20110411093214.GA18215@rainbow>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110411093214.GA18215@rainbow>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Artamonow <mad_soft@inbox.ru>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/11/11 02:32, Dmitry Artamonow wrote:
> Hi, guys!
> 
> Can anyone explain why regulator support has been removed from ehci-omap
> driver in commit 19403165 ("usb: host: omap: ehci and ohci simplification")[1]?
> In 2.6.37/2.6.38 it was enough to apply simple patch[2] adding regulators
> description to board file to make USB work on omap3evm board (because USB PHY
> is powered via regulator). But now it won't work anymore in 2.6.39-rc2.
> BTW, I suspect that this commit also broke USB on omap3pandora board, as it
> defines "hsusb0" regulator supply in its board file:
> 
Yes, And Beagleboard xm (and I suspect other beagleboard versions) has
been broken in 2.6.39rc1+.

Regards, Steve
