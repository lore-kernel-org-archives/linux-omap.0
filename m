From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] USB: GADGET: Fix compile breakage on omap_udc.c
Date: Tue, 18 Mar 2008 11:19:13 +0200
Message-ID: <20080318091913.GG20921@atomide.com>
References: <1205783450-16673-1-git-send-email-me@felipebalbi.com> <1205783450-16673-2-git-send-email-me@felipebalbi.com> <1205783450-16673-3-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:55865 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbYCRJTz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2008 05:19:55 -0400
Content-Disposition: inline
In-Reply-To: <1205783450-16673-3-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [080317 21:50]:
> Recent changes broke compilation for omap_udc.c.
> 
> Signed-off-by: Felipe Balbi <me@felipebalbi.com>
> ---
>  drivers/usb/gadget/omap_udc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
> index 85a0d1a..9aa5946 100644
> --- a/drivers/usb/gadget/omap_udc.c
> +++ b/drivers/usb/gadget/omap_udc.c
> @@ -2299,7 +2299,7 @@ static int proc_otg_show(struct seq_file *s)
>  		 * do with the frame adjustment counter and McBSP2.
>  		 */
>  		ctrl_name = "control_devconf";
> -		trans = ctrl_read_reg(OMAP2_CONTROL_DEVCONF0);
> +		trans = omap_ctrl_readb(OMAP2_CONTROL_DEVCONF0);
>  	} else {
>  		ctrl_name = "tranceiver_ctrl";
>  		trans = USB_TRANSCEIVER_CTRL_REG;

Pushing today.

Tony
