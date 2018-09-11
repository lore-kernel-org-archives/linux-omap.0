From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: ti-lmu: constify mfd_cell tables
Date: Tue, 11 Sep 2018 16:57:35 +0100
Message-ID: <20180911155355.GD4185@dell>
References: <20180829093108.GB22065@amd>
 <20180907093954.GA26364@amd>
 <e10bdc74-8138-055e-c829-7befbc7161b4@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e10bdc74-8138-055e-c829-7befbc7161b4@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

On Fri, 07 Sep 2018, Dan Murphy wrote:

> Pavel
> 
> On 09/07/2018 04:39 AM, Pavel Machek wrote:
> > On Wed 2018-08-29 11:31:08, Pavel Machek wrote:
> >> From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >>
> >> mfd: ti-lmu: constify mfd_cell tables
> >>     
> >> Add const attribute to all mfd_cell structures.
> >>     
> >> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > 
> > Lee, I guess this is for you to apply. Any news there?
> > 
> > There are more patches ready,
> 
> As I stated in another email thread.  I don't see the need for this level of LMU framework.
> 
> Here is the reference thread
> 
> https://lore.kernel.org/patchwork/patch/982550/

This driver has been present for 1.5 years.

Is that a NACK for *this* patch or are you hijacking? :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
