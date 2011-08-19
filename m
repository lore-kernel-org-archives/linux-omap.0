From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH 0/3] Add support for TI814X processor series
Date: Fri, 19 Aug 2011 09:58:40 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03ABD26D94@dbde02.ent.ti.com>
References: <1312479869-21948-1-git-send-email-hemantp@ti.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B03ABB099E0@dbde02.ent.ti.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03ABD26CF7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45063 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab1HSE2v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Aug 2011 00:28:51 -0400
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B03ABD26CF7@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

linux-arm-kernel-bounces@lists.infradead.org wrote on :

> linux-arm-kernel-bounces@lists.infradead.org wrote on :
> 
>> Hello,
>> 
>> Pedanekar, Hemant wrote on Thursday, August 04, 2011 11:14 PM:
>> 
>>> This patch set adds support for DM814x, C6A814x and AM387x device series
>>> having Cortex-A8 MPU. 
>>> 
>>> The technical documents are available from following link:
>>> 
>>> http://focus.ti.com/docs/prod/folders/print/tms320dm8148.html
>>> 
>>> This series is referred in code as TI814X.
>>> 
>>> Since these devices share similar architecture as TI816X devices, existing
>>> TI816X code is updated to accomodate TI814X support. The code shared
>>> across TI816X and TI814X devices is updated with TI81XX/ti81xx prefix as
>>> applicable, while maintaining cpu_is_ti816x() and cpu_is_ti814x() to
>>> distinguish specific execution differences.
>>> 
>>> Hemant Pedanekar (3):
>>>   TI81XX: Prepare for addition of TI814X support
>>>   TI814X: Add cpu type macros and detection support
>>>   TI814X: Create board support and enable build for TI8148 EVM
>>> 
>> [...]
>> 
> Hello,
> Can you please provide comments on these patches?
> Thanks.
>    Hemant

Please disregard, I had missed Tony's comments.		

   Hemant