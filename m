From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 05/12] ARM: OMAP3xxx: PM: convert to use the functional
 power states API
Date: Wed, 12 Dec 2012 11:29:11 +0100
Message-ID: <CAORVsuWzg7es6rv15+-aGBkwXSZ4Pbd4Kz3qp_aej8vk9t=TxA@mail.gmail.com>
References: <20121209174545.6933.59371.stgit@dusk.lan>
	<20121209175312.6933.92995.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38703 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab2LLK3L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Dec 2012 05:29:11 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so1373368ieb.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Dec 2012 02:29:11 -0800 (PST)
In-Reply-To: <20121209175312.6933.92995.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jean Pihet <j-pihet@ti.com>

Paul,

-resending in plain text only, sorry about that-

On Sun, Dec 9, 2012 at 6:53 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> From: Jean Pihet <jean.pihet@newoldbits.com>
>
> Use the functional power states as the API to control power domains:
>
> - use the PWRDM_FUNC_PWRST_* macros for the power states and logic
>   settings,
>
> - the function pwrdm_set_next_fpwrst(), which controls the power domains
>   next power and logic settings, shall be used instead of
>   pwrdm_set_next_pwrst() to program the power domains next states,
>
> - the function pwrdm_set_fpwrst(), which programs the power domains
>   power and logic settings, shall be used instead of
>   omap_set_pwrdm_state().
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> [paul@pwsan.com: split the original patch into OMAP2/3/4 variants;
>  clean up omap3_save_secure_ram_context(); fix commit message;
>  warn if sets fail; various other changes]


There are a lot of 'XXX' comments, can this be fixed by a proper comment?

Regards,
Jean
