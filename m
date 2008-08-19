From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 2/3] usb: musb: pass configuration specifics via pdata
Date: Tue, 19 Aug 2008 07:21:21 -0700
Message-ID: <5e088bd90808190721i7a2cf809r95723434ea472e2f@mail.gmail.com>
References: <1218648977-5685-1-git-send-email-felipe.balbi@nokia.com>
	 <1218648977-5685-2-git-send-email-felipe.balbi@nokia.com>
	 <1218648977-5685-3-git-send-email-felipe.balbi@nokia.com>
	 <5e088bd90808181643x2fa0c192wefe8eeff7c507f1b@mail.gmail.com>
	 <20080819093903.GB23346@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.251]:60069 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbYHSOVX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 10:21:23 -0400
Received: by hs-out-0708.google.com with SMTP id 4so718812hsl.5
        for <linux-omap@vger.kernel.org>; Tue, 19 Aug 2008 07:21:22 -0700 (PDT)
In-Reply-To: <20080819093903.GB23346@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> It's default for SOC- and for TUSB-based musb boards. Last time i sent
> this patch as RFC I asked people to test and everybody (including
> beagleboard people) had reported it was ok.

I've been testing it on the Gumstix Overo board (with no board
specific platform-data) and have also seen no issues.

I asked because I had noticed that a few people reported USB issues on
the #beagle irc channel.  One specifically mentioned that this patch
caused his issue.  So I just wanted to verify that board specific
platform data was not required for all omap3 boards.

Thanks,

Steve
