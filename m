From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/13] OMAP: Basic DVFS Framework
Date: Tue, 25 Jan 2011 05:53:59 +0200
Message-ID: <20110125035358.GC2588@legolas.emea.dhcp.ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
 <20110122171805.GA14774@legolas.emea.dhcp.ti.com>
 <87fwsi9imo.fsf@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:60622 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751612Ab1AYDyH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 22:54:07 -0500
Received: by mail-gw0-f42.google.com with SMTP id 23so2601075gwj.15
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 19:54:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87fwsi9imo.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: balbi@ti.com, Vishwanath BS <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org, patches@linaro.org

Hi,

On Mon, Jan 24, 2011 at 12:00:47PM -0800, Kevin Hilman wrote:
> This layer should not be used by drivers, and is OMAP specific.
> 
> The generic interfaces to DVFS for drivers and other kernel code are
> CPUfreq and the regulator framework.

Ok, now it makes sense. Thanks for the info :-)

-- 
balbi
