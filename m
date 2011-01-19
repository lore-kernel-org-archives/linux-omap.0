From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC 1/3] OMAP: clocks: Use clk names instead of clk pointers
Date: Wed, 19 Jan 2011 17:19:24 +0200
Message-ID: <20110119151924.GA3552@legolas.emea.dhcp.ti.com>
References: <1295446466-23655-1-git-send-email-rnayak@ti.com>
 <1295446466-23655-2-git-send-email-rnayak@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:51866 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754479Ab1ASPTd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 10:19:33 -0500
Received: by mail-pz0-f49.google.com with SMTP id 30so300081pzk.22
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 07:19:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1295446466-23655-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@deeprootsystems.com

On Wed, Jan 19, 2011 at 07:44:24PM +0530, Rajendra Nayak wrote:
> There are various instances of clk pointers being
> embedded within structures in the clock framework
> to refer to clk parents, reference clocks, bypass
> clocks etc.
> The right way to reference these is by their name
> and not by embedding direct pointers to these clks.
> 
> Hence make provision to be able to provide clock
> names to refer to parents and bypass/ref clks and
> populate the clk pointers at runtime.
> 
> This requires the const qualifier to be dropped for
> struct clksel within struct clk and hence needs 
> clksel struct definitions to be changed in all
> clock*_data.c files.

$SUBJECT and this commit log is completely wrong as this patch is only
dropping the const from the clock structures.

-- 
balbi
