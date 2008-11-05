From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [REVIEW  PATCH 8/9] DSS: support for Beagle Board
Date: Wed, 5 Nov 2008 12:27:25 +0200
Message-ID: <20081105122725.cb1c0b2f.jarkko.nikula@nokia.com>
References: <20081104160946.19071.44903.stgit@tubuntu>
	<20081104161038.19071.98198.stgit@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31542 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756329AbYKEK2R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 05:28:17 -0500
In-Reply-To: <20081104161038.19071.98198.stgit@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

On Tue, 04 Nov 2008 18:10:38 +0200
"ext Tomi Valkeinen" <tomi.valkeinen@nokia.com> wrote:

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
> 
>  arch/arm/mach-omap2/board-omap3beagle.c |  121 ++++++++++++++++++++++++++++---
>  1 files changed, 108 insertions(+), 13 deletions(-)
> 
> +static void __init beagle_display_init(void)
> +{
> +	int r;
> +
> +	r = gpio_request(beagle_display_data_dvi.panel_reset_gpio, "DVI reset GPIO");
> +	if(r < 0) {

GPIO label "DVI reset" is enough.


Jarkko
