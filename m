From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v6 00/10] OMAP-GPMC: generic time calc, prepare for
 driver
Date: Mon, 27 Aug 2012 12:38:35 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9BA713@DBDE01.ent.ti.com>
References: <cover.1345524670.git.afzal@ti.com> <503B6511.4050909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57202 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695Ab2H0Mio convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Aug 2012 08:38:44 -0400
In-Reply-To: <503B6511.4050909@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Daniel,

On Mon, Aug 27, 2012 at 17:46:17, Daniel Mack wrote:

> > Such a generic routine would help create a driver out of gpmc platform
> > code, which would be peripheral agnostic and thus lead to DT finally.
> > Input to generic timing calculation routine would be gpmc peripheral
> > timings, output - translated timings that gpmc can understand. Later,
> > to DT'ify, gpmc peripheral timings could be passed through DT. Input
> > timings that has been used here are selected such that it represents
> > those that are present in peripheral timing datasheets.
> 
> What I don't understand yet about this new approach is where the gpmc
> client code should live in. In order to probe the drivers via DT, each
> driver would need to call the gpmc support functions itself, right? Is

By gpmc client code, if you are referring to helper functions in
mach-omap2/gpmc-*, if things go as per plan, with DT, they will go away
and gpmc driver would handle those based on the information from DT.

No change would be needed for client drivers like smc91x ethernet drivers,
but NAND driver may need some change to live with DT as it is tightly
coupled with GPMC.

> the plan to obsolete helper functions like gpmc_nand_init() and move
> that functionality to the drivers?

Yes, plan is to obsolete the functions like gpmc_nand_init, those tasks
would be handled by gpmc driver

> 
> I applied these patches locally and would like to help get the NAND
> controller on my AX33xx DT-driven board going. Let me know if I can do
> anything here.

Thanks for offering the help, will take liberty to ask you for help
when required. BTW, do you have any OMAP family boards ?

Regards
Afzal
