From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/4] ARM: OMAP: Rename twl4030* driver files to enable
 re-use
Date: Tue, 21 Jul 2009 08:24:48 +0300
Message-ID: <20090721052447.GA13013@gandalf>
References: <1248096671-13828-1-git-send-email-balajitk@ti.com>
 <20090720185253.GA7984@gandalf>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B59502D7@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36904 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbZGUFZD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 01:25:03 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B59502D7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "sameo@openedhand.com" <sameo@openedhand.com>, "wim@iguana.be" <wim@iguana.be>, "timo.t.kokkonen@nokia.com" <timo.t.kokkonen@nokia.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Nayak, Rajendra" <rnayak@ti.com>

hi,

On Tue, Jul 21, 2009 at 10:01:06AM +0530, Shilimkar, Santosh wrote:
> > So IMO, renaming the files is unnecessary.
> Well tps* are just catalog names of the twl4* family. So you can keep adding whatever names there as long it's a same IC.
> 
> Perhaps you look in hurry to comment about this. Please look at the intention of these patches. TWL6030 has PM IC similar to TWL4030 with bit different interrupt management. Audio IC is a separate one as compared to combined in case of TWL4030.
> 
> If it allows code re-use by renaming files, it should be good. Isn't it ? 

What I'm trying to say is you can re-use the code even without renaming
those files, just add twl6030-irq and use some sort of runtime check to
use one or other irq mechanism.

-- 
balbi
