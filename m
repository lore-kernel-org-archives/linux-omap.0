From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 1/3] regulator: tps65217: Add device tree support
Date: Mon, 25 Jun 2012 12:28:15 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13E9DFA80@DBDE01.ent.ti.com>
References: <1340625878-32336-1-git-send-email-anilkumar@ti.com>
 <1340625878-32336-2-git-send-email-anilkumar@ti.com>
 <20120625121220.GA30406@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120625121220.GA30406@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>, "Girdwood, Liam" <lrg@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

Thanks for quick reply.

On Mon, Jun 25, 2012 at 17:42:20, Mark Brown wrote:
> On Mon, Jun 25, 2012 at 05:34:36PM +0530, AnilKumar Ch wrote:
> > This commit adds device tree support for tps65217 pmic. And usage
> > details are added to device tree documentation.
> > 
> > Driver is tested by using kernel module with regulator set and get
> > APIs.
> 
> This needs to be updated for the patches Laxman recently posted for the
> regulator-compatible property (which are currently blocked on review
> from the ST Ericcsson guys but I'll probably apply them in the next
> couple of days if I don't hear back from them).
> 

In that case, I will resubmit the patches once "regulator-compatible
property" patches are pushed to "linux-next".

Thanks
AnilKumar
