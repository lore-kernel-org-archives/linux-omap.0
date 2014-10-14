From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] watchdog: Fix omap watchdogs to enable the magic close
 bit
Date: Tue, 14 Oct 2014 23:09:20 +0300
Message-ID: <20141014200920.GA636@drone.musicnaut.iki.fi>
References: <20141014192518.GH4972@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:43234 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524AbaJNUJ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2014 16:09:29 -0400
Content-Disposition: inline
In-Reply-To: <20141014192518.GH4972@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, Thomas Dziedzic <gostrc@gmail.com>

Hi,

On Tue, Oct 14, 2014 at 12:25:19PM -0700, Tony Lindgren wrote:
> This allows testing the watchdog easily with distros just by
> doing pkill -9 watchdog.
> 
> Reported-by: Thomas Dziedzic <gostrc@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
