From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 10/13] OMAP3: Add voltage dependency table for VDD1.
Date: Mon, 31 Jan 2011 07:38:01 -0800
Message-ID: <87sjw99j8m.fsf@ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
	<1295618465-15234-11-git-send-email-vishwanath.bs@ti.com>
	<87hbcsblet.fsf@ti.com>
	<ac935694980943538946b0bf4911af63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:32769 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756023Ab1AaPiI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 10:38:08 -0500
Received: by mail-gw0-f53.google.com with SMTP id 10so2553400gwb.26
        for <linux-omap@vger.kernel.org>; Mon, 31 Jan 2011 07:38:06 -0800 (PST)
In-Reply-To: <ac935694980943538946b0bf4911af63@mail.gmail.com> (Vishwanath
	Sripathy's message of "Sun, 30 Jan 2011 18:29:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Thara Gopinath <thara@ti.com>

Vishwanath Sripathy <vishwanath.bs@ti.com> writes:

[...]

> Regarding 34xx testing, I did try to test it on 3430 SDP. However
> image was not booting up when I used pm branch.  I see that with
> latest pm-core branch image boots up where as with pm branch it does
> not. Is this a known issue?

I don't have a 3430SDP, but it boots for me on 3430/n900, 3530/omap3evm
and 3630/zoom3.

Kevin

