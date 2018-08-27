From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] soc: ti: pm33xx: Enable DS0 for the platforms on which
 it is functional
Date: Mon, 27 Aug 2018 09:05:06 +0200
Message-ID: <20180827070506.GW14967@localhost>
References: <1534915951-8783-1-git-send-email-j-keerthy@ti.com>
 <20180822073409.GK14967@localhost>
 <20180822073719.GL14967@localhost>
 <ae71d45f-9260-3547-5ff2-355c084fcf8e@ti.com>
 <20180822084318.GN14967@localhost>
 <335b4efe-ab18-df83-35f2-ee232c09f2e3@ti.com>
 <20180822142220.GG7523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180822142220.GG7523@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "J, KEERTHY" <j-keerthy@ti.com>, Johan Hovold <johan@kernel.org>, d-gerlach@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 22, 2018 at 07:22:20AM -0700, Tony Lindgren wrote:
> * J, KEERTHY <j-keerthy@ti.com> [180822 11:11]:
> > On 8/22/2018 2:13 PM, Johan Hovold wrote:
> > > Yes, and a blacklist would make much more sense for something like this
> > > if where talking about specific boards.
> >
> > Black list is easier here?
> 
> After thinking about this a bit more I think the boards supporting
> deep sleep should add a PM related dts property to enable deep sleep.
> 
> The board maintainers need to test and verify deep sleep for each
> board, it's not something that just works for the SoC in general.
> Some boards may use different powering for things like DDR where
> it's power might be controlled by a GPIO regulator. And in some
> cases deeper idle states may depend also on the PMIC being used.
> 
> Maybe we already have some dts property we can use to describe
> the idle states the board hardware supports?

Yeah, unless you can infer this from an existing tree I guess you need
to add a new property. And indeed, a driver blacklist would suffer from the
same fundamental problem (with an ever expanding list of machines) as a
whitelist even if it would avoid regressing currently working systems.

Johan
