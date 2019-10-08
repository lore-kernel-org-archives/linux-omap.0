From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-sancloud-bbe: Fix PHY mode for ethernet
Date: Tue, 8 Oct 2019 07:23:49 -0700
Message-ID: <20191008142349.GE5610@atomide.com>
References: <20191002095416.19603-1-jhofstee@victronenergy.com>
 <d027ef07-807d-6a7b-2939-b67be4542469@ti.com>
 <436f1712-7dec-db40-d08f-1a3032af3596@victronenergy.com>
 <d85cd860-22a3-6142-7f2d-736a428d7a31@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d85cd860-22a3-6142-7f2d-736a428d7a31@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Jeroen Hofstee <jhofstee@victronenergy.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [191003 02:32]:
> On 03/10/2019 11:16, Jeroen Hofstee wrote:
> > Furthermore 4.19 is fine, so there is no need to include it in stable
> > and have a note to make sure also other patches are required etc.
> 
> Hence all above patches went in 5.1 it would be correct to mention only
> 6d4cd041f0af net: phy: at803x: disable delay only for RGMII mode

Jeroen, can you please send an updated patch with the fixes
tag changed?

Regards,

Tony
