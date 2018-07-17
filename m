From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] dts/droid4: fix dts w.r.t. pwm
Date: Mon, 16 Jul 2018 23:48:11 -0700
Message-ID: <20180717064811.GA99251@atomide.com>
References: <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
 <20180711142526.dto6iost57zx5t5l@earth.universe>
 <20180716071048.GA23110@amd>
 <20180716101106.vgmjz3ic7gqy2u2q@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180716101106.vgmjz3ic7gqy2u2q@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [180716 10:14]:
> Hi,
> 
> On Mon, Jul 16, 2018 at 09:10:48AM +0200, Pavel Machek wrote:
> > pwm node should not be under gpio6 node in the device tree.
> >    
> > This fixes detection of the pwm on Droid 4.
> >     
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Applying into omap-for-v4.18/fixes thanks.

Tony
