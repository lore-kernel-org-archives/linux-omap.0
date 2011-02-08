From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 3/9] omap4: powerdomain: Use intended PWRSTS_* flags
 instead of values
Date: Mon, 7 Feb 2011 18:45:31 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102071845140.21991@utopia.booyaka.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com> <1296813544-25170-4-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57811 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133Ab1BHBpc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Feb 2011 20:45:32 -0500
In-Reply-To: <1296813544-25170-4-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

On Fri, 4 Feb 2011, Santosh Shilimkar wrote:

> IVAHD and ABE power domain logic state is populated using directly
> value instead of the capability flags.
> 
> Fix the same.
> 
> This was getting generated due to a bug 'gen_logicst' macro
> in powerdomain autogen script bug which is fixed as well.

Should we try to get this one into the -rc series, since it is a bug-fix ?

- Paul
