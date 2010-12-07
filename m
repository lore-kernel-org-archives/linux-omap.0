From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] ARM: OMAP: Power on EHCI, serial, camera and DVI on beagleboard-xM
Date: Tue, 7 Dec 2010 13:54:08 +0100
Message-ID: <9A47352A-51AB-47B8-BFD8-82DA62F11A55@dominion.thruhere.net>
References: <1291725639-86397-1-git-send-email-koen@beagleboard.org>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45939 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091Ab0LGMyM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 07:54:12 -0500
Received: by wwa36 with SMTP id 36so14106524wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 04:54:10 -0800 (PST)
In-Reply-To: <1291725639-86397-1-git-send-email-koen@beagleboard.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>


Op 7 dec 2010, om 13:40 heeft Koen Kooi het volgende geschreven:
> 
> +	/* Power on camera interface on P7/P8 or DVI on A2 and beyond */
> +	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
> +		gpio_request(gpio + 2, "CAM_EN");
> +		gpio_direction_output(gpio + 2, 1);
> +	}


For people testing this patch, you won't get DVI working properly till you apply this patch:

http://sakoman.com/cgi-bin/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=9fd4ea134e6282be6ceb06a8d79a3b07af2297ae

regards,

Koen