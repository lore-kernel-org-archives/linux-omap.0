From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ARM: OMAP: mcbsp: Make wakeup control generic
Date: Wed, 6 Nov 2013 19:18:10 +0300
Message-ID: <20131106161810.GM15603@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:37393 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab3KFQSb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Nov 2013 11:18:31 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jarkko.nikula@bitmer.com
Cc: linux-omap@vger.kernel.org

Hello Jarkko Nikula,

This is a semi-automatic email about new static checker warnings.

The patch 1a6458847dd2: "ARM: OMAP: mcbsp: Make wakeup control 
generic" from Sep 26, 2011, leads to the following Smatch complaint:

sound/soc/omap/mcbsp.c:590 omap_mcbsp_free()
	 error: we previously assumed 'mcbsp->pdata' could be null (see line 586)

sound/soc/omap/mcbsp.c
   585	
   586		if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
                    ^^^^^^^^^^^^
Existing check.

   587			mcbsp->pdata->ops->free(mcbsp->id - 1);
   588	
   589		/* Disable wakeup behavior */
   590		if (mcbsp->pdata->has_wakeup)
                    ^^^^^^^^^^^^^^^^^^^^^^^^
Patch introduces an unchecked dereference.

   591			MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
   592	

regards,
dan carpenter
