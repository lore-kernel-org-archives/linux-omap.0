From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: tca6416-keypad: Change to module_init()
Date: Wed, 23 Mar 2011 16:20:22 +0000
Message-ID: <20110323162021.GA26594@opensource.wolfsonmicro.com>
References: <20110322143307.GB24004@linux-sh.org>
 <AANLkTimRV9vzOE7+VPX48y3KebLJSvBOkqxoM--9gqGb@mail.gmail.com>
 <20110322153226.GC30303@linux-sh.org>
 <AANLkTimyxdcJ-eEke9x7X1zdiJNbFtncfv0=NzKjtAme@mail.gmail.com>
 <20110322155730.GD30303@linux-sh.org>
 <AANLkTi=Fjc2f837ifH152Rh8W0PfiZvViYaLe=8XZo4Z@mail.gmail.com>
 <20110322163144.GC2202@sirena.org.uk>
 <AANLkTiniBVWhSiNZMRYbO857D_Vj03KxH4qYqkVo-11J@mail.gmail.com>
 <20110322165907.GG22583@opensource.wolfsonmicro.com>
 <AANLkTin1jG36-EsvAk9o-KxdxaBBhx=5Rf+JMidjYqsT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTin1jG36-EsvAk9o-KxdxaBBhx=5Rf+JMidjYqsT@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, dmitry.torokhov@gmail.com, srk@ti.com, khilman@ti.com, chinyeow.sim.xt@renesas.com, linux-sh@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 24, 2011 at 01:04:31AM +0900, Magnus Damm wrote:

> Sounds nice. Hopefully that will allow us to use module_init() in
> drivers instead of other initcall levels depending on bus type.

None of this is anything to do with the bus type - it's to do with the
function of the devices within the system.  Things that are required for
early init of the kernel get bumped up the list.
