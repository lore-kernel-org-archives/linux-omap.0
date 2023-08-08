Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE29C04FE0
	for <linux-omap@archiver.kernel.org>; Tue,  8 Aug 2023 17:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjHHRuo (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbjHHRuP (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 8 Aug 2023 13:50:15 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C653E93EF;
        Tue,  8 Aug 2023 09:22:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7E8D08176;
        Tue,  8 Aug 2023 10:26:16 +0000 (UTC)
Date:   Tue, 8 Aug 2023 13:26:15 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: pinctrl-single: add
 ti,am654-padconf compatible
Message-ID: <20230808102615.GS14799@atomide.com>
References: <20230808102207.130177-1-d-gole@ti.com>
 <20230808102207.130177-2-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808102207.130177-2-d-gole@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Dhruva Gole <d-gole@ti.com> [230808 10:24]:
> Add the "ti,am654-padconf" compatible to support the new wakeup enable and
> status bits positions on K3 family SOCs that support the IO daisychain
> feature.

This one too:

Reviewed-by: Tony Lindgren <tony@atomide.com>
