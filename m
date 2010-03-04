From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH]  OMAP: McBSP: Drop unnecessary status/error bit clearing on reg_cache retrieved register values
Date: Fri, 5 Mar 2010 00:27:56 +0100
Message-ID: <201003050027.58642.jkrzyszt@tis.icnet.pl>
References: <201002231650.40351.jkrzyszt@tis.icnet.pl> <20100304084957.28c2a9c9.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:33347 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756598Ab0CDX1M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 18:27:12 -0500
In-Reply-To: <20100304084957.28c2a9c9.jhnikula@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Thursday 04 March 2010 07:49:57 Jarkko Nikula napisa=C5=82(a):
> On Tue, 23 Feb 2010 16:50:38 +0100
>
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
> > The MsBSP register cache will never have any error/status flags set=
,
> > since these flags are never written to the reg_cache. So it is kind=
 of
> > not necessary to clear these flags, which are actually always 0.
> >
> > In other words, clearing the status/error flags are not necessary, =
since
> > the reg_cache will never got these bits set. We can just write back=
 the
> > register content from the cache as it is when clearing an error
> > condition.
> >
> > Created against l-o for-next commit
> > 62a7c2cc4c8e57e80ccf379536f362fe6e863ac3 dated 2010-02-22.
> > Tested on Amstrad Delta.
> >
> > Reported-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>

Jarkko, thanks.

Tony,
It looks like my initial submission extra comments (quoted discussion w=
ith=20
Peter) was so confusing, that you had erratically marked this path=20
with "changes requested" in your patchowrk, so it get archived. Here is=
 the=20
URL, just in case you have troubles finding it now for applying :)
http://patchwork.kernel.org/patch/81476/

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
