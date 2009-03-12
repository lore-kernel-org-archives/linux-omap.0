From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: RE: [PATCH 1/1] DSPBRIDGE Fix for image autoload
Date: Thu, 12 Mar 2009 11:30:59 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A8F2BF1D@dbde02.ent.ti.com>
References: <7A436F7769CA33409C6B44B358BFFF0CFF51DBBC@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55643 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbZCLGBr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 02:01:47 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2C61dpu024014
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 01:01:45 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2C61dNT027371
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:31:39 +0530 (IST)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF51DBBC@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

Nishant,
 

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Thursday, March 12, 2009 11:19 AM
> To: Gupta, Ramesh; linux-omap@vger.kernel.org
> Cc: Kanigeri, Hari; Guzman Lugo, Fernando
> Subject: RE: [PATCH 1/1] DSPBRIDGE Fix for image autoload
> 
> Ramesh,
> > -----Original Message-----
> > From: Gupta, Ramesh
> > Sent: Thursday, March 12, 2009 7:32 AM
> > To: linux-omap@vger.kernel.org
> > Cc: Menon, Nishanth; Kanigeri, Hari; Guzman Lugo, Fernando
> > Subject: [PATCH 1/1] DSPBRIDGE Fix for image autoload
> > 
> > From fbbf5c9c308c2e1e90e70c57a48798c5d05a6b1d Mon Sep 17 
> 00:00:00 2001
> > From: Ramesh Gupta <x0023949@ti.com>
> > Date: Thu, 12 Mar 2009 10:48:08 +0530
> > Subject: [PATCH 1/1] DSPBRIDGE Fix for image autoload.
> > 
> > This fixes the issue with the image autoloading while 
> installing the 
> > bridgedriver with install param base_img
> What is your code base? Omapzoom or gitorious? Could you send 
> us the link to the git log of the branch you are sending this for?

I have tried this on linux-omap pm branch . This can be applied on top of my DVFS
Patches earlier.

My git log shows 


commit fbbf5c9c308c2e1e90e70c57a48798c5d05a6b1d
Author: Ramesh Gupta <x0023949@linuxomap.(none)>
Date:   Thu Mar 12 10:48:08 2009 +0530

    DSPBRIDGE Fix for image autoload.

    This fixes the issue with the image autoloading while
    installing the bridgedriver with install param base_img

    Signed-off-by: Ramesh Gupta G <grgupta@ti.com>

commit a384d11047130358223a24080d58e57dcef92550
Author: Ramesh Gupta <x0023949@linuxomap.(none)>
Date:   Wed Mar 11 19:34:43 2009 +0530

    DVFS OFF MODE Support.

commit 4f422d583e2e233c19eb20754b8cfad6ed9e460a
Author: Nayak, Rajendra <rnayak@ti.com>
Date:   Fri Feb 13 11:30:57 2009 +0530

    OMAP3: PM: Update voltage levels for OPP1/2 on VDD1/2

    This patch updates the voltage levels for VDD1 OPP1/2 and
    VDD2 OPP1/2 according to the latest operating condition
    addendum for 3430.

    The new voltage levels at various OPP's for VDD1/2 are as below

    VDD1 OPP1 0.975v
    VDD1 OPP2 1.050v
    VDD1 OPP3 1.200v
    VDD1 OPP4 1.270v
    VDD1 OPP5 1.350v

    VDD2 OPP1 0.975v
    VDD2 OPP2 1.050v
    VDD2 OPP3 1.150v

    The patch applies on the latest pm head and is validated on 3430SDP.

    Signed-off-by: Rajendra Nayak <rnayak@ti.com>

commit 65d02c2c7fe676369b7162459feec60268c7f4ba
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Fri Feb 13 11:07:18 2009 -0800

    OMAP3: PM: fix compile warning when !CONFIG_SUSPEND

    Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>


Please let me know if you see any issues in applying this.


Regards
Ramesh Gupta G