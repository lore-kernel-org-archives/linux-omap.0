From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Validate node handle from user
Date: Tue, 9 Feb 2010 11:52:44 -0600
Message-ID: <B852767254C5C94EBB1040EE0EFA06008C89EA24@dlee01.ent.ti.com>
References: <B852767254C5C94EBB1040EE0EFA06008C89E95B@dlee01.ent.ti.com>
 <1265736734.2832.11.camel@sanganak>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47953 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754862Ab0BIRws convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 12:52:48 -0500
In-Reply-To: <1265736734.2832.11.camel@sanganak>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>



>-----Original Message-----
>From: Ameya Palande [mailto:ameya.palande@nokia.com]
>Sent: Tuesday, February 09, 2010 11:32 AM
>To: Ramos Falcon, Ernesto
>Cc: linux-omap@vger.kernel.org; Contreras Felipe (Nokia-D/Helsinki); Doyu
>Hiroshi (Nokia-D/Helsinki)
>Subject: Re: [PATCH] DSPBRIDGE: Validate node handle from user
>
>Hi Ernesto,
>
>On Tue, 2010-02-09 at 18:08 +0100, ext Ramos Falcon, Ernesto wrote:
>> From 8310b586b025b0703c3951560849c4ea0250b6e1 Mon Sep 17 00:00:00 2001
>> From: Ernesto Ramos <ernesto@ti.com>
>> Date: Fri, 29 Jan 2010 16:21:59 -0600
>> Subject: [PATCH] DSPBRIDGE: Validate node handle from user.
>>
>> Add checks to validate the node handles received from user.
>>
>> Signed-off-by: Ernesto Ramos <ernesto@ti.com>
>> ---
>>  drivers/dsp/bridge/pmgr/wcd.c  |   91 ++++++++++++++++++++-
>>  drivers/dsp/bridge/rmgr/node.c |  174 +++++++++++++---------------------
>-----
>>  2 files changed, 146 insertions(+), 119 deletions(-)
>>
>> diff --git a/drivers/dsp/bridge/pmgr/wcd.c
>b/drivers/dsp/bridge/pmgr/wcd.c
>> index 74654dc..2e6eeb0 100644
>> --- a/drivers/dsp/bridge/pmgr/wcd.c
>> +++ b/drivers/dsp/bridge/pmgr/wcd.c
>> @@ -1066,6 +1066,24 @@ u32 PROCWRAP_Stop(union Trapped_Args *args, void
>*pr_ctxt)
>>         return retVal;
>>  }
>>
>> +bool validate_node_handle(struct NODE_OBJECT *hNode, void *pr_ctxt)
>> +{
>> +       bool retVal = false;
>> +       struct PROCESS_CONTEXT *pCtxt = pr_ctxt;
>> +       struct NODE_RES_OBJECT *pNode = pCtxt->pNodeList;
>> +
>> +       if (hNode == (struct NODE_OBJECT *) DSP_HGPPNODE)
>> +               retVal = true;
>> +
>> +       while (pNode && !retVal) {
>> +               if (hNode == pNode->hNode)
>
>If you have several nodes allocated by user space, then what you are
>validating here is for any node! Is that ok?
>
>This validation and design itself doesn't look good to me. If we don't
>want to trust user space, then instead of checking the node handle in
>every function it is better to store all user space specific date inside
>pr_context and use it from there.
>

The user can launch several nodes, how are we going to know which node handle to use?
I think we may need to receive at least one index or id to the node handle.


>Cheers,
>Ameya.

