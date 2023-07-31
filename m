Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2339C41513
	for <linux-omap@archiver.kernel.org>; Mon, 31 Jul 2023 06:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjGaGI0 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 31 Jul 2023 02:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGaGIZ (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 31 Jul 2023 02:08:25 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E09110DC;
        Sun, 30 Jul 2023 23:08:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 76FCD809E;
        Mon, 31 Jul 2023 06:08:20 +0000 (UTC)
Date:   Mon, 31 Jul 2023 09:08:19 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, afd@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v7 0/2] dt-bindings: omap: Convert omap.txt to yaml
Message-ID: <20230731060819.GD5194@atomide.com>
References: <20230515074512.66226-1-andreas@kemnade.info>
 <20230613193257.267ad763@aktux>
 <37ef78ee-b290-ecfb-504d-cef5653d23f2@linaro.org>
 <20230616185320.61b33510@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616185320.61b33510@aktux>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [230616 16:53]:
> On Tue, 13 Jun 2023 20:43:55 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > On 13/06/2023 19:32, Andreas Kemnade wrote:
> > > Hi,
> > > 
> > > any action still expected from my side?
> > > people gave R-bys...
> > > So looks like it is ready for the dt-folks to pick it up.
> > >   
> > 
> > It's SoC file, isn't it? Then goes via SoC tree.
> > 
> Apparently there was confusion about it. Quoting
> Tony:"And thanks for getting the
> omap.yaml conversion going, that will get merged by the dt folks."
> 
> I am fine with either, 

OK I'll apply this into omap-for-v6.6/dt-bindings thanks.

Regards,

Tony
