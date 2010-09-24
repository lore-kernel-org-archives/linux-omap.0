From: "Taneja, Archit" <archit@ti.com>
Subject: Query on clock naming conventions in clockxxxx_data.c
Date: Fri, 24 Sep 2010 18:11:08 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870311A2F3F2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58574 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754939Ab0IXMlM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 08:41:12 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8OCf9qG009647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 07:41:11 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o8OCf9JL022445
	for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 18:11:09 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>

Hi,

I had a couple of queries regarding the clock structures in the clockxxxx_data.c files:

-I have seen that the name of the structure itself explains the name of the clock as
given in the TRM.
-The member "name" also tries to mimic the clock name.

The drivers get the clock struct using the "name" member in the clk_get() api. Is it
okay if we can change the "name" member to a more generic string. So that the driver
code stays more generic?

For example, the SYS_CLK which comes into DSS is called "dss2_alwon_fck" on omap3 and
"dss_sys_clk" on omap4. This will make our driver need to have cpu_is_omap checks while
calling clk_get().

Thanks,

Archit

