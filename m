From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 02/10] i2c: OMAP: Add DT support for i2c controller
Date: Wed, 4 Jan 2012 11:08:02 -0700
Message-ID: <20120104180802.GI15503@ponder.secretlab.ca>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-3-git-send-email-b-cousson@ti.com>
 <87hb14q7vj.fsf@ti.com>
 <4F0455D8.7060904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43766 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756813Ab2ADTG1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jan 2012 14:06:27 -0500
Received: by mail-vw0-f46.google.com with SMTP id fc26so13621965vbb.19
        for <linux-omap@vger.kernel.org>; Wed, 04 Jan 2012 11:06:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F0455D8.7060904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jan 04, 2012 at 02:36:24PM +0100, Cousson, Benoit wrote:
> Hi Kevin,
> 
> On 12/14/2011 2:06 AM, Kevin Hilman wrote:
> >Benoit Cousson<b-cousson@ti.com>  writes:
> >
> >>Add initial DT support to retrieve the frequency using a
> >>DT attribute instead of the pdata pointer if of_node exist.
> >>
> >>Add documentation for omap i2c controller binding.
> >>
> >>Based on original patches from Manju and Grant.
> >>
> >>Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> >>Cc: Ben Dooks<ben-linux@fluff.org>
> >
> >This seems indepenent from the rest of the series, and I can queue up
> >for merge via the I2C tree.
> >
> >Benoit, please confirm that we shouldn't have any problems if this patch
> >goes independently.
> >
> >Grant/Rob, with your ack on the bindings, I can queue this up for the
> >I2C maintainers along with some other OMAP I2C changes for v3.3.
> 
> I removed the nasty bindings and got the Reviewed-by: from Rob for
> the v4 [1].
> 
> Could you take it in your branch? I've just tried merging your
> for_3.3/i2c/misc on top of my for_3.3/3_omap_dt_i2c_twl branch and
> tested it successfully on OMAP4 DT boot.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> 
> Thanks,
> Benoit
> 
> 
> [1] http://lkml.org/lkml/2011/12/22/176
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
