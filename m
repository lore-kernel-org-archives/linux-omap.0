From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH] omap4: enable L2 prefetching
Date: Mon, 15 Nov 2010 17:09:26 +0000
Message-ID: <yw1xaala8qex.fsf@unicorn.mansr.com>
References: <1289838044-32016-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:40481 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932132Ab0KORJo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Nov 2010 12:09:44 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1PI2Yo-0005kR-Rt
	for linux-omap@vger.kernel.org; Mon, 15 Nov 2010 18:09:42 +0100
Received: from unicorn.mansr.com ([78.86.181.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 18:09:42 +0100
Received: from mans by unicorn.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 18:09:42 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> From: Mans Rullgard <mans@mansr.com>
>
> Enabling L2 prefetching improves performance as shown on Panda
> ES2.1 board with mem test, and it has measurable impact on
> performances. I think we should consider it, even though it damages
> "writes" a bit. (rebased to k.org)
> Usually the prefetch is used at both levels together L1 + L2, however=
,
> to enable the CP15 prefetch engines, these are under security, and on
> GP devices, we cannot enable it(e.g. on PandaBoard). However, just
> enabling PL310 prefetch seems to provide performance improvement,
> as shown in the data below (from Ubuntu) and would be a great thing
> to pull in.

What this does is enable automatic next line prefetching.  With this
enabled, whenever the PL310 receives a cachable read request, it
automatically prefetches the following cache line as well.  A larger
offset can be programmed in secure mode, but the TI ROM authors
neglected to include this.

Testing with FFmpeg showed a speedup of 10% with this patch in some
cases.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
