Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F5EC4167B
	for <linux-omap@archiver.kernel.org>; Fri, 10 Nov 2023 18:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbjKJS1a (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346531AbjKJS05 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 10 Nov 2023 13:26:57 -0500
X-Greylist: delayed 392 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Nov 2023 23:06:19 PST
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFD98254;
        Thu,  9 Nov 2023 23:06:19 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 174F860376;
        Fri, 10 Nov 2023 06:59:35 +0000 (UTC)
Date:   Fri, 10 Nov 2023 08:59:33 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 11/12] bus: ti-sysc: Convert to platform remove callback
 returning void
Message-ID: <20231110065933.GA25544@atomide.com>
References: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de>
 <20231109202830.4124591-12-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231109202830.4124591-12-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Uwe Kleine-König <u.kleine-koenig@pengutronix.de> [231109 20:29]:
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.

Looks good to me, please queue along with your other patches:

Reviewed-by: Tony Lindgren <tony@atomide.com>
