From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-sancloud-bbe: Fix PHY mode for ethernet
Date: Tue, 8 Oct 2019 09:51:54 -0700
Message-ID: <20191008165154.GH5610@atomide.com>
References: <20191002095416.19603-1-jhofstee@victronenergy.com>
 <d027ef07-807d-6a7b-2939-b67be4542469@ti.com>
 <436f1712-7dec-db40-d08f-1a3032af3596@victronenergy.com>
 <d85cd860-22a3-6142-7f2d-736a428d7a31@ti.com>
 <20191008142349.GE5610@atomide.com>
 <1f779973-1702-47eb-158f-7000770c435a@victronenergy.com>
 <20191008161416.GG5610@atomide.com>
 <4fa5393d-0b2c-4b8c-128a-81ab05a14a82@victronenergy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4fa5393d-0b2c-4b8c-128a-81ab05a14a82@victronenergy.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeroen Hofstee <jhofstee@victronenergy.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Jeroen Hofstee <jhofstee@victronenergy.com> [191008 16:43]:
> Hello Tony,
> 
> On 10/8/19 6:14 PM, Tony Lindgren wrote:
> > * Jeroen Hofstee <jhofstee@victronenergy.com> [191008 16:03]:
> >> Hello Tony,
> >>
> >> On 10/8/19 4:23 PM, Tony Lindgren wrote:
> >>> * Grygorii Strashko <grygorii.strashko@ti.com> [191003 02:32]:
> >>>> On 03/10/2019 11:16, Jeroen Hofstee wrote:
> >>>>> Furthermore 4.19 is fine, so there is no need to include it in stable
> >>>>> and have a note to make sure also other patches are required etc.
> >>>> Hence all above patches went in 5.1 it would be correct to mention only
> >>>> 6d4cd041f0af net: phy: at803x: disable delay only for RGMII mode
> >>> Jeroen, can you please send an updated patch with the fixes
> >>> tag changed?
> >>>
> >> For completeness, there is no "Fixes tag" as you mentioned.
> >> The commit only refers to another commit which introduces
> >> a problem.
> > Well please add the fixes tag, that way this will get
> > properly applied to earlier stable kernels too :)
> 
> But 4.19 is fine, this is an issue in 5.1 as in EOL...
> I really don't understand why I should waste time
> to figure out what happened exactly during the 5.1
> release cycle...

Hmm so what's the issue with just adding the fixes tag Grygorii
suggested:

6d4cd041f0af ("net: phy: at803x: disable delay only for RGMII mode")

No need to dig further?

Regards,

Tony
