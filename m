Return-Path: <SRS0=m/Cn=B7=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F235CC433E1
	for <linux-omap@archiver.kernel.org>; Fri, 21 Aug 2020 13:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C81207DE
	for <linux-omap@archiver.kernel.org>; Fri, 21 Aug 2020 13:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgHUNqX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:46:23 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:33618 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgHUNo5 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 21 Aug 2020 09:44:57 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E92EA1C0BB4; Fri, 21 Aug 2020 15:44:53 +0200 (CEST)
Date:   Fri, 21 Aug 2020 15:44:51 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-omap@vger.kernel.org, aford@beaconembedded.com,
        Beno??t Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ARM: dts: omap3: Add cpu trips and cooling map for
 omap34/36 families
Message-ID: <20200821134451.GA3806@bug>
References: <20200817133931.11785-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200817133931.11785-1-aford173@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Mon 2020-08-17 08:39:31, Adam Ford wrote:
> The OMAP3530, OMAP3630, and DM3730 all show thresholds of 90C and 105C
> depending on commercial or industrial temperature ratings.
> 
> This patch expands the thermal information to include the limits of 90
> and 105C for alert and critical.  It sets the coolings-cells for the
> 34xx and 36xx CPU's which both point to omap3-cpu-thermal.dtsi.
> 
> For boards who never use industrial temperatures, these can be
> changed on their respective device trees with something like:
> 
> &cpu_alert0 {
> 	temperature = <85000>; /* millicelsius */
> };
> 
> &cpu_crit {
> 	temperature = <90000>; /* millicelsius */
> };

That should be the other way around. Provide safe values by default.

										Pavel
