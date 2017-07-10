From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4.13-rc0: stopped booting on Nokia N900
Date: Mon, 10 Jul 2017 06:46:21 -0700
Message-ID: <20170710134620.GT3730@atomide.com>
References: <20170710074610.GA22846@amd>
 <20170710081334.GA29726@amd>
 <20170710101608.qdamqomegbjwuweh@earth>
 <20170710130602.GS3730@atomide.com>
 <20170710133656.og2egbse5plp3afm@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170710133656.og2egbse5plp3afm@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170710 06:37]:
> Hi,
> 
> On Mon, Jul 10, 2017 at 06:06:03AM -0700, Tony Lindgren wrote:
> > > I just rebased my droid4 development branch. I do not have any
> > > problems with segfaulting toolchain, but boot also fails on OMAP4
> > > based Droid 4. The problem seems to be SPI being accessed without
> > > runtime PM (clocks) being enabled:
> > 
> > Care to check if commit c5b3955828ba ("ARM: OMAP4: Fix legacy code
> > clean-up regression") make that one go away? I have already sent
> > a pull request for that one.
> 
> I bisected to the same commit, that you also found. I just replied
> to Thomas' pull-request from yesterday with bootlog + bisect result
> + info that current master works again after reverting the patch.

Oh OK thanks for clarifying it.

Tony
