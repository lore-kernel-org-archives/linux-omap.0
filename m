From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCHv2 0/2] DT support for isp1704-charger
Date: Mon, 23 Dec 2013 18:35:16 -0800
Message-ID: <20131224023515.GD10223@lizard>
References: <20131114175227.GH10317@atomide.com>
 <1385859611-26532-1-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:33914 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737Ab3LXCkc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Dec 2013 21:40:32 -0500
Received: by mail-pb0-f41.google.com with SMTP id jt11so5938239pbb.14
        for <linux-omap@vger.kernel.org>; Mon, 23 Dec 2013 18:40:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1385859611-26532-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>

On Sun, Dec 01, 2013 at 02:00:09AM +0100, Sebastian Reichel wrote:
> This is the second iteration of the isp1704 DT patches.
> 
> Changes since v1:
>  * reword the binding documentation slightly according
>    to the suggestions of Mark Rutland
>  * keep supporting the set_power callback and leave the
>    board code in its current state. This solves potential
>    merge problems. The additional code can be removed in
>    the next merge window.

Applied, thanks a lot!

Anton
