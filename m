From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v5 2/4] TI816X: Update common OMAP machine specific
 sources
Date: Thu, 10 Feb 2011 10:13:47 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036ACA3CB4@dbde02.ent.ti.com>
References: <1297270570-32492-1-git-send-email-hemantp@ti.com>
 <20110210014557.GG20795@atomide.com> <20110210014826.GH20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48523 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228Ab1BJEn4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 23:43:56 -0500
In-Reply-To: <20110210014826.GH20795@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>

Tony Lindgren wrote on Thursday, February 10, 2011 7:18 AM:

> * Tony Lindgren <tony@atomide.com> [110209 17:45]:
>> 
>> We should just have separate struct map_desc omapti816x_io_desc[] then.
>> Maybe have a common struct map_desc omap3_io_desc[] and then separate
>> omap3xxx_io_desc and omapti816x_io_desc?
> 
> Oh and this will work just fine for map_io without having cpu_is_omap
> macros working yet because we call set_globals from the board
> file with
> the processor class data.
> 
> Tony

So probably I need to create another function (ti816x_map_common_io()) to
map just the L4 slow region and call it from board file (after set globals)
as distinguishing between OMAP3xxx and TI816X is not possible at that time
inside omap34xx_map_common_io() as they both have same class.

Does this approach look ok?
Thanks.
   Hemant