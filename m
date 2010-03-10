From: "Gurav , Pramod" <pramod.gurav@ti.com>
Subject: struct dmtimer definition not available in header file
Date: Wed, 10 Mar 2010 19:55:39 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321DCB6CA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38742 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab0CJOZo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 09:25:44 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2AEPfVF008103
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 10 Mar 2010 08:25:43 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2AEPeu0020093
	for <linux-omap@vger.kernel.org>; Wed, 10 Mar 2010 19:55:40 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi All,
I am using dmtimer in my code. Code looks like this:

{
        static struct omap_dm_timer *gpt;
        void * __iomem gpt10_counter_reg;
        unsigned long gpt_phys_base;

        omap_dm_timer_init();
        gpt = omap_dm_timer_request();
        if (!gpt) {
                pr_err("Could not get the gptimer\n");
                return -1;
        }
        omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);

        gpt_phys_base = gpt->phys_base;

        gpt10_counter_reg =
                        OMAP2_L4_IO_ADDRESS(gpt_phys_base +
                                        OMAP_TIMER_COUNTER_OFFSET);

        gt_rate = clk_get_rate(omap_dm_timer_get_fclk(gpt));
        omap_dm_timer_set_load_start(gpt, 0, 0);
	
	.
	.
	.
}

I am not able to reference *gpt as the file does not know about struct omap_dm_timer. I have included plat/dmtimer.h.

Why doesn't the dmtimer struct definition appear in plat/dmtimer.h ?
Is there any reason for this?

-
Thanks and Best Regards
Pramod Gurav

