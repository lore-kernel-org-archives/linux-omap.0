From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix omapfb's problem on OMAP3430sdp
Date: Tue, 2 Sep 2008 11:14:32 +0300
Message-ID: <20080902081429.GB6928@frodo>
References: <1220276228.2680.9.camel@localhost> <c656a4d20809012249p43213688pce54884c24541fcd@mail.gmail.com> <1220336007.19839.6.camel@localhost>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40260 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbYIBIOs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 04:14:48 -0400
Content-Disposition: inline
In-Reply-To: <1220336007.19839.6.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "stanley.miao" <stanley.miao@windriver.com>
Cc: arun c <arun.edarath@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Sep 02, 2008 at 02:13:27PM +0800, stanley.miao wrote:
> @@ -76,6 +81,11 @@ static int sdp2430_panel_enable(struct lcd_panel
> *panel)
>  {
>  	u8 ded_val, ded_reg;
>  	u8 grp_val, grp_reg;
> +	
> +	if(is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {

	missing space "if ()".

> @@ -104,6 +114,11 @@ static void sdp2430_panel_disable(struct lcd_panel
> *panel)
>  {
>  	omap_set_gpio_dataout(enable_gpio, 0);
>  	omap_set_gpio_dataout(backlight_gpio, 0);

	nothing to do with your patch, but these should be converted to
gpiolib.

> +	if(is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {

missing space again. Please, run scripts/checkpatch.pl --strict patch.diff
before sending your patches so we avoid obvious style mistakes.

-- 
balbi
