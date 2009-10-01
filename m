From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v3 01/04] ARM: OMAP: Rename twl4030* driver files to
 enable re-use
Date: Thu, 1 Oct 2009 18:36:30 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BAEE9054@dbde02.ent.ti.com>
References: <1254399409-3473-1-git-send-email-balajitk@ti.com>
 <20091001123819.GA21973@rakim.wolfsonmicro.main>
 <19F8576C6E063C45BE387C64729E73940436CF8C0C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34738 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755524AbZJANG6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 09:06:58 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436CF8C0C@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Krishnamoorthy, Balaji T" <balajitk@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "wim@iguana.be" <wim@iguana.be>, "timo.t.kokkonen@nokia.com" <timo.t.kokkonen@nokia.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "Nayak, Rajendra" <rnayak@ti.com>, "Lopez Cruz, Misael" <x0052729@ti.com>

Mark,
> -----Original Message-----
> From: Krishnamoorthy, Balaji T
> Sent: Thursday, October 01, 2009 6:27 PM
> To: Mark Brown
> Cc: linux-omap@vger.kernel.org; sameo@linux.intel.com; wim@iguana.be;
> timo.t.kokkonen@nokia.com; ben-linux@fluff.org; lrg@slimlogic.co.uk;
> p_gortmaker@yahoo.com; a.zummo@towertech.it; Shilimkar, Santosh; Nayak,
> Rajendra; Lopez Cruz, Misael
> Subject: RE: [PATCH v3 01/04] ARM: OMAP: Rename twl4030* driver files to
> enable re-use
> 
> > On Thu, Oct 01, 2009 at 05:46:49PM +0530, balajitk@ti.com wrote:
> >
> > > The upcoming TWL6030 is companion chip for OMAP4 like the current
> TWL4030
> > > for OMAP3. The common modules like RTC, Regulator creates opportunity
> > > to re-use the most of the code from twl4030.
> >
> > > This patch renames few common drivers twl4030* files to twl* to enable
> > > the code re-use.
> >
> > >  sound/soc/codecs/twl4030.c                         |    2 +-
> >
> > Nack on this part of the change.
> >
> > The TWL6030 audio architecture is noticably different to the TWL4030
> > audio architecture, most of the digital functionality has been moved
> > into the OMAP and the I2S/DSP DAIs replaced by PDM links.  Merging the
> > two drivers was previously suggested in response to the TWL6030 CODEC
> > driver postings but Misael Lopez Cruz (who is doing the driver) wasn't
> > happy with the idea.
> 
> I agree that TWL6030 codec will very different from TWL4030 codec and two
> separate drivers will exist for twl4030 and twl6030.c
> The patch which is posted now will make both codec to use the same i2c
> read
> /write api like twl_i2c_write_u8, twl_i2c_read_u8 ...
This patch doesn't rename "sound/soc/codecs/twl4030.c". The change is just correcting the header file. 
As discussed and agreed the TWL6030 codec can be a separate file from TWL4030 codec.

Regards,
Santosh
