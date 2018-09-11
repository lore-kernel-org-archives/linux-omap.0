From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: ti-lmu: constify mfd_cell tables
Date: Tue, 11 Sep 2018 19:13:05 +0100
Message-ID: <20180911181305.GF4185@dell>
References: <20180829093108.GB22065@amd>
 <20180907093954.GA26364@amd>
 <e10bdc74-8138-055e-c829-7befbc7161b4@ti.com>
 <20180911155355.GD4185@dell>
 <a74f7980-08bf-5ef0-106b-1e3f4e90b0e6@ti.com>
 <e8423cfb-2a23-1332-955f-6af5b0ddaecd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e8423cfb-2a23-1332-955f-6af5b0ddaecd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

On Tue, 11 Sep 2018, Dan Murphy wrote:

> Lee
> 
> On 09/11/2018 12:08 PM, Dan Murphy wrote:
> > Lee
> > 
> > On 09/11/2018 10:57 AM, Lee Jones wrote:
> >> On Fri, 07 Sep 2018, Dan Murphy wrote:
> >>
> >>> Pavel
> >>>
> >>> On 09/07/2018 04:39 AM, Pavel Machek wrote:
> >>>> On Wed 2018-08-29 11:31:08, Pavel Machek wrote:
> >>>>> From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >>>>>
> >>>>> mfd: ti-lmu: constify mfd_cell tables
> >>>>>     
> >>>>> Add const attribute to all mfd_cell structures.
> >>>>>     
> >>>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >>>>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >>>>
> >>>> Lee, I guess this is for you to apply. Any news there?
> >>>>
> >>>> There are more patches ready,
> >>>
> >>> As I stated in another email thread.  I don't see the need for this level of LMU framework.
> >>>
> >>> Here is the reference thread
> >>>
> >>> https://lore.kernel.org/patchwork/patch/982550/
> >>
> >> This driver has been present for 1.5 years.
> >>
> >> Is that a NACK for *this* patch or are you hijacking? :)
> >>
> > 
> > Its a NACK for adding this.  I am pushing a new series for the LM3697 and will end up
> > sending LED drivers for the non-MFD devices contained within. I will try to match the
> > feature set the best I can.
> 
> Sorry it is a NACK for adding the backlight series.  This patch is fine.

Ack, thanks for confirming.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
