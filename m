From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [GIT PULL] Immutable branch between MFD, GPIO and Regulator due
 for the v4.9 merge window
Date: Wed, 31 Aug 2016 16:21:09 +0100
Message-ID: <20160831152109.GQ9415@dell>
References: <1472633892-8261-1-git-send-email-j-keerthy@ti.com>
 <20160831122435.GD9415@dell>
 <8e1378ce-b757-39f9-7c36-707f2d9db21e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8e1378ce-b757-39f9-7c36-707f2d9db21e@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, broonie@kernel.org, linus.walleij@linaro.org, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 31 Aug 2016, Keerthy wrote:

> On Wednesday 31 August 2016 05:54 PM, Lee Jones wrote:
> > Enjoy!
> 
> Thanks! Just curious to know where to pull the below patch from:
> 
> https://patchwork.kernel.org/patch/9266665/
> 
> I checked in couple of other branches in your tree could not find the above
> patch.

The name has changed.  Pull my MFD branch and look for:

  ea7f225 Documentation: mfd: Add DT bindings for the LP873X

> > The following changes since commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d:
> > 
> >   Linux 4.8-rc2 (2016-08-14 19:11:36 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-regulator-v4.9
> > 
> > for you to fetch changes up to f618ed218dc01207882a8f02b1310c7daaf5156a:
> > 
> >   regulator: lp873x: Change the MFD config option as per latest naming (2016-08-31 13:20:44 +0100)
> > 
> > ----------------------------------------------------------------
> > Immutable branch between MFD, GPIO and Regulator due for the v4.9 merge window
> > 
> > ----------------------------------------------------------------
> > Keerthy (3):
> >       mfd: lp873x: Add lp873x PMIC support
> >       gpio: lp873x: Add support for General Purpose Outputs
> >       regulator: lp873x: Change the MFD config option as per latest naming
> > 
> >  drivers/gpio/Kconfig       |  10 ++
> >  drivers/gpio/Makefile      |   1 +
> >  drivers/gpio/gpio-lp873x.c | 193 ++++++++++++++++++++++++++++++++
> >  drivers/mfd/Kconfig        |  14 +++
> >  drivers/mfd/Makefile       |   2 +
> >  drivers/mfd/lp873x.c       |  99 +++++++++++++++++
> >  drivers/regulator/Kconfig  |   2 +-
> >  include/linux/mfd/lp873x.h | 269 +++++++++++++++++++++++++++++++++++++++++++++
> >  8 files changed, 589 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/gpio/gpio-lp873x.c
> >  create mode 100644 drivers/mfd/lp873x.c
> >  create mode 100644 include/linux/mfd/lp873x.h
> > 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
