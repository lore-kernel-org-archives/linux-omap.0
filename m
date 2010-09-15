From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH v5 6/6] OMAP: WDT: Use PM runtime APIs instead of clk
	FW APIs
Date: Wed, 15 Sep 2010 20:40:29 +0200
Message-ID: <20100915184029.GW354@infomag.iguana.be>
References: <1284528403-6494-1-git-send-email-charu@ti.com> <1284528403-6494-7-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:53710 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754768Ab0IOSkb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Sep 2010 14:40:31 -0400
Content-Disposition: inline
In-Reply-To: <1284528403-6494-7-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: tony@atomide.com, linux-watchdog@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, linux-omap@vger.kernel.org

Hi All,

> Call runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_sync()
> for enabling/disabling the clocks, sysconfig settings instead of using
> clock FW APIs.
> 
> Signed-off-by: Charulatha V <charu@ti.com>

This is all omap specific code. So if Kevin and Tony are fine with the code then tou gave my ACK also.

Kind regards,
WIm.

