From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: RE: [patch FYI] twl4030 dumps revision info
Date: Fri, 17 Oct 2008 14:01:20 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB028C86F640@dbde02.ent.ti.com>
References: <200810152123.42459.david-b@pacbell.net>
 <FCCFB4CDC6E5564B9182F639FC35608702396893F7@dbde02.ent.ti.com>
 <200810161716.58536.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52345 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbYJQIb3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 04:31:29 -0400
In-Reply-To: <200810161716.58536.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Ergo the observation that the TWL5030 ES1.0
> parts seem to mis-identify themselves.
> 

The delta TRM between TWL4030 and TWL5030 has a note, which says,
"The part code number is meaning less when accessed through the I2C";
which means, over JTAG, the ID code should reflect 0x0009802F.
I have not verified the same though.

As of now I2C read will give the ID code for TWL5030 as TWL4030 ES1.0.

