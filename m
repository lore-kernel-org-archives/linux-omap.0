Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319F8EB64DA
	for <linux-omap@archiver.kernel.org>; Sat, 24 Jun 2023 14:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjFXORv (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sat, 24 Jun 2023 10:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjFXORu (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jun 2023 10:17:50 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A409E1997;
        Sat, 24 Jun 2023 07:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=njhQ6LetGVTfkUp4632v4/5dEbyHLtyZRQxQCuse0SA=; b=lAVprTVksf2J+vDdKRIYjAYQvG
        8nNVXicVECiTa0iaAP07yEjPnd6MEYqUfz2Duw9IMi2COcETYtd+e/zbUa0/vDoQW+AwjxN40TwSh
        vA8VxNR0RQvuJlfTB8IzW5rgji2/OlzHAiT7TQp9KM4RNrqraj9/Hvn86bFKkMbOiOHU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qD44z-00HQrZ-39; Sat, 24 Jun 2023 16:17:33 +0200
Date:   Sat, 24 Jun 2023 16:17:33 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND][PATCH] net: cpsw: fix obtaining mac address for am3517
Message-ID: <ad0ec6ac-2760-4a03-8cee-0d933aea98eb@lunn.ch>
References: <20230624121211.19711-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624121211.19711-1-mans@mansr.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Sat, Jun 24, 2023 at 01:10:59PM +0100, Mans Rullgard wrote:
> From: Jeroen Hofstee <jhofstee@victronenergy.com>
> 
> Commit b6745f6e4e63 ("drivers: net: cpsw: davinci_emac: move reading mac
> id to common file") did not only move the code for an am3517, it also
> added the slave parameter, resulting in an invalid (all zero) mac address
> being returned for an am3517, since it only has a single emac

Hi Mans

If there is only a single emac, why is the function being called with
slave=1? Given the description, it seems like you are fixing the wrong
problem.

	Andrew
