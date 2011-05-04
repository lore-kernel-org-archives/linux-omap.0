From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: [PATCH v2 4/7] OMAP: DSS: Add i2c client driver for picodlp
Date: Wed, 4 May 2011 15:31:10 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB033DA742E9@dbde02.ent.ti.com>
References: <1304347971-1504-1-git-send-email-mayur@ti.com>
	 <1304347971-1504-5-git-send-email-mayur@ti.com>
 <1304448293.26126.29.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51181 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747Ab1EDKBR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 06:01:17 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p44A1Ebu020961
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 4 May 2011 05:01:16 -0500
In-Reply-To: <1304448293.26126.29.camel@deskari>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "K, Mythri P" <mythripk@ti.com>



> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Wednesday, May 04, 2011 12:15 AM
> To: Janorkar, Mayuresh
> Cc: linux-omap@vger.kernel.org; K, Mythri P
> Subject: Re: [PATCH v2 4/7] OMAP: DSS: Add i2c client driver for picodlp
> 
> On Mon, 2011-05-02 at 20:22 +0530, Mayuresh Janorkar wrote:
> > The configurations and data transfer with picodlp panel happens through
> i2c.
> > An i2c client with name "picodlp_i2c_driver" is registered inside panel.
> >
> > dpp2600 requires 4 gpio lines for interfacing it with any processor,
> > phy_reset, ready_reset, park, display_select
> 
> Hmm, so what is dpp2600? It's mentioned here for the first time, the
> documentation doesn't mention it.

Patch 0 does mention about dpp2600. It means DLP Pico Processor
and I have also provided link to wiki page which talks more about dpp2600.
Earlier version of patch also had functions dpp2600_configure_flash.

> 
> If it means the picodlp, just use the same name all the time. If not,
> you could tell what it is first.

DPP means DLP pico processor.
> 
>  Tomi
> 

