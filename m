From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
Date: Mon, 24 Feb 2014 18:03:36 +0000
Message-ID: <20140224180336.GU27282@n2100.arm.linux.org.uk>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch> <1393261669-32039-3-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:49142 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753008AbaBXSDq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Feb 2014 13:03:46 -0500
Content-Disposition: inline
In-Reply-To: <1393261669-32039-3-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Ash Charles <ash@gumstix.com>, linux-arm-kernel@lists.infradead.org

On Mon, Feb 24, 2014 at 06:07:49PM +0100, Florian Vaussard wrote:
> +	hdmi0: connector@0 {
> +		compatible = "hdmi-connector";

This looks way to generic a compatible string.  Are you sure it's
correct?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
