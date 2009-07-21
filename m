From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/4] ARM: OMAP: Rename twl4030* driver files to enable
 re-use
Date: Tue, 21 Jul 2009 11:03:53 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B59503D1@dbde02.ent.ti.com>
References: <1248096671-13828-1-git-send-email-balajitk@ti.com>
 <20090720185253.GA7984@gandalf>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B59502D7@dbde02.ent.ti.com>
 <20090721052447.GA13013@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44956 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752213AbZGUFe0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 01:34:26 -0400
In-Reply-To: <20090721052447.GA13013@gandalf>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "sameo@openedhand.com" <sameo@openedhand.com>, "wim@iguana.be" <wim@iguana.be>, "timo.t.kokkonen@nokia.com" <timo.t.kokkonen@nokia.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Nayak, Rajendra" <rnayak@ti.com>

> -----Original Message-----
> From: Felipe Balbi [mailto:me@felipebalbi.com] 
> Sent: Tuesday, July 21, 2009 10:55 AM
> To: Shilimkar, Santosh
> Cc: me@felipebalbi.com; Krishnamoorthy, Balaji T; 
> linux-kernel@vger.kernel.org; tony@atomide.com; 
> khilman@deeprootsystems.com; david-b@pacbell.net; 
> linux-omap@vger.kernel.org; linux-i2c@vger.kernel.org; 
> sameo@openedhand.com; wim@iguana.be; 
> timo.t.kokkonen@nokia.com; ben-linux@fluff.org; 
> lrg@slimlogic.co.uk; broonie@opensource.wolfsonmicro.com; 
> Nayak, Rajendra
> Subject: Re: [PATCH 1/4] ARM: OMAP: Rename twl4030* driver 
> files to enable re-use
> 
> hi,
> 
> On Tue, Jul 21, 2009 at 10:01:06AM +0530, Shilimkar, Santosh wrote:
> > > So IMO, renaming the files is unnecessary.
> > Well tps* are just catalog names of the twl4* family. So 
> you can keep adding whatever names there as long it's a same IC.
> > 
> > Perhaps you look in hurry to comment about this. Please 
> look at the intention of these patches. TWL6030 has PM IC 
> similar to TWL4030 with bit different interrupt management. 
> Audio IC is a separate one as compared to combined in case of TWL4030.
> > 
> > If it allows code re-use by renaming files, it should be 
> good. Isn't it ? 
> 
> What I'm trying to say is you can re-use the code even 
> without renaming
> those files, just add twl6030-irq and use some sort of 
> runtime check to
> use one or other irq mechanism.

We initially tried this but code is becoming ugly and not at all
readable. In fact this was a short cut and would have saved 
us some time :)

By renaming, we thought it can become a generic for further versions
of TWL IC's and adding support to those would be cleaner.

Let's get feedback from more people on the list

Regards,
Santosh