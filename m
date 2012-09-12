From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv7 06/12] ARM: OMAP4: suspend: Program all domains to retention
Date: Wed, 12 Sep 2012 14:36:18 -0700
Message-ID: <878vcex6st.fsf@deeprootsystems.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
	<1342704392-23657-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48585 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138Ab2ILVgU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 17:36:20 -0400
Received: by obbuo13 with SMTP id uo13so3412263obb.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Sep 2012 14:36:19 -0700 (PDT)
In-Reply-To: <1342704392-23657-7-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Thu, 19 Jul 2012 16:26:26 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, paul@pwsan.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> Remove the FIXME's in the suspend sequence since
> we now intend to support system level RET support.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> [Jean Pihet <j-pihet@ti.com>: ported on top of the functional power
> states]
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>

Paul, go ahead and queue this one with the others.

Kevin
