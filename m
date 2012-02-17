From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 0/3] omap hsmmc init cleanup and section warning fixes
 for v3.4 merge window
Date: Fri, 17 Feb 2012 15:56:37 +0530
Message-ID: <4F3E2B5D.6040601@ti.com>
References: <20120215182355.18884.18682.stgit@kaulin.local> <CACYZBRE_Vf8qDQYPRgsL03T8oy2Kv4fYRfE8U7y79Xhb1nwC2A@mail.gmail.com> <20120216121234.GJ15338@n2100.arm.linux.org.uk> <4F3CF7D1.8050807@ti.com> <4F3D0186.2010500@ti.com> <20120216135151.GK15338@n2100.arm.linux.org.uk> <20120217091433.GL15338@n2100.arm.linux.org.uk> <4F3E1ED5.6090305@ti.com> <4F3E251B.6040404@ti.com> <20120217100632.GM15338@n2100.arm.linux.org.uk> <4F3E2984.6000201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:54124 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751814Ab2BQK1A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Feb 2012 05:27:00 -0500
Received: by pbbro2 with SMTP id ro2so22108625pbb.30
        for <linux-omap@vger.kernel.org>; Fri, 17 Feb 2012 02:26:58 -0800 (PST)
In-Reply-To: <4F3E2984.6000201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Friday 17 February 2012 03:48 PM, Rajendra Nayak wrote:
>>
>
> Yes, I did get a WARN saying the device is already registered. An
> unregister in my teardown should fix that too.

And now I see there is no way to unregister an omap_device :-)
which needs to be added.
