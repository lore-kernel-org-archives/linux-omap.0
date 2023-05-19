Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3823EC77B7F
	for <linux-omap@archiver.kernel.org>; Fri, 19 May 2023 07:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjESHOS (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 19 May 2023 03:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjESHOR (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 19 May 2023 03:14:17 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92EE310E6;
        Fri, 19 May 2023 00:14:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B51CC80F9;
        Fri, 19 May 2023 07:14:00 +0000 (UTC)
Date:   Fri, 19 May 2023 10:13:59 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Subject: Mystery dtb check errors with ti,x-plate-ohms with txt only binding
Message-ID: <20230519071359.GW14287@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi,

Somehow the ti,x-plate-ohms property produces errors for nodes with the
compatible only in a txt binding that still uses /bits/ 16 value:

ti,x-plate-ohms: size (2) error for type uint32-array

For the yaml bindings, we have ti,xplate-ohms so far only defined in
Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml.

So for example, compatible = "ti,tsc2046" that only has a txt binding in
Documentation/devicetree/bindings/input/touchscreen/ads7846.txt still
produces warnings somehow based on the ti,tsc2005.yaml?

Any ideas why this is happening?

Regards,

Tony
