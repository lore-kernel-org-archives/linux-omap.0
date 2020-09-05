Return-Path: <SRS0=BumZ=CO=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323B3C433E2
	for <linux-omap@archiver.kernel.org>; Sat,  5 Sep 2020 00:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4D52098B
	for <linux-omap@archiver.kernel.org>; Sat,  5 Sep 2020 00:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599264632;
	bh=CIke2Yb8/O1WlbwHmvfhzGM4v2Lz+SSikf2c522Tj7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RIG+QHdlCSFHEGEEyatFHvR5H2Bocx4+x6K8cjQiql6wu2VyHTSRn2VonY/QPIqt/
	 PAg2comZiIOrmkIsHn9BFV8YRT0cv3vFiFzP8VNx+qOCRx4EOaNW0OC+Jv1j1voBQp
	 0kY4hmifPFf4mtbNjxMc8b9pehmIoNXGZJGL8au0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgIEAK0 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 4 Sep 2020 20:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgIEAK0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 4 Sep 2020 20:10:26 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71350208FE;
        Sat,  5 Sep 2020 00:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599264625;
        bh=CIke2Yb8/O1WlbwHmvfhzGM4v2Lz+SSikf2c522Tj7M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zLG3v4lISlYDUYfL5RtuTfBqToe0F5c929Tzc90MPPy1MhtsVZ3zW2otHd6d0U7nv
         Jppndb/WzQVzSgj7Zou/8nu33I3XjypKRxlyn0iTnN4EelxTwaS3ioPyHawUGDK6Ls
         zHhreNPJPsjwu9gNmnVuq5fsbg3yomAUlcAFtuiA=
Date:   Fri, 4 Sep 2020 17:10:22 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: Re: [PATCH net-next 9/9] net: ethernet: ti: ale: add support for
 multi port k3 cpsw versions
Message-ID: <20200904171022.63f103fa@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200904230924.9971-10-grygorii.strashko@ti.com>
References: <20200904230924.9971-1-grygorii.strashko@ti.com>
        <20200904230924.9971-10-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Sat, 5 Sep 2020 02:09:24 +0300 Grygorii Strashko wrote:
> The TI J721E (CPSW9g) ALE version is similar, in general, to Sitara AM3/4/5
> CPSW ALE, but has more extended functions and different ALE VLAN entry
> format.
> 
> This patch adds support for for multi port TI J721E (CPSW9g) ALE variant.

and:

drivers/net/ethernet/ti/cpsw_ale.c:195:28: warning: symbol 'vlan_entry_k3_cpswxg' was not declared. Should it be static?
