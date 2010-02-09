From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: Validate stream handle from user
Date: Tue, 09 Feb 2010 19:33:41 +0200
Message-ID: <1265736821.2832.12.camel@sanganak>
References: <B852767254C5C94EBB1040EE0EFA06008C89E962@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:63222 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755030Ab0BIRfV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 12:35:21 -0500
In-Reply-To: <B852767254C5C94EBB1040EE0EFA06008C89E962@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Ramos Falcon, Ernesto" <ernesto@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>

Hi Ernesto,

On Tue, 2010-02-09 at 18:09 +0100, ext Ramos Falcon, Ernesto wrote:
> From 991bd676e160a5500cb511a78afcac838ff003e4 Mon Sep 17 00:00:00 2001
> From: Ernesto Ramos <ernesto@ti.com>
> Date: Fri, 29 Jan 2010 20:00:26 -0600
> Subject: [PATCH] DSPBRIDGE: Validate stream handle from user.
> 
> Add checks to verify strm handle from user.
> 
> Signed-off-by: Ernesto Ramos <ernesto@ti.com>
> ---
>  drivers/dsp/bridge/pmgr/wcd.c  |   42 +++++++++++++
>  drivers/dsp/bridge/rmgr/strm.c |  134 ++++++++++++++++-----------------------
>  2 files changed, 97 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
> index 2e6eeb0..78c7acd 100644
> --- a/drivers/dsp/bridge/pmgr/wcd.c
> +++ b/drivers/dsp/bridge/pmgr/wcd.c
> @@ -1517,6 +1517,22 @@ func_cont:
>  	return status;
>  }
>  
> +
> +bool validate_strm_handle(struct STRM_OBJECT *hStrm, void *pr_ctxt)
> +{
> +	bool retVal = false;
> +	struct PROCESS_CONTEXT *pCtxt = pr_ctxt;
> +	struct STRM_RES_OBJECT *pStrm = pCtxt->pSTRMList;
> +
> +	while (pStrm && !retVal) {
> +		if (hStrm == pStrm->hStream)

If you have several streams allocated by user space, then what you are
validating here is for any node! Is that ok?

This validation and design itself doesn't look good to me. If we don't
want to trust user space, then instead of checking the stream handle in
every function it is better to store all user space specific date inside
pr_context and use it from there.

Cheers,
Ameya.

