From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 2/3] McBSP: Provide functions for ASoC frame
 syncronization
Date: Tue, 13 Jan 2009 10:28:42 +0200
Message-ID: <20090113102842.8fa93ecf.jarkko.nikula@nokia.com>
References: <12318331352537-git-send-email-ext-eero.nurkkala@nokia.com>
	<12318331373879-git-send-email-ext-eero.nurkkala@nokia.com>
	<12318331393997-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52061 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402AbZAMI3B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 03:29:01 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0D8Sb4L015336
	for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 10:28:57 +0200
In-Reply-To: <12318331393997-git-send-email-ext-eero.nurkkala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext ext-eero.nurkkala@nokia.com" <ext-eero.nurkkala@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tue, 13 Jan 2009 09:52:14 +0200
"ext ext-eero.nurkkala@nokia.com" <ext-eero.nurkkala@nokia.com> wrote:

> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> 
> ASoC has an annoying bug letting either L or R channel to be
> played on L channel. In other words, L and R channels can
> switch at random. This provides McBSP funtionality that may
> be used to fix this feature.
> 
I can confirm this. Long lasting problem unfortunately not solved yet.
This is visible on 2420 as well so this patch is not enough.

http://marc.info/?l=linux-omap&m=120643770810683&w=2

...
> +void omap_mcbsp_xmit_enable(unsigned int id, u8 enable)
> +{
> +	struct omap_mcbsp *mcbsp;
> +	void __iomem *io_base;
> +	u16 w;
> +
> +	if (!(cpu_is_omap2430() || cpu_is_omap34xx()))
> +		return;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +		return;
> +	}
> +
> +	mcbsp = id_to_mcbsp_ptr(id);
> +	io_base = mcbsp->io_base;
> +
> +	w = OMAP_MCBSP_READ(io_base, XCCR);
> +
> +	if (enable)
> +		OMAP_MCBSP_WRITE(io_base, XCCR, w & ~(XDISABLE));

This doesn't fix problem on 2420. I assume when it works on 2420, the
same fix will fix the 34xx as well. I fear the mcbsp initialization
procedure in omap_mcbsp_start is not correct somewhat for 2420-34xx.


Jarkko
