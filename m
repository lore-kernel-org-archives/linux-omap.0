From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 09/11] DT: regulator: Helper to extract regulator
 node based on supply name
Date: Thu, 15 Sep 2011 16:50:35 -0600
Message-ID: <20110915225035.GP3523@ponder.secretlab.ca>
References: <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
 <1316085727-15023-4-git-send-email-rnayak@ti.com>
 <1316085727-15023-5-git-send-email-rnayak@ti.com>
 <1316085727-15023-6-git-send-email-rnayak@ti.com>
 <1316085727-15023-7-git-send-email-rnayak@ti.com>
 <1316085727-15023-8-git-send-email-rnayak@ti.com>
 <1316085727-15023-9-git-send-email-rnayak@ti.com>
 <1316085727-15023-10-git-send-email-rnayak@ti.com>
 <20110915135416.GN7988@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:64126 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935230Ab1IOWuj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Sep 2011 18:50:39 -0400
Received: by gwb17 with SMTP id 17so3818009gwb.1
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 15:50:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110915135416.GN7988@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Rajendra Nayak <rnayak@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Thu, Sep 15, 2011 at 02:54:16PM +0100, Mark Brown wrote:
> On Thu, Sep 15, 2011 at 04:52:05PM +0530, Rajendra Nayak wrote:
> 
> > 		regulator = <&regulator1>,<&regulator2>;
> > 		regulator-names = "supply1","supply2";
> > 	};
> 
> This syntax is really painful - we're relying on keeping two arrays in
> sync which isn't good for legibility or robustness.  I'd expect
> something like having a property with the supply name referencing the
> regulator node concerned like:
> 
> 	dbvdd = <&regulator1>;
> 	dcvdd = <&regulator2>;
> 
> or something.  Keeping the two arrays separate doesn't seem great.

We've got two competing approaches here.  For reg and interrupts, the
proposal on the table that we talked about at LPC is to do reg-names
and interrupts-names so as to preserve the existing semantics of the
reg and interrupts properties.  For gpios we're using the binding
"<name>-gpios" for named gpio references.  There isn't the same
pressure to preserve existing bindings in that case.  I'm okay with
either approach, providing that "-regulator" is encoded into the name.

g.

