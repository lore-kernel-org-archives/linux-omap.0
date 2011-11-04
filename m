From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 2/2] regulator:TPS65910: VDD1/2 voltage selector count
Date: Fri, 4 Nov 2011 16:48:09 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9019691@DBDE01.ent.ti.com>
References: <1320410928-20349-1-git-send-email-afzal@ti.com>
 <20111104140422.GA28615@opensource.wolfsonmicro.com>
 <C8443D0743D26F4388EA172BF4E2A7A90194B0@DBDE01.ent.ti.com>
 <20111104152559.GC28615@opensource.wolfsonmicro.com>
 <C8443D0743D26F4388EA172BF4E2A7A9019607@DBDE01.ent.ti.com>
 <20111104161855.GC28902@opensource.wolfsonmicro.com>
 <C8443D0743D26F4388EA172BF4E2A7A9019650@DBDE01.ent.ti.com>
 <20111104164009.GA753@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111104164009.GA753@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>, Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On Fri, Nov 04, 2011 at 22:10:09, Mark Brown wrote:
> 
> What do you mean when you say "gain"?
> 

Effective voltage expression is (value1 * 12.5mV + 562.5 mV) * value2.

In this value2 is being called as gain.

value1 can have values from 3 to 75, both inclusive (73 steps)
value2 can have from 1 to 3, both inclusive (3 numbers)

Regards
Afzal
