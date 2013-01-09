From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC v2 14/18] ARM: OMAP2+: AM33XX: control: Add some control
 module registers and APIs
Date: Wed, 9 Jan 2013 15:23:05 +0530
Message-ID: <50ED3E01.9010400@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com> <1356959231-17335-15-git-send-email-vaibhav.bedia@ti.com> <50EC3964.3060708@ti.com> <B5906170F1614E41A8A28DE3B8D121433ECDD089@DBDE01.ent.ti.com> <50ED1CB7.1090202@ti.com> <B5906170F1614E41A8A28DE3B8D121433ECDD528@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55381 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757422Ab3AIJwQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Jan 2013 04:52:16 -0500
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ECDD528@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Wednesday 09 January 2013 03:07 PM, Bedia, Vaibhav wrote:
> On Wed, Jan 09, 2013 at 13:01:03, Shilimkar, Santosh wrote:
>> On Wednesday 09 January 2013 11:08 AM, Bedia, Vaibhav wrote:
>>> On Tue, Jan 08, 2013 at 20:51:08, Shilimkar, Santosh wrote:
>>>> On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
>>>>> Add minimal APIs for writing to the IPC and the M3_TXEV registers
>>>>> in the Control module. These will be used in a subsequent patch which
>>>>> adds suspend-resume support for AM33XX.
>>>>>
>>>>> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>>>> Cc: Tony Lingren <tony@atomide.com>
>>>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>> Cc: Benoit Cousson <b-cousson@ti.com>
>>>>> Cc: Paul Walmsley <paul@pwsan.com>
>>>>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>>>> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
>>>>> ---
>>>> On Control module, we are trying to move driver/module
>>>> specific code to respective drivers. Can you not
>>>> add below code to ipc related driver component.
>>>>
>>>> If not, then patch as such is fine with me.
>>>>
>>>
>>> I had it in the pm33xx.c in the previous version. Kevin had asked me to
>>> move it to control.c. Should I revert move it back there?
>>>
>> pm33xx.c is not the right place. I was hoping to move to some driver.
>> If that is not possible then leave it in control module.
>>
>
> I think I'll leave it here for now. Could I have you ack in that case?
>
Yep.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

