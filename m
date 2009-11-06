From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH]OMAP3:PM :T2 keypad wakeup for OMAP3
Date: Fri, 6 Nov 2009 19:42:10 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE31FB3B@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9CD4D@dbde02.ent.ti.com>
	<87zl9lfytn.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DE27FC52@dbde02.ent.ti.com>
 <87vdhr8dtm.fsf@deeprootsystems.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DE280371@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57978 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757376AbZKFOL6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 09:11:58 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE280371@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Reddy, Teerth" <teerth@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Wednesday, November 04, 2009 7:32 PM
> To: Kevin Hilman
> Cc: Reddy, Teerth; linux-omap@vger.kernel.org
> Subject: RE: [PATCH]OMAP3:PM :T2 keypad wakeup for OMAP3

[snip] --- [snip]

> > > Teerth, Kevin,
> > >
> > > Did you test it with OFF mode enabled?
> > 
> > I tested on SDP, but not on omap3evm since that was the only board
> > file touched by this patch.
> > 
> > > When I do "echo 1 > /sys/power/enable_off_mode" I don't see 
> > resume on the omap3evm.
> > >
> > > Schematics for the keypad are/seem to be same for EVM and SDP.
> > 
> > I'm guessing that it's because the patch from Teerth only muxes this
> > pin for the SDP.  I'm guessing that doing the same 
> omap_cfg_reg in the
> > OMAP3EVM board file will get this working.
> > 
> > Kevin
> > 
> 
> Kevin,
> 
> I have done the corresponding changes. See:
>  1) http://marc.info/?l=linux-omap&m=125725494430834&w=2
>  2) http://marc.info/?l=linux-omap&m=125725495630852&w=2
>  3) http://marc.info/?l=linux-omap&m=125725498430876&w=2
> 
> If I do suspend with OFF mode enabled (enable_off_mode=1), and
> all power domains transition to target state, the key press
> doesn't resume the system.
> 
> But, with this flag off OR any power domain didn't transition to
> the target state. The key press brings system out of 'suspend'.
> 

Can someone with a 3430SDP or ZOOM board try this scenario?

I am trying to understand if it is a generic problem OR specific
to the omap3evm.

Best regards,
Sanjeev
