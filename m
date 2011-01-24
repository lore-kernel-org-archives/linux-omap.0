From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/13] OMAP: Basic DVFS Framework
Date: Mon, 24 Jan 2011 17:29:24 +0200
Message-ID: <20110124152924.GB2838@legolas.emea.dhcp.ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
 <20110122171805.GA14774@legolas.emea.dhcp.ti.com>
 <08a041d030691db0dd00737a6342d3d1@mail.gmail.com>
 <20110124061847.GH2756@legolas.emea.dhcp.ti.com>
 <f5a0abe43775faf0ecbb4cf08c842bb7@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:55137 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752993Ab1AXP3c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 10:29:32 -0500
Received: by mail-vw0-f45.google.com with SMTP id 12so1750708vws.18
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 07:29:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <f5a0abe43775faf0ecbb4cf08c842bb7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, patches@linaro.org

Hi,

On Mon, Jan 24, 2011 at 07:55:21PM +0530, Vishwanath Sripathy wrote:
> It is not just implementation. Even the underlying design of DVFS is
> closely coupled with these layers. If we try to split this DVFS framework
> into generic and OMAP specific part, then the flow will become too
> cumbersome since there are will be too many interactions between common
> and OMAP part. Also it will reduce the code readability aspect as well.
> I do not think it's worth adding some much of complexity and effort just
> to avoid a driver using platform specific function pointers to call these
> APIs.

if what you're saying was really true then we wouldn't have generic
clock API, pm_runtime, pm QoS, CPUFreq, CPUIdle, etc etc. Those are very
much coupled with the underlying Hardware. In fact, every single thing
is very much coupled with the underlying hardware. And even so we manage
to have all of the above plus GPIOLIB, generic IRQ handling (even
threaded), DMA API (which we don't use yet), etc etc etc.

So, IMHO, being coupled to underlying HW is not excuse for not making a
generic API, quite the opposite actually, it should be a motivation.

-- 
balbi
