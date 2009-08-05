From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH v2 4/4] OMAP4: PMIC: Update TWL mfd driver to
	create twl6030 regulators
Date: Wed, 5 Aug 2009 22:39:32 +0100
Message-ID: <20090805213932.GD20853@opensource.wolfsonmicro.com>
References: <1248842173-21821-1-git-send-email-balajitk@ti.com> <20090803142356.GA4265@rakim.wolfsonmicro.main> <20090804074544.GG24334@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B5CD8884@dbde02.ent.ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301D8BD1708@dbde02.ent.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B5CD8BFF@dbde02.ent.ti.com> <20090804134247.GA32353@rakim.wolfsonmicro.main> <EAF47CD23C76F840A9E7FCE10091EFAB02B5CD8C25@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40969 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752316AbZHEVjc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 17:39:32 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B5CD8C25@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Tony Lindgren <tony@atomide.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "sameo@openedhand.com" <sameo@openedhand.com>, "wim@iguana.be" <wim@iguana.be>, "timo.t.kokkonen@nokia.com" <timo.t.kokkonen@nokia.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "Nayak, Rajendra" <rnayak@ti.com>

On Tue, Aug 04, 2009 at 07:28:22PM +0530, Shilimkar, Santosh wrote:

> Do you have boards / use cases where more than one PM IC would be used _and_ it will use the same driver ?

I don't personally but it's certainly something that I would consider
realistic (if not mainstream).
