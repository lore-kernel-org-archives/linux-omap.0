From: David Brownell <david-b@pacbell.net>
Subject: Re: omap3evm mmc problem
Date: Sat, 21 Mar 2009 02:34:03 -0700
Message-ID: <200903210234.03670.david-b@pacbell.net>
References: <gq1s6e$ssu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:40656 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753166AbZCUJeJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 21 Mar 2009 05:34:09 -0400
In-Reply-To: <gq1s6e$ssu$1@ger.gmane.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dfoley <dfoley@telus.net>
Cc: linux-omap@vger.kernel.org

On Friday 20 March 2009, dfoley wrote:
> Does anyone else get these mmc errors or know why on the OMAP 3530 Development board ?

Which dev board?  LDP?  EVM?


> mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
> regulator: Unable to get requested regulator: vmmc

Needs patches to setup whichever regulator is used
with the MMC1 controller.  Look at Beagle, Overo,
or SDP for examples...


> mmci-omap-hs mmci-omap-hs.0: err -19 configuring card detect


