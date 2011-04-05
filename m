From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2] omap: rx51: Platform support for lp5523 led chip
Date: Tue, 5 Apr 2011 15:03:39 +0300
Message-ID: <20110405120339.GD30505@legolas.emea.dhcp.ti.com>
References: <alpine.DEB.1.10.1103311524420.2634@esdhcp041196.research.nokia.com>
 <1301578692-29286-1-git-send-email-ameya.palande@nokia.com>
 <20110331142635.GF5465@legolas.emea.dhcp.ti.com>
 <4D949E18.6090704@nokia.com>
 <20110331154421.GN5465@legolas.emea.dhcp.ti.com>
 <4D9B044B.7000604@nokia.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:38609 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753041Ab1DEMDo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 08:03:44 -0400
Received: by ewy21 with SMTP id 21so53183ewy.4
        for <linux-omap@vger.kernel.org>; Tue, 05 Apr 2011 05:03:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D9B044B.7000604@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, mathias.nyman@nokia.com, linux-arm-kernel@lists.infradead.org

On Tue, Apr 05, 2011 at 03:00:11PM +0300, Ameya Palande wrote:
> Hi Felipe,
> 
> On 03/31/2011 06:44 PM, ext Felipe Balbi wrote:
> >On Thu, Mar 31, 2011 at 06:30:32PM +0300, Ameya Palande wrote:
> >>Hi Felipe,
> >>
> >>On 03/31/2011 05:26 PM, ext Felipe Balbi wrote:
> >>>Hi,
> >>>
> >>>On Thu, Mar 31, 2011 at 04:38:12PM +0300, Ameya Palande wrote:
> >>>>+static int rx51_lp5523_setup(void)
> >>>>+{
> >>>>+	int err;
> >>>>+
> >>>>+	err = gpio_request_one(RX51_LP5523_CHIP_EN_GPIO, GPIOF_DIR_OUT,
> >>>>+			"lp5523_enable");
> >>>>+	if (err<   0) {
> >>>>+		pr_err("Unable to get lp5523_enable GPIO\n");
> >>>>+		return err;
> >>>>+	}
> >>>>+
> >>>>+	return err;
> >>>
> >>>isn't enough to return gpio_request_one(RX51_LP5523_CHIP_EN_GPIO,
> >>>GPIOF_DIR_OUT, "lp5523_enable"); ??
> >>
> >>But then we won't know the failure reason for lp5523_probe()
> >>I would prefer printing an error!
> >
> >see that both gpio_request() and gpio_direction_output() have debugging
> >prints for error cases ;-)
> 
> Any comments about the version 3 of this patch?

looks good to me. Replied with my Reviewed-by tag.

-- 
balbi
