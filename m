From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH]OMAP3:PM :T2 keypad wakeup for OMAP3
Date: Wed, 4 Nov 2009 19:31:51 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE280371@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9CD4D@dbde02.ent.ti.com>
	<87zl9lfytn.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DE27FC52@dbde02.ent.ti.com>
 <87vdhr8dtm.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44486 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756039AbZKDOBw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Nov 2009 09:01:52 -0500
In-Reply-To: <87vdhr8dtm.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Reddy, Teerth" <teerth@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Wednesday, November 04, 2009 3:35 AM
> To: Premi, Sanjeev
> Cc: Reddy, Teerth; linux-omap@vger.kernel.org
> Subject: Re: [PATCH]OMAP3:PM :T2 keypad wakeup for OMAP3
> 
> "Premi, Sanjeev" <premi@ti.com> writes:
> 
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org 
> >> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> >> Sent: Thursday, August 27, 2009 1:55 PM
> >> To: Reddy, Teerth
> >> Cc: linux-omap@vger.kernel.org
> >> Subject: Re: [PATCH]OMAP3:PM :T2 keypad wakeup for OMAP3
> >> 
> >> Hi Teerth,
> >> 
> >> "Reddy, Teerth" <teerth@ti.com> writes:
> >> 
> >> > From : Teerth Reddy <teerth@ti.com>
> >> >
> >> > This patch changes for setting the padconf value for 
> sys_nirq line
> >> > which is connected to T2 INTR1.  This will fix the T2 
> keypad wakeup
> >> > issue on OMAP3 SDP.
> >> >
> >> > Signed-off-by: Teerth Reddy < teerth@ti.com >
> >> 
> >> Patch looks good, thanks.  I'll pull this into PM branch and queue
> >> in my PM fixes queue for next merge window.
> >> 
> >> I did a minor update by adding a comment in the
> >> enable_board_wakeup_source function stating that this is the
> >> interrupt pin used for T2.
> >> 
> >> Kevin
> >> 
> >
> > Teerth, Kevin,
> >
> > Did you test it with OFF mode enabled?
> 
> I tested on SDP, but not on omap3evm since that was the only board
> file touched by this patch.
> 
> > When I do "echo 1 > /sys/power/enable_off_mode" I don't see 
> resume on the omap3evm.
> >
> > Schematics for the keypad are/seem to be same for EVM and SDP.
> 
> I'm guessing that it's because the patch from Teerth only muxes this
> pin for the SDP.  I'm guessing that doing the same omap_cfg_reg in the
> OMAP3EVM board file will get this working.
> 
> Kevin
> 

Kevin,

I have done the corresponding changes. See:
 1) http://marc.info/?l=linux-omap&m=125725494430834&w=2
 2) http://marc.info/?l=linux-omap&m=125725495630852&w=2
 3) http://marc.info/?l=linux-omap&m=125725498430876&w=2

If I do suspend with OFF mode enabled (enable_off_mode=1), and
all power domains transition to target state, the key press
doesn't resume the system.

But, with this flag off OR any poer domain didn't transition to
the target state. The key press brings system out of 'suspend'.

Best regards,
Sanjeev

> 