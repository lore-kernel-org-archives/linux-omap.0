From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCHv7 06/12] ARM: OMAP4: suspend: Program all domains to retention
Date: Thu, 19 Jul 2012 18:16:27 +0400
Message-ID: <500816BB.3090809@mvista.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com> <1342704392-23657-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:65260 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab2GSOSA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jul 2012 10:18:00 -0400
Received: by lbbgm6 with SMTP id gm6so3652600lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 19 Jul 2012 07:17:58 -0700 (PDT)
In-Reply-To: <1342704392-23657-7-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

Hello.

On 07/19/2012 05:26 PM, Tero Kristo wrote:

> From: Rajendra Nayak <rnayak@ti.com>

> Remove the FIXME's in the suspend sequence since
> we now intend to support system level RET support.

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> [Jean Pihet <j-pihet@ti.com>: ported on top of the functional power
> states]

  Shouldn't Jean also have signed off?

> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

WBR, Sergei
