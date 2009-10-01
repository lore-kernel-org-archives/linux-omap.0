From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 01/04] ARM: OMAP: Rename twl4030* driver files to
 enable re-use
Date: Thu, 1 Oct 2009 14:06:18 +0100
Message-ID: <20091001130618.GA22499@rakim.wolfsonmicro.main>
References: <1254399409-3473-1-git-send-email-balajitk@ti.com>
 <20091001123819.GA21973@rakim.wolfsonmicro.main>
 <19F8576C6E063C45BE387C64729E73940436CF8C0C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45516 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755457AbZJANGP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 09:06:15 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436CF8C0C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "wim@iguana.be" <wim@iguana.be>, "timo.t.kokkonen@nokia.com" <timo.t.kokkonen@nokia.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Lopez Cruz, Misael" <x0052729@ti.com>

On Thu, Oct 01, 2009 at 06:26:57PM +0530, Krishnamoorthy, Balaji T wrote:

> The patch which is posted now will make both codec to use the same i2c read
> /write api like twl_i2c_write_u8, twl_i2c_read_u8 ...

Ah, I see.  In that case I'm fine with the change.
