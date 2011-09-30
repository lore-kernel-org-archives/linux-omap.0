From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/9] Device tree support for regulators
Date: Thu, 29 Sep 2011 19:39:05 -0600
Message-ID: <20110930013905.GJ12606@ponder.secretlab.ca>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44177 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479Ab1I3FE7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Sep 2011 01:04:59 -0400
Received: by yxl31 with SMTP id 31so1267752yxl.19
        for <linux-omap@vger.kernel.org>; Thu, 29 Sep 2011 22:04:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1317118372-17052-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: broonie@opensource.wolfsonmicro.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org

On Tue, Sep 27, 2011 at 03:42:43PM +0530, Rajendra Nayak wrote:
> Hi Mark, Grant,
> 
> This is a respin of my RFC series I posted sometime back
> and is now based on top of the latest omap i2c-twl support
> series posted by Benoit
> git://gitorious.org/omap-pm/linux.git for_3.2/4_omap_dt_i2c_twl
> 
> some changes done since the RFC:
> 1. twl driver fixed to remove hardcoded board params
> 2. regulator helpers moved from drivers/of to drivers/regulator
> 3. Better compatible definitions for specific device type
> 4. twl regulator driver doing internal table lookup based on
> compatible rather then pdev->id
> 5. Seperate fixed voltage regulator bindings defined
> 6. Changed the way devices associate with regulators
> i.e using <name>-supply = <&regulator-phandle>;

Overall looks fairly good other than the comments made by Mark and myself.

g.

