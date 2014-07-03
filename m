From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v3 5/7] ARM: DRA7: hwmod: Add SYSCONFIG for usb_otg_ss
Date: Thu, 3 Jul 2014 16:12:30 +0530
Message-ID: <53B53396.7050804@ti.com>
References: <1399283686-6127-1-git-send-email-rogerq@ti.com> <1399283686-6127-6-git-send-email-rogerq@ti.com> <53A173A5.7020509@ti.com> <53A175DC.8080709@ti.com> <53B3EC4B.9080202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36706 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757278AbaGCKmk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2014 06:42:40 -0400
In-Reply-To: <53B3EC4B.9080202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, kishon@ti.com, tony@atomide.com, balbi@ti.com, bcousson@baylibre.com, "Menon, Nishanth" <nm@ti.com>, george.cherian@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On Wednesday 02 July 2014 04:56 PM, Roger Quadros wrote:
> Sekhar,
> 
> On 06/18/2014 02:19 PM, Rajendra Nayak wrote:
>> On Wednesday 18 June 2014 04:40 PM, Roger Quadros wrote:
>>> + Nishant and Rajendra for review.
>>>
>>> On 05/05/2014 12:54 PM, Roger Quadros wrote:
>>>> Add the sysconfig class bits for the Super Speed USB
>>>> controllers
>>>>
>>>> CC: Paul Walmsley <paul@pwsan.com>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>
>> verified against TRM version vP, looks good to me.
>> Reviewed-by: Rajendra Nayak <rnayak@ti.com>
> 
> Could you please give your Tested-by tag for this? Then we can take this into 3.16-rc.

Boot tested on my DRA7x EVM.

Boot log here: http://paste.ubuntu.com/7741337/

Tested-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
