From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 2/2] regulator:TPS65910: VDD1/2 voltage selector count
Date: Fri, 4 Nov 2011 16:01:04 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A9019607@DBDE01.ent.ti.com>
References: <1320410928-20349-1-git-send-email-afzal@ti.com>
 <20111104140422.GA28615@opensource.wolfsonmicro.com>
 <C8443D0743D26F4388EA172BF4E2A7A90194B0@DBDE01.ent.ti.com>
 <20111104152559.GC28615@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111104152559.GC28615@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>, Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On Fri, Nov 04, 2011 at 20:55:59, Mark Brown wrote:
> On Fri, Nov 04, 2011 at 02:26:05PM +0000, Mohammed, Afzal wrote:
> > Hi Brown,
> 
> Ahem.

I am sorry for that if it offended you, not deliberate, this may
have to do with our different cultures, for me it is always a
confusion whether I should call a person with their first or
second name (unless he writes it at the end of mail). Normally my
name is written "Mohammed Afzal", but I am called "Afzal".


> 
> > On Fri, Nov 04, 2011 at 19:34:22, Mark Brown wrote:
> That doesn't really clarify things - the question is why the number of
> voltages we can set is three times a constant called _NUM_VOLTS?
> 

_NUM_VOLTS is the number of voltage steps.

I will try to come up with a better explanation or rather the
right solution, new to regulator world as of now.

Regards
Afzal
