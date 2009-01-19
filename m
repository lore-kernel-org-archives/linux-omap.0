From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: RE: [PATCH] DSPBRIDGE Memory leak when dynbase is loaded
Date: Mon, 19 Jan 2009 11:47:55 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F220B8EA@dlee03.ent.ti.com>
References: <A24693684029E5489D1D202277BE8944165DCB8A@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42713 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbZASRsH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 12:48:07 -0500
In-Reply-To: <A24693684029E5489D1D202277BE8944165DCB8A@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Hi Sergio,

>> @@ -1806,6 +1806,8 @@ loop_end:
>>  		if (syms->Find_Matching_Symbol
>>  			(syms, LOADER_DLLVIEW_ROOT) == NULL)
>>  			syms->Deallocate(syms, root);
>> +		if (root != NULL)
>> +			syms->Deallocate(syms, root);
>
>I would suggest a simpler check like this:
>
>		if (!syms->Find_Matching_Symbol(syms, LOADER_DLLVIEW_ROOT) ||
>									root)
>			syms->Deallocate(syms, root);
>

Thanks for your comments, I'll make some more changes and resend.

Regards,

Omar

