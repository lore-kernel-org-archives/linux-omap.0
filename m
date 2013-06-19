From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: dts: Protect pinctrl headers against multiple inclusions
Date: Wed, 19 Jun 2013 04:33:55 -0500
Message-ID: <51C17B03.7000502@ti.com>
References: <1370962250-9745-1-git-send-email-florian.vaussard@epfl.ch> <20130611215756.9B0CA3E0D8D@localhost> <51B81863.10403@epfl.ch> <51B89F67.9020302@ti.com> <51C179A1.5050400@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44023 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933993Ab3FSJeb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jun 2013 05:34:31 -0400
In-Reply-To: <51C179A1.5050400@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: Grant Likely <grant.likely@secretlab.ca>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org

Hi Florian,

On 06/19/2013 04:28 AM, Florian Vaussard wrote:
> Hello Benoit,
>
> On 06/12/2013 06:18 PM, Cousson, Benoit wrote:
>> Hi Florian,
>>
>> On 6/12/2013 8:42 AM, Florian Vaussard wrote:
>>> Hello Grant,
>>>
>>> On 06/11/2013 11:57 PM, Grant Likely wrote:
>>>> On Tue, 11 Jun 2013 16:50:50 +0200, Florian Vaussard
>>>> <florian.vaussard@epfl.ch> wrote:
>>>>> Pinctrl headers were not protected with #ifndef.
>>>>>
>>>>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>>>>
>>>> Obviously this needs to go in via whatever tree added the modified
>>>> header files.
>>>>
>>>
>>> I authored these files, sorry for this stupid omission. Benoit, can you
>>> take this patch?
>>
>> Yes, sure, I'll take it with Grant's ack.
>>
>
> I think that you missed this one.

In was in the pipe but not pushed yet. That will be done soon.

Thanks,
Benoit

