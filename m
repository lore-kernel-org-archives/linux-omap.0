From: Chen Peter-B29397 <B29397@freescale.com>
Subject: RE: [RFC PATCH] drivers: phy: add generic PHY framework
Date: Mon, 17 Sep 2012 01:20:19 +0000
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803C82462@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1347623899-14485-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347623899-14485-1-git-send-email-kishon@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, "balbi@ti.com" <balbi@ti.com>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: Zhao Richard-B20223 <B20223@freescale.com>, "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "marex@denx.de" <marex@denx.de>
List-Id: linux-omap@vger.kernel.org

 
> 
> The PHY framework provides a set of API's for the PHY drivers to
> create/remove a PHY and the PHY users to obtain a reference to the PHY
> using or without using phandle. If the PHY users has to obtain a
> reference to
> the PHY without using phandle, the platform specfic intialization code
> (say
> from board file) should have already called phy_bind with the binding
> information. The binding information consists of phy's device name, phy
> user device name and an index. The index is used when the same phy user
> binds to mulitple phys.
> 

What's an example of "the same phy user binds to multiple phys"?
I only remembered that Felipe said there are two phy users for one single phy at 
omap5 that is both usb3 and sata uses the same phy.


 
