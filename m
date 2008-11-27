From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Provide the set_power at TWL4030 MMC
Date: Thu, 27 Nov 2008 09:12:11 -0800
Message-ID: <200811270912.11557.david-b@pacbell.net>
References: <20081127075345.GA17896@july>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:48520 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751868AbYK0RMO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Nov 2008 12:12:14 -0500
In-Reply-To: <20081127075345.GA17896@july>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-omap@vger.kernel.org

On Wednesday 26 November 2008, Kyungmin Park wrote:
> Custom board powered by VAUX2 and VAUX4 for MMC instead of VMMC
> Also it uses VMMC for MMC core power not voltage.
> 
> MMC1: uses VMMC1(voltage) and VMMC2(Vdd)
> MMC2: uses VAUX2(voltage) and VAUX4(Vdd)
> 
> To address this issue, platform uses its custom power function.

It would be a lot cleaner to do this with the regulator
framework ... e.g. board init code associates each MMC
controller with a few regulators using logical IDs, and
the HSMMC glue just uses those regulators.

- Dave
