From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 1/2] mfd: TPS65910: Improvements
Date: Fri, 4 Nov 2011 15:43:40 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A90195CA@DBDE01.ent.ti.com>
References: <1320410912-20293-1-git-send-email-afzal@ti.com>
 <20111104152411.GB28615@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111104152411.GB28615@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On Fri, Nov 04, 2011 at 20:54:11, Mark Brown wrote:
> ...should be in two separate commits.

Ok

> 
> > 2. struct tps65910_platform_data usage can be avoided
> >  by making use of struct tps65910_board to simplify
> >  driver. Hence remove it
> 
> Why is this a simplification?  Note that one of the reasons platform
> data is kept separate from any runtime data the device needs is that it
> makes the configuration available easier to see and understand.
> 

Ok, I understand that this simplification should not be done.

Regards
Afzal
