From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: [PATCH] spi/omap2: Let device core handle pinctrl
Date: Tue, 7 May 2013 10:47:31 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EBE4E07@DBDE04.ent.ti.com>
References: <1367868998-12667-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EBE473A@DBDE04.ent.ti.com>
 <20130507085535.GN7478@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130507085535.GN7478@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, May 07, 2013 at 14:25:35, Mark Brown wrote:
> On Tue, May 07, 2013 at 03:56:09AM +0000, Hebbar, Gururaja wrote:
> 
> > There are cases where driver('s) needs to place pin-mux's to sleep on suspend
> > & default/idle on resume. For such cases Pinctrl needs to be handled inside 
> > the driver. Example [1].
> 
> Well, obviously - but at the minute the driver is pure boilerplate.

Correct. 

> There's also been some discussion about factoring out the suspend/resume
> code since it's going to get equally repetitive.

Really. Any link/referenceso that I can follow.
But I think each module will have its own work to do. May be I can confirm once 
I look at the factoring-out discussion.

> 
> > I will be submitting a patch to enhance the existing pinctrl support for 
> > spi omap2 shortly which does above work.
> 
> How soon is shortly?

Since I am adding this Pinctrl PM mode support to many other drivers (i2c, 
cpsw, da8xx-fb, hsmmc, ti-pwm, usb ...), I would say Shortly = 1 week - 10 days.

> 


Regards, 
Gururaja
