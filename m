Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F72C43381
	for <linux-omap@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EB964EEE
	for <linux-omap@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344303AbhCDAAH (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380082AbhCCIVQ (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2021 03:21:16 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D8AC06178C;
        Tue,  2 Mar 2021 23:40:19 -0800 (PST)
Received: from [192.168.1.111] (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B9366ED;
        Wed,  3 Mar 2021 08:40:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1614757217;
        bh=66EoJnJQTBk9s3G5RxIxlLMB8d54u78Ylq/9v3jzsA0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jXp2QWM9uopUOhK9SUVHJ0yfhEJuyl81/bx1yicqkCPjwDJrytPDEvbk2BoEQ57Rf
         sXBZE8Ebn0y/92f6Tg+fFHRcluRvhZ1zKGzewa6r5Vg4h8SgBTyS6Jx9X8Vd3pYgVp
         v3t8LRh1SOJqA/LEp6VK/BzwwUwkbVbz4289blgk=
Subject: Re: [PATCHv2 4/6] dt-bindings: display: ti: ti,omap5-dss.txt: add cec
 clock
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org
References: <20210302162403.983585-1-hverkuil-cisco@xs4all.nl>
 <20210302162403.983585-5-hverkuil-cisco@xs4all.nl>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Message-ID: <b835ae4f-f23b-e378-9992-6f0511f12550@ideasonboard.com>
Date:   Wed, 3 Mar 2021 09:40:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210302162403.983585-5-hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On 02/03/2021 18:24, Hans Verkuil wrote:
> The cec clock is required as well in order to support HDMI CEC,
> document this.
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
>   Documentation/devicetree/bindings/display/ti/ti,omap5-dss.txt | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,omap5-dss.txt b/Documentation/devicetree/bindings/display/ti/ti,omap5-dss.txt
> index 20861218649f..c321c67472f0 100644
> --- a/Documentation/devicetree/bindings/display/ti/ti,omap5-dss.txt
> +++ b/Documentation/devicetree/bindings/display/ti/ti,omap5-dss.txt
> @@ -89,8 +89,8 @@ Required properties:
>   - interrupts: the HDMI interrupt line
>   - ti,hwmods: "dss_hdmi"
>   - vdda-supply: vdda power supply
> -- clocks: handles to fclk and pll clock
> -- clock-names: "fck", "sys_clk"
> +- clocks: handles to fclk, pll and cec clock
> +- clock-names: "fck", "sys_clk", "cec"
>   
>   Optional nodes:
>   - Video port for HDMI output
> 

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi
