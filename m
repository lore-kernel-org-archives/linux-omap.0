From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: Validate node handle from user
Date: Tue, 09 Feb 2010 19:32:14 +0200
Message-ID: <1265736734.2832.11.camel@sanganak>
References: <B852767254C5C94EBB1040EE0EFA06008C89E95B@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:62791 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416Ab0BIRdE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 12:33:04 -0500
In-Reply-To: <B852767254C5C94EBB1040EE0EFA06008C89E95B@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Ramos Falcon, Ernesto" <ernesto@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>

Hi Ernesto,

On Tue, 2010-02-09 at 18:08 +0100, ext Ramos Falcon, Ernesto wrote:
> From 8310b586b025b0703c3951560849c4ea0250b6e1 Mon Sep 17 00:00:00 2001
> From: Ernesto Ramos <ernesto@ti.com>
> Date: Fri, 29 Jan 2010 16:21:59 -0600
> Subject: [PATCH] DSPBRIDGE: Validate node handle from user.
> 
> Add checks to validate the node handles received from user.
> 
> Signed-off-by: Ernesto Ramos <ernesto@ti.com>
> ---
>  drivers/dsp/bridge/pmgr/wcd.c  |   91 ++++++++++++++++++++-
>  drivers/dsp/bridge/rmgr/node.c |  174 +++++++++++++--------------------------
>  2 files changed, 146 insertions(+), 119 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
> index 74654dc..2e6eeb0 100644
> --- a/drivers/dsp/bridge/pmgr/wcd.c
> +++ b/drivers/dsp/bridge/pmgr/wcd.c
> @@ -1066,6 +1066,24 @@ u32 PROCWRAP_Stop(union Trapped_Args *args, void *pr_ctxt)
>         return retVal;
>  }
> 
> +bool validate_node_handle(struct NODE_OBJECT *hNode, void *pr_ctxt)
> +{
> +       bool retVal = false;
> +       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;
> +       struct NODE_RES_OBJECT *pNode = pCtxt->pNodeList;
> +
> +       if (hNode == (struct NODE_OBJECT *) DSP_HGPPNODE)
> +               retVal = true;
> +
> +       while (pNode && !retVal) {
> +               if (hNode == pNode->hNode)

If you have several nodes allocated by user space, then what you are
validating here is for any node! Is that ok?

This validation and design itself doesn't look good to me. If we don't
want to trust user space, then instead of checking the node handle in
every function it is better to store all user space specific date inside
pr_context and use it from there.

Cheers,
Ameya.

