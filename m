From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 2/2] regulator:TPS65910: VDD1/2 voltage selector count
Date: Fri, 4 Nov 2011 16:32:43 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9019650@DBDE01.ent.ti.com>
References: <1320410928-20349-1-git-send-email-afzal@ti.com>
 <20111104140422.GA28615@opensource.wolfsonmicro.com>
 <C8443D0743D26F4388EA172BF4E2A7A90194B0@DBDE01.ent.ti.com>
 <20111104152559.GC28615@opensource.wolfsonmicro.com>
 <C8443D0743D26F4388EA172BF4E2A7A9019607@DBDE01.ent.ti.com>
 <20111104161855.GC28902@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111104161855.GC28902@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>, Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On Fri, Nov 04, 2011 at 21:48:56, Mark Brown wrote:
> So that definitely seems wrong then - n_voltages is supposed to be the
> number of voltages that can be selected so if the regulator supports
> _NUM_VOLTS steps then I'd expect to see that constant used directly.
> Otherwise I'd suggest that the magic number needs a #define.
> 

A gain of 0x1, 0x2, 0x3 is possible for each of the voltage steps,
so we have a total of _NUM_VOLTS * 3 steps (although some of them
would be same values).

Let me know your opinion on using _NUM_VOLTS * NUM_GAIN instead,
with #define NUM_GAIN 3.

Regards
Afzal
