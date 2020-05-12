Return-Path: <SRS0=x2NB=62=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459E6C54E8E
	for <linux-omap@archiver.kernel.org>; Tue, 12 May 2020 14:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16849206D3
	for <linux-omap@archiver.kernel.org>; Tue, 12 May 2020 14:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589295141;
	bh=0/vW+kBeSkulwcs/bDG1v4VZfipm6BOkGnOi2pgk9lQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WuzMZHiLLhj63yaHvqF+Gzm2L6Fqi6wqzcXuSt3MlLjrwcVHC7bsKxYLPf9SKcf8u
	 abIv5gXIX0DDx0F4IFVQB/6ynLSE+sUcBQgbFKKLVmkZryaYXgvfJYJ4zKqtgqzqgs
	 OjvCSqv8R70yQ7ka3YpK1Og5BHumme70YT6pcVX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgELOwT (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 12 May 2020 10:52:19 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42136 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgELOwT (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2020 10:52:19 -0400
Received: by mail-ot1-f66.google.com with SMTP id m18so10664710otq.9;
        Tue, 12 May 2020 07:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UBsjlnQ0ZdWz2mP4d91uXqSW8it9Smi8pG4uRvDSloc=;
        b=q8FIuop8HZQAE914fu7cgV1JMn9XAvYIsbPdvklxN7ORhCxuLUdFLZCOlCP/JlyjOR
         O0LkyT6o8tx6k2wd9TKhKbzG4c8ndXz9jdCbCSG5q0zTcxEBsAKSTM+e2EFK7o4cHrk4
         AFV00oB23Rh1MyG4tZs19Q6whsoMUf23k3gybwURkKiC59tbw5QrfXKbNxewJ6AApGO8
         u7p054ycE5NIGo+8R22bfdD9ffZXlkQELamNUTN8/51IhinSGYU1gCsyBa5tJ/fwO5RK
         5VvS/lK1KU9X4ZlQXrMGPhasiGMX1oKfNeA08RMupBUfBrOemkcSJUfa/gc/c4T2Tf5X
         soxg==
X-Gm-Message-State: AGi0PuZ6p8eFrn5E3+PVh1PUBTDt4Rk4yWYFZY35fH0dp+99btoU7nH+
        AoHIeiw59VeL3syY8OWQzg==
X-Google-Smtp-Source: APiQypLTRmbKCY35KSmUwgbrpxbLHM9/yYBgpyb75KwJF2Nli05EW5xWU4borvo9cGPm5XEicRrxkw==
X-Received: by 2002:a9d:2215:: with SMTP id o21mr6818101ota.203.1589295137121;
        Tue, 12 May 2020 07:52:17 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b6sm3525019otq.18.2020.05.12.07.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 07:52:16 -0700 (PDT)
Received: (nullmailer pid 23508 invoked by uid 1000);
        Tue, 12 May 2020 14:52:15 -0000
Date:   Tue, 12 May 2020 09:52:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Keerthy <j-keerthy@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Graeme Smecher <gsmecher@threespeedlogic.com>,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        devicetree@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Adam Ford <aford173@gmail.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Brian Hutchinson <b.hutchman@gmail.com>,
        linux-clk@vger.kernel.org, linux-omap@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/15] dt-bindings: timer: add ti, dmtimer compatible for
 for system timers
Message-ID: <20200512145215.GA23423@bogus>
References: <20200429215402.18125-1-tony@atomide.com>
 <20200429215402.18125-3-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429215402.18125-3-tony@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Wed, 29 Apr 2020 14:53:49 -0700, Tony Lindgren wrote:
> The TI dual-mode timer can be used for both clocksource and clockevent
> system timers. We need a way to specify which dual-mode timers are
> reserved for system timers as there are multiple instances available
> that may require a board specific configuration.
> 
> Let's add a generic compatible "ti,dmtimer" that TIMER_OF_DECLARE can
> use as suggested by Daniel Lezcano <daniel.lezcano@linaro.org>.
> 
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  Documentation/devicetree/bindings/timer/ti,timer.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
