From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 2/2] regulator:TPS65910: VDD1/2 voltage selector count
Date: Fri, 4 Nov 2011 14:26:05 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A90194B0@DBDE01.ent.ti.com>
References: <1320410928-20349-1-git-send-email-afzal@ti.com>
 <20111104140422.GA28615@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111104140422.GA28615@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gg@slimlogic.co.uk" <gg@slimlogic.co.uk>, Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi Brown,

On Fri, Nov 04, 2011 at 19:34:22, Mark Brown wrote:
> On Fri, Nov 04, 2011 at 06:18:48PM +0530, Afzal Mohammed wrote:
> 
> >  		if (i == TPS65910_REG_VDD1 || i == TPS65910_REG_VDD2) {
> >  			pmic->desc[i].ops = &tps65910_ops_dcdc;
> > +			pmic->desc[i].n_voltages = VDD1_2_NUM_VOLTS * 3;
> 
> This looks suspicous - what's the * 3 about?
> 

Gain in voltage possible is x1, 0x2 & 0x3, I am shaky
about this change, but voltage could be changed with this,
cc'ing original author's

Specification @ http://www.ti.com/product/tps65910

Regards
Afzal
