From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: RE: [PATCH v3 01/04] ARM: OMAP: Rename twl4030* driver files to
 enable re-use
Date: Thu, 1 Oct 2009 18:26:57 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436CF8C0C@dbde02.ent.ti.com>
References: <1254399409-3473-1-git-send-email-balajitk@ti.com>
 <20091001123819.GA21973@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42167 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755524AbZJAM5Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 08:57:25 -0400
In-Reply-To: <20091001123819.GA21973@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "wim@iguana.be" <wim@iguana.be>, "timo.t.kokkonen@nokia.com" <timo.t.kokkonen@nokia.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Lopez Cruz, Misael" <x0052729@ti.com>

> On Thu, Oct 01, 2009 at 05:46:49PM +0530, balajitk@ti.com wrote:
> 
> > The upcoming TWL6030 is companion chip for OMAP4 like the current TWL4030
> > for OMAP3. The common modules like RTC, Regulator creates opportunity
> > to re-use the most of the code from twl4030.
> 
> > This patch renames few common drivers twl4030* files to twl* to enable
> > the code re-use.
> 
> >  sound/soc/codecs/twl4030.c                         |    2 +-
> 
> Nack on this part of the change.
> 
> The TWL6030 audio architecture is noticably different to the TWL4030
> audio architecture, most of the digital functionality has been moved
> into the OMAP and the I2S/DSP DAIs replaced by PDM links.  Merging the
> two drivers was previously suggested in response to the TWL6030 CODEC
> driver postings but Misael Lopez Cruz (who is doing the driver) wasn't
> happy with the idea.

I agree that TWL6030 codec will very different from TWL4030 codec and two 
separate drivers will exist for twl4030 and twl6030.c
The patch which is posted now will make both codec to use the same i2c read
/write api like twl_i2c_write_u8, twl_i2c_read_u8 ...
