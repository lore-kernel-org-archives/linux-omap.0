From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: RE: [PATCH]TWL4030 battery driver madc str fix
Date: Thu, 18 Sep 2008 14:23:23 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB027E1FD2F2@dbde02.ent.ti.com>
References: <56082.192.168.10.89.1221727481.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32958 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbYIRIxc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 04:53:32 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m8I8rPUc014465
	for <linux-omap@vger.kernel.org>; Thu, 18 Sep 2008 03:53:31 -0500
In-Reply-To: <56082.192.168.10.89.1221727481.squirrel@dbdmail.itg.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>  	struct twl4030_madc_request req;
> 
>  	req.channels = (1 << 9);
> +	req.do_avg = NULL;
>  	req.method = TWL4030_MADC_SW1;
> +	req.active = NULL;
>  	req.func_cb = NULL;
>  	twl4030_madc_conversion(&req);
>  	temp = (u16)req.rbuf[9];

As per twl4030_madc_request structure 'do_avg' is a u16, and 'active' is an integer. So they should be initialized to 0 instead of NULL.

--
Regards,
Jagadeesh
