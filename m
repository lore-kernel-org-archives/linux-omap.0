Return-Path: <SRS0=25K9=5M=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F74BC2BA14
	for <linux-omap@archiver.kernel.org>; Fri, 27 Mar 2020 01:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2B720787
	for <linux-omap@archiver.kernel.org>; Fri, 27 Mar 2020 01:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnwZFUcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgC0BeP (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 26 Mar 2020 21:34:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40670 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgC0BeP (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 26 Mar 2020 21:34:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so2852049plk.7;
        Thu, 26 Mar 2020 18:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uFKK0rmf3+J4yn+P1XSuUCuH04czYSHT54dW1GTJiIE=;
        b=GnwZFUcQYqI7zQi8Mj3xiFnMlKQufDQ93cXDZ8zf6U9O+GeDp+srzeKk6whXoiKbNF
         sRK3qhWoDl/jh9BNDeLaLwH3bldkPA8iDRhgD0YnlOJsjwdh3CmngZD6mx13U+Yz6K1U
         amC6EC+ZdQJh5Ke6PhA9/6VbECAHdufuZxxO8Mgg/qOZ3iblvqfM5lOCpxUt+TtaNUrE
         x0W9HL/B2CrUS2cNuJgWQ/1eaFtCJ12K0g6qOImoMvr3Q8hpVxmJu01ic8Ssc+OWQClb
         k3zQbZhEJzWzzCKvA58nw2JH7w5bjEN5j2G0UBG3r3MvmWJhgS/wFWA/aBrX29hE4nKv
         k2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uFKK0rmf3+J4yn+P1XSuUCuH04czYSHT54dW1GTJiIE=;
        b=Os7es1srQc69wLcGIgQoX4r/U9QinaF0MoARUKD6fgpjHfpGOSg+PxloF/RC84Hd/A
         O42IwGXuUnpNgVTUmhW5JW7Lio8J0xNzthHaIFIPhx/O+DXteMCI8VqQqDuCocevf7Gp
         q04GWE1p4WSTPhCFMQhSEzPFTPFqERWQhwf7HQMA0P+mcujEJs43ywgXuoKmunStHewW
         Sb5qcG5O6n0QAcMK1zeIhvO/KJVhjIAme8m0nDvl5mdUwmmkgPsBsHeGFSBtLxwtXTi7
         Qa1eGdt9nz9YNMnYm92/JHM/QIQg+T2JnGAGARQRf/5chwg3cdbAhMl96S2hbsG2i+/j
         he5w==
X-Gm-Message-State: ANhLgQ2IKIlFtonPTX8OgV3ElU2po02+vClNz0vQSr/6vQsp69loU2D6
        qLwRdNiw9Wvv8fBqNAAFxPc=
X-Google-Smtp-Source: ADFU+vsvC/cghxY3m+o0RhnGEcQXGHPtloWMklG8ItXaIqS7q6X3VvXOGxG/X8J9PCt5lFl1gjG5Jw==
X-Received: by 2002:a17:90a:f0c6:: with SMTP id fa6mr3140222pjb.5.1585272853380;
        Thu, 26 Mar 2020 18:34:13 -0700 (PDT)
Received: from localhost (c-73-241-114-122.hsd1.ca.comcast.net. [73.241.114.122])
        by smtp.gmail.com with ESMTPSA id 193sm2724577pfa.182.2020.03.26.18.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 18:34:12 -0700 (PDT)
Date:   Thu, 26 Mar 2020 18:34:10 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        netdev <netdev@vger.kernel.org>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 10/11] net: ethernet: ti: cpts: add support
 for HW_TS_PUSH events
Message-ID: <20200327013410.GC9677@localhost>
References: <20200320194244.4703-1-grygorii.strashko@ti.com>
 <20200320194244.4703-11-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320194244.4703-11-grygorii.strashko@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

> +static int cpts_extts_enable(struct cpts *cpts, u32 index, int on)
> +{
> +	u32 v;
> +
> +	if (index >= cpts->info.n_ext_ts)
> +		return -ENXIO;

This check is already performed in ptp_chardev.c.

Thanks,
Richard

