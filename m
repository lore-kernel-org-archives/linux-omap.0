From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 08/11] crypto: omap: add clk_prepare and clk_unprepare
Date: Tue, 26 Jun 2012 16:28:34 +0530
Message-ID: <4FE995DA.2070001@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com> <1340372890-10091-9-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1206221257480.10198@utopia.booyaka.com> <4FE7F73D.6090402@ti.com> <alpine.DEB.2.00.1206260433010.12797@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:43070 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752046Ab2FZK6l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 06:58:41 -0400
Received: by ghbf11 with SMTP id f11so4569150ghb.22
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 03:58:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1206260433010.12797@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Herbert Xu <herbert@gondor.hengli.com.au>

On Tuesday 26 June 2012 04:09 PM, Paul Walmsley wrote:
> Then at the same time, maybe get the rest of the drivers runtime-PM
> converted and acked through their respective maintainers.

So if I read your response correctly, you are saying all OMAP drivers
being converted to use runtime PM is a pre-requisite for OMAP moving 
over to use Common Clk framework?
