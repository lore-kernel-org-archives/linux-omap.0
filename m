From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v3 1/3] ARM: omap: clk: add clk_prepare and clk_unprepare
Date: Mon, 30 Jul 2012 15:42:13 -0700
Message-ID: <CAJOA=zPmfq+WsAF-7nAkMGghPLYHpd+fCkrsv=3JSWLGMb-zkg@mail.gmail.com>
References: <1341224669-15231-1-git-send-email-rnayak@ti.com>
 <1341224669-15231-2-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1207301614590.8722@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:60977 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751075Ab2G3Wmf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jul 2012 18:42:35 -0400
Received: by pbbrq2 with SMTP id rq2so9281212pbb.6
        for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 15:42:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207301614590.8722@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, Jul 30, 2012 at 3:31 PM, Paul Walmsley <paul@pwsan.com> wrote:
> So if we make a change like this one, it seems like we would basically
> expect it to break once we start doing anything meaningful with
> clk_prepare(), like using clk_prepare() for voltage scaling or something
> that requires I2C?  We'd also probably want to mark this with some kind of
> "HACK" comment.

Hi Paul,

Did you have anything in mind to start using clk_prepare?  I still
hope to get rid of it some day and replace that call with a
combination of clk_enable and a check like clk_enable_can_sleep.

Regards,
Mike
