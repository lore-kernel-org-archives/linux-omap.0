From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 2/2] arm/dts: AM33XX: Add device tree OPP table
Date: Thu, 13 Sep 2012 06:23:38 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA2DF8C@DBDE01.ent.ti.com>
References: <1346405840-31058-1-git-send-email-anilkumar@ti.com>
 <1346405840-31058-3-git-send-email-anilkumar@ti.com>
 <5050C4B3.9040107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5050C4B3.9040107@ti.com>
Content-Language: en-US
Sender: cpufreq-owner@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, paul Walmsley <paul@pwsan.com>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 12, 2012 at 22:51:55, Cousson, Benoit wrote:
> + Paul
> 
> Hi Anil,
> 
> On 08/31/2012 11:37 AM, AnilKumar Ch wrote:
> > Add DT OPP table for AM33XX family of devices. This data is
> > decoded by OF with of_init_opp_table() helper function.
> > 
> > Also adds cpu0 supply name to the corresponding dts files.
> > cpu0-supply name is used by cpufreq-cpu0 driver to get the
> > regulator pointer for voltage modifications.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> 
> I've just applied your patch in my for_3.7/dts_part2 branch.

Thanks Benoit,

> 
> I changed the subject to use "ARM: dts: " prefix seems it seems to be
> the convention nowadays.

I will take care from next time onwards.

> 
> I can apply as the well the clock patch if Paul acks it, but it can go
> through Paul as well since there is no strong dependency between them AFAIK.

Paul,

Can you ACK "clock data entry" patch?

Thanks
AnilKumar
