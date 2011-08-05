From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 5/5] OMAP4: DSS2: VIDEO3 pipeline support
Date: Fri, 5 Aug 2011 15:16:19 +0530
Message-ID: <4E3BBBEB.6040804@ti.com>
References: <1312530172-24095-1-git-send-email-archit@ti.com>	 <1312530172-24095-6-git-send-email-archit@ti.com>	 <CAB2ybb_fDM8bDr1CsFUHRhE9fNoSKvOoWTktQGzh+VV=efEMZw@mail.gmail.com>	 <CAB2ybb_5saT0_DCcL5iTKaNfJfV32iQvV_mhv_uC+tt-J4CNgA@mail.gmail.com>	 <4E3BB603.7010908@ti.com> <1312536396.1907.37.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50200 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017Ab1HEJhj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Aug 2011 05:37:39 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p759baHK002814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 04:37:38 -0500
In-Reply-To: <1312536396.1907.37.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "Semwal, Sumit" <sumit.semwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Friday 05 August 2011 02:56 PM, Valkeinen, Tomi wrote:
> On Fri, 2011-08-05 at 14:51 +0530, Archit Taneja wrote:
>> Hi,
>>
>> On Friday 05 August 2011 02:13 PM, Semwal, Sumit wrote:
>>>> On Fri, Aug 5, 2011 at 8:42 AM, Archit Taneja<archit@ti.com>   wrote:
>>>>>
>>>>> Add support for VIDEO3 pipeline on OMAP4:
>>>>> - Add VIDEO3 pipeline information in dss_features and omapdss.h
>>>>> - Add VIDEO3 pipeline register coefficients in dispc.h
>>>>> - Create a new overlay structure corresponding to VIDEO3.
>>>>>
>>>>> Signed-off-by: Archit Taneja<archit@ti.com>
>>>>> ---
>>> <snip>
>>>>> -       u32     fifo_size[3];
>>>>> +       u32     fifo_size[MAX_DSS_OVERLAYS];
>>>>
>>> Do you think it makes some sense in splitting the 'generalisation'
>>> like this that you've done in the patch from the xxx_VIDEO3 changes?
>>
>> Yes, I could make a small patch which replaces "3" with
>> MAX_DSS_OVERLAYS, and the patch which introduces VIDEO3 pipe will
>> increase the macro value from 3 to 4.
>
> While Sumit is right, I don't think that's worth the effort if it's just
> about this single line.

I have made the changes anyway, if needed.

Archit
>
> I think this patch set looks fine. At least the register dump works just
> the way I like it. I didn't test the vid3 yet, though.
>
>   Tomi
>
>

