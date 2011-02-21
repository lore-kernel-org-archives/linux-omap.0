From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: OMAP4: IRQ line of CortexA9 performance monitor
Date: Mon, 21 Feb 2011 17:18:57 +0000
Message-ID: <yw1x62sd1f26.fsf@unicorn.mansr.com>
References: <AANLkTin3q+rv+fcgCE6nwTN+=v_uQzT-Sn++gr6ekXcp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45640 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755010Ab1BURTR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 12:19:17 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1PrZPl-0007Mr-Jv
	for linux-omap@vger.kernel.org; Mon, 21 Feb 2011 18:19:13 +0100
Received: from unicorn.mansr.com ([78.86.181.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 18:19:13 +0100
Received: from mans by unicorn.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 18:19:13 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Ming Lei <tom.leiming@gmail.com> writes:

> Hi,
>
> From chapter 17 of "Interrupt controller", OMAP4 TRM, I can't
> find what is the interrupt line of CortexA9 performance monitor
> in omap4. Seems without this information, we can't use perf on
> omap4.
>
> Any suggestions or ideas about it?

The PMU interrupt is routed through the CTI, which needs to be properly
configured.  Unfortunately, the CTI is not documented in the public TRM=
,
and nobody has seen fit to submit a patch suitable for upstream.  Some
dirty hacks have been posted, though.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
