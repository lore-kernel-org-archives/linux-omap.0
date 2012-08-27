From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v6 00/10] OMAP-GPMC: generic time calc, prepare for driver
Date: Mon, 27 Aug 2012 15:30:32 +0200
Message-ID: <503B7678.90308@gmail.com>
References: <cover.1345524670.git.afzal@ti.com> <503B6511.4050909@gmail.com> <C8443D0743D26F4388EA172BF4E2A7A93E9BA713@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64306 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab2H0Nal (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Aug 2012 09:30:41 -0400
Received: by bkwj10 with SMTP id j10so1233847bkw.19
        for <linux-omap@vger.kernel.org>; Mon, 27 Aug 2012 06:30:39 -0700 (PDT)
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9BA713@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 27.08.2012 14:38, Mohammed, Afzal wrote:
> On Mon, Aug 27, 2012 at 17:46:17, Daniel Mack wrote:
> 
>>> Such a generic routine would help create a driver out of gpmc platform
>>> code, which would be peripheral agnostic and thus lead to DT finally.
>>> Input to generic timing calculation routine would be gpmc peripheral
>>> timings, output - translated timings that gpmc can understand. Later,
>>> to DT'ify, gpmc peripheral timings could be passed through DT. Input
>>> timings that has been used here are selected such that it represents
>>> those that are present in peripheral timing datasheets.
>>
>> What I don't understand yet about this new approach is where the gpmc
>> client code should live in. In order to probe the drivers via DT, each
>> driver would need to call the gpmc support functions itself, right? Is
> 
> By gpmc client code, if you are referring to helper functions in
> mach-omap2/gpmc-*, if things go as per plan, with DT, they will go away
> and gpmc driver would handle those based on the information from DT.

So the GPMC driver is the one that is matched from DT, and the NAND
driver will the be instanciated from the (generic) GPMC driver?

> No change would be needed for client drivers like smc91x ethernet drivers,
> but NAND driver may need some change to live with DT as it is tightly
> coupled with GPMC.

NAND drivers also typically parse partition entries that are children of
the DT node the are owning.

>> the plan to obsolete helper functions like gpmc_nand_init() and move
>> that functionality to the drivers?
> 
> Yes, plan is to obsolete the functions like gpmc_nand_init, those tasks
> would be handled by gpmc driver
> 
>>
>> I applied these patches locally and would like to help get the NAND
>> controller on my AX33xx DT-driven board going. Let me know if I can do
>> anything here.
> 
> Thanks for offering the help, will take liberty to ask you for help
> when required. BTW, do you have any OMAP family boards ?

I do have a beaglboard xM, but the board I'm currently working with is a
custom one based on an AM33xx.


Thanks,
Daniel

