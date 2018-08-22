From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] soc: ti: pm33xx: Enable DS0 for the platforms on which
 it is functional
Date: Wed, 22 Aug 2018 07:22:20 -0700
Message-ID: <20180822142220.GG7523@atomide.com>
References: <1534915951-8783-1-git-send-email-j-keerthy@ti.com>
 <20180822073409.GK14967@localhost>
 <20180822073719.GL14967@localhost>
 <ae71d45f-9260-3547-5ff2-355c084fcf8e@ti.com>
 <20180822084318.GN14967@localhost>
 <335b4efe-ab18-df83-35f2-ee232c09f2e3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <335b4efe-ab18-df83-35f2-ee232c09f2e3@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: Johan Hovold <johan@kernel.org>, d-gerlach@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* J, KEERTHY <j-keerthy@ti.com> [180822 11:11]:
> On 8/22/2018 2:13 PM, Johan Hovold wrote:
> > Yes, and a blacklist would make much more sense for something like this
> > if where talking about specific boards.
>
> Black list is easier here?

After thinking about this a bit more I think the boards supporting
deep sleep should add a PM related dts property to enable deep sleep.

The board maintainers need to test and verify deep sleep for each
board, it's not something that just works for the SoC in general.
Some boards may use different powering for things like DDR where
it's power might be controlled by a GPIO regulator. And in some
cases deeper idle states may depend also on the PMIC being used.

Maybe we already have some dts property we can use to describe
the idle states the board hardware supports?

Regards,

Tony
