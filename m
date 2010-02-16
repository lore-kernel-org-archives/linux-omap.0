From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: DSPBRIDGE: Reclaim all pending buffer on resource cleanup
Date: Tue, 16 Feb 2010 13:57:31 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602CA2B94C0@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602AA6587BF@dlee06.ent.ti.com>
 <4B7AE01E.4060100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52734 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933072Ab0BPT5g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 14:57:36 -0500
In-Reply-To: <4B7AE01E.4060100@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>



>-----Original Message-----
>From: Ramirez Luna, Omar
>Sent: Tuesday, February 16, 2010 12:13 PM
>To: Guzman Lugo, Fernando
>Cc: linux-omap; Hiroshi Doyu; Ameya Palande; Felipe Contreras
>Subject: Re: DSPBRIDGE: Reclaim all pending buffer on resource cleanup
>
>Hi,
>
>On 2/8/2010 4:20 PM, Guzman Lugo, Fernando wrote:
>>  From 727c83cd8b7e4aca51b214412eaa1b95cde6e4ea Mon Sep 17 00:00:00 2001
>> From: Fernando Guzman Lugo<x0095840@ti.com>
>> Date: Tue, 2 Feb 2010 20:38:10 -0600
>> Subject: [PATCH] DSPBRIDGE: Reclaim all pending buffer on resource
>cleanup
>>
>> Before in case of pending buffer while we try to close
>> a stream, it was doing only one reclaim, in the case there
>> were more pending buffer the second STRM_Close would also
>> fail, now all the pending buffers are reclaim.
>>
>> Signed-off-by: Fernando Guzman Lugo<x0095840@ti.com>
>> ---
>
>Shouldn't this be like?
>Patch 1: Fix
>Patch 2: code enhancement
>
>that said, isn't this missing a STRM_Close? (look below)

Yes, you re right, that is a mistake. I will send it again.

Regards,
Fernando.
>
>>   drivers/dsp/bridge/rmgr/drv.c |   37 ++++++++++++++++------------------
>---
>>   1 files changed, 16 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/dsp/bridge/rmgr/drv.c
>b/drivers/dsp/bridge/rmgr/drv.c
>> index edd8e97..660f375 100644
>> --- a/drivers/dsp/bridge/rmgr/drv.c
>> +++ b/drivers/dsp/bridge/rmgr/drv.c
>> @@ -458,40 +458,35 @@ static DSP_STATUS  DRV_ProcFreeSTRMRes(HANDLE
>hPCtxt)
>>   {
>>   	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
>>   	DSP_STATUS status = DSP_SOK;
>> -	DSP_STATUS status1 = DSP_SOK;
>>   	u8 **apBuffer = NULL;
>> -	struct STRM_RES_OBJECT *pSTRMList = NULL;
>>   	struct STRM_RES_OBJECT *pSTRMRes = NULL;
>> +	struct STRM_INFO strm_info;
>> +	struct DSP_STREAMINFO user;
>>   	u8 *pBufPtr;
>>   	u32 ulBytes;
>>   	u32 dwArg;
>>   	s32 ulBufSize;
>>
>> -	pSTRMList = pCtxt->pSTRMList;
>> -	while (pSTRMList != NULL) {
>> -		pSTRMRes = pSTRMList;
>> -		pSTRMList = pSTRMList->next;
>> -		if (pSTRMRes->uNumBufs != 0) {
>> -			apBuffer = MEM_Alloc((pSTRMRes->uNumBufs *
>> -					    sizeof(u8 *)), MEM_NONPAGED);
>> +	pSTRMRes = pCtxt->pSTRMList;
>> +	while (pSTRMRes) {
>> +		if (pSTRMRes->uNumBufs) {
>> +			apBuffer = MEM_Alloc(pSTRMRes->uNumBufs *
>> +					    sizeof(u8 *), MEM_NONPAGED);
>> +			if (!apBuffer)
>> +				return DSP_EMEMORY;
>>   			status = STRM_FreeBuffer(pSTRMRes->hStream, apBuffer,
>>   						pSTRMRes->uNumBufs, pCtxt);
>>   			MEM_Free(apBuffer);
>>   		}
>> -		status = STRM_Close(pSTRMRes->hStream, pCtxt);
>> -		if (DSP_FAILED(status)) {
>> -			if (status == DSP_EPENDING) {
>> -				status = STRM_Reclaim(pSTRMRes->hStream,
>> -						&pBufPtr,&ulBytes,
>> -						     (u32 *)&ulBufSize,&dwArg);
>> -				if (DSP_SUCCEEDED(status))
>> -					status = STRM_Close(pSTRMRes->hStream,
>> -							pCtxt);
>> +		strm_info.pUser =&user;
>> +		user.uNumberBufsInStream = 0;
>> +		STRM_GetInfo(pSTRMRes->hStream,&strm_info, sizeof(strm_info));
>> +		while (strm_info.pUser->uNumberBufsInStream--)
>> +			STRM_Reclaim(pSTRMRes->hStream,&pBufPtr,&ulBytes,
>> +					     (u32 *)&ulBufSize,&dwArg);
>>
>
>Here.
>
>> -			}
>> -		}
>>   	}
>> -	return status1;
>> +	return status;
>>   }
>>
>>   /* Release all Stream resources and its context
>
>- omar
