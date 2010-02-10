From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: omap3evm: Doesn't boot at 4fa42e46
Date: Thu, 11 Feb 2010 04:28:42 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870300C4D03F@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E263A697@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E26C53A7@dbde02.ent.ti.com>
 <20100210173401.GV21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49661 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640Ab0BJW6y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 17:58:54 -0500
In-Reply-To: <20100210173401.GV21755@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sanjeev/Tony

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony
>Lindgren
>Sent: Wednesday, February 10, 2010 11:34 AM
>To: Premi, Sanjeev
>Cc: linux-omap@vger.kernel.org
>Subject: Re: omap3evm: Doesn't boot at 4fa42e46
>
>* Premi, Sanjeev <premi@ti.com> [100210 09:09]:
>> > -----Original Message-----
>> > From: linux-omap-owner@vger.kernel.org
>> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
>> > Sent: Tuesday, February 09, 2010 9:34 PM
>> > To: linux-omap@vger.kernel.org
>> > Subject: RE: omap3evm: Doesn't boot at 4fa42e46
>> >
>> > > -----Original Message-----
>> > > From: linux-omap-owner@vger.kernel.org
>> > > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>> > Premi, Sanjeev
>> > > Sent: Tuesday, February 09, 2010 9:02 PM
>> > > To: linux-omap@vger.kernel.org
>> > > Subject: omap3evm: Doesn't boot at 4fa42e46
>> > >
>> > > Hi all,
>> > >
>> > > Just updated my repo to the commit:
>> > >
>> > > commit 4fa42e4679324b0e3c54fb509535eea3923ccb63
>> > > Merge: e599f12 c446167
>> > > Author: Tony Lindgren <tony@atomide.com>
>> > > Date:   Thu Feb 4 20:07:44 2010 -0800
>> > >
>> > > The kernel builds fine; but doesn't boot on the OMAP3EVM.
>> > >
>> > > I have been able to trace the code until rest_init(); but
>> > > will need to restart debugging.
>> > > There seems to be an exception during execution.
>> > >
>> > > Will continue to dig further. This is just an FYI.
>> > >
>> >
>> > The kernel panics during I2C init in function omap3_evm_i2c_init()
>> > during this call:
>> >
>> >     omap_register_i2c_bus(2, 400, NULL, 0);

I see that Zoom2/3 also don't boot up and given that DEBUG_LL does not work for these boards,
its very difficult to narrow down the problem.

After around 2 hours of narrowing down, this is what solves the issue probably:
m0_entry seems to be null, causing strcmp() to crash.

Patch: (will not apply as TABS are not there :) )
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 986077f..d5a03f8 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -435,7 +435,7 @@ int __init omap_mux_init_signal(char *muxname, int val)
                char *m0_entry = m->muxnames[0];
                int i;

-               if (m0_name && strcmp(m0_name, m0_entry))
+               if (m0_name && m0_entry && strcmp(m0_name, m0_entry))
                        continue;

                for (i = 0; i < OMAP_MUX_NR_MODES; i++) {


