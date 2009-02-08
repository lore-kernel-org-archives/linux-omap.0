From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] hsmmc: Add MMC3 support
Date: Sun, 8 Feb 2009 11:41:56 -0800
Message-ID: <200902081141.56632.david-b@pacbell.net>
References: <1233050022-5769-1-git-send-email-notasas@gmail.com>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:46108 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752404AbZBHTl6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Feb 2009 14:41:58 -0500
In-Reply-To: <1233050022-5769-1-git-send-email-notasas@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 27 January 2009, Grazvydas Ignotas wrote:
> Device connected to MMC3 is assumed to be self-powered, so
> set_power() function is empty. It can't be omited because
> host driver requires it. Array size for hsmmc[] is specified
> because hsmmc[2].name is needed for MMC3 name.

Just for the record ... this should eventually be handled
using the regulator framework, which will also help with the
decoupling of hsmmc setup from twl4030 setup.

So for example if a given slot is hooked up to an SDIO
chip with a hard-wired 3v3 supply (Pandora MMC3, and
Overo MMC2) then it'd have a fixed voltage regulator;
and the HSMMC driver would just use that.  (It would
get a "can't do that" error on disable though.)

- Dave


> 
> Also fix a leak which happens if invalid controller id
> is passed.
> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
> This patch applies on top of David Brownell's recent 2 patches.


