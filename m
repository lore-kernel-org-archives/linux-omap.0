From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/13] OMAP: Basic DVFS Framework
Date: Mon, 24 Jan 2011 12:00:47 -0800
Message-ID: <87fwsi9imo.fsf@ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
	<20110122171805.GA14774@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:54265 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750735Ab1AXUAu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 15:00:50 -0500
Received: by mail-pw0-f46.google.com with SMTP id 3so899744pwj.33
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 12:00:50 -0800 (PST)
In-Reply-To: <20110122171805.GA14774@legolas.emea.dhcp.ti.com> (Felipe Balbi's
	message of "Sat, 22 Jan 2011 19:18:05 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Vishwanath BS <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org, patches@linaro.org

Felipe Balbi <balbi@ti.com> writes:

> Hi,
>
> On Fri, Jan 21, 2011 at 07:30:52PM +0530, Vishwanath BS wrote:
>> This patch series introduces support for Dynamic Voltage and Frequency Scaling
>> (DVFS) for OMAP devices. 
>> 
>> For detailed design details, refer to DVFS Documentation.
>
> If this is supposed to be used by drivers I would rather not as it's yet
> another OMAP-specific API to use.

This layer should not be used by drivers, and is OMAP specific.

The generic interfaces to DVFS for drivers and other kernel code are
CPUfreq and the regulator framework.

Kevin
