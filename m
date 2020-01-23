From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Patch v4 00/10] ARM: dts: dra7: add cal nodes
Date: Thu, 23 Jan 2020 09:26:24 -0800
Message-ID: <20200123172624.GE5885@atomide.com>
References: <20191211140558.10407-1-bparrot@ti.com>
 <20200123171737.GB5885@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:52156 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbgAWR02 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 23 Jan 2020 12:26:28 -0500
Content-Disposition: inline
In-Reply-To: <20200123171737.GB5885@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Parrot <bparrot@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [200123 17:18]:
> * Benoit Parrot <bparrot@ti.com> [191211 06:03]:
> > This patch series adds the needed clkctrl and ty-sysc nodes for CAL module.
> > It also adds support for the module in related dtsi and dts for DRA72,
> > DRA76 and AM654 SoC.
> 
> Applying these into omap-for-v5.6/ti-sysc-dt-cam on top of Tero's
> for-5.6-ti-clk branch. It might be too later for v5.6, but we'll
> see.

Actually I'll leave out the k3-am65 dts changes as I don't see
acks for those. Tero can pick up those later.

Regards,

Tony
