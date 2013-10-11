From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
Date: Fri, 11 Oct 2013 15:53:34 -0700
Message-ID: <20131011225333.GD29913@atomide.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
 <524EE00F.7010208@ti.com>
 <20131007021556.GV8949@atomide.com>
 <52525642.8010307@ti.com>
 <20131007154103.GW8949@atomide.com>
 <20131007190322.GY8949@atomide.com>
 <alpine.DEB.2.02.1310091551540.30199@utopia.booyaka.com>
 <525662A6.4080504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36504 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab3JKWxj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 18:53:39 -0400
Content-Disposition: inline
In-Reply-To: <525662A6.4080504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, mturquette@linaro.org, linux-omap@vger.kernel.org, nm@ti.com, khilman@linaro.org, pdeschrijver@nvidia.com, rnayak@ti.com, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, swarren@nvidia.com, mark.rutland@arm.com

* Tero Kristo <t-kristo@ti.com> [131010 01:25]:
> On 10/09/2013 09:55 PM, Paul Walmsley wrote:
> >So in my view, the right things to do here are to:
> >
> >1. associate SoC DT clock data with the device node that contains the
> >    clock control registers
> 
> So, either "cm", "prcm", and maybe "control_module" instead of
> current "clocks". How much do we benefit from this? This would get
> rid of need to call of_iomap() for each register basically.

It seems that all you need to do for that is to set up two or three
clock driver instances and have the clocks registered under them.

Then later on those can be children of cm, prcm and scm core drivers
as needed without much of an issue.

Regards,

Tony
