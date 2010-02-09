From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: Validate Processor Handle from user
Date: Tue, 09 Feb 2010 19:26:43 +0200
Message-ID: <1265736403.2832.6.camel@sanganak>
References: <B852767254C5C94EBB1040EE0EFA06008C89E954@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:52213 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754906Ab0BIR1Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 12:27:25 -0500
In-Reply-To: <B852767254C5C94EBB1040EE0EFA06008C89E954@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Ramos Falcon, Ernesto" <ernesto@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>

Hi Ernesto,

On Tue, 2010-02-09 at 18:07 +0100, ext Ramos Falcon, Ernesto wrote:
> From 07b9f6d30c9d363ba0c4cefded8068662e1048c4 Mon Sep 17 00:00:00 2001
> From: Ernesto Ramos <ernesto@ti.com>
> Date: Wed, 3 Feb 2010 19:43:31 -0600
> Subject: [PATCH] DSPBRIDGE: Validate Processor Handle from user.
> 
> Add check to validate the Processor handle received
> from user.
> 
> Signed-off-by: Ernesto Ramos <ernesto@ti.com>
> ---
>  drivers/dsp/bridge/pmgr/wcd.c  |   86 ++++++++++++-
>  drivers/dsp/bridge/rmgr/proc.c |  280 ++++++++++++++--------------------------
>  2 files changed, 179 insertions(+), 187 deletions(-)

My understanding: In bridge_open() we allocate a new process_context and
store it in filp->private_data which can't be modified / tampered by
user space.

If this understanding is correct, then why we need to perform any
validation on data hold be process_context pointer stored in
flip->private_data?

If you don't trust hProcessor handle received from user space arguments
then instead of using that we can just use pCtxt->hProcessor!

I don't understand why we need validation so NACK from my side.

Cheers,
Ameya.

