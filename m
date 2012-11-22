From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 02/16] mfd: omap-usb-tll: Clean up clock handling
Date: Thu, 22 Nov 2012 10:19:17 +0200
Message-ID: <50ADE005.5020300@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com> <1352990054-14680-3-git-send-email-rogerq@ti.com> <20121121115556.GD10216@arwen.pp.htv.fi> <50ACCAE0.3030907@ti.com> <20121121140354.GR10216@arwen.pp.htv.fi> <50ACF5CD.9010209@ti.com> <20121121193952.GA14290@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43791 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754222Ab2KVTAI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Nov 2012 14:00:08 -0500
In-Reply-To: <20121121193952.GA14290@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On 11/21/2012 09:39 PM, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Nov 21, 2012 at 05:39:57PM +0200, Roger Quadros wrote:
>> On 11/21/2012 04:03 PM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Wed, Nov 21, 2012 at 02:36:48PM +0200, Roger Quadros wrote:
>>>>>>  		break;
>>>>>>  	default:
>>>>>> -		dev_err(dev, "TLL version failed\n");
>>>>>> -		ret = -ENODEV;
>>>>>> -		goto err_ioremap;
>>>>>> +		tll->nch = DEFAULT_TLL_CHANNEL_COUNT;
>>>>>> +		dev_info(dev,
>>>>>> +		 "USB TLL Rev : 0x%x not recognized, assuming %d channels\n",
>>>>>> +			ver, tll->nch);
>>>>>
>>>>> this hsould be dev_dbg().
>>>>>
>>>>
>>>> I think it should be more of a warning because it signals a problem.
>>>> There is another pr_info in the success path which could probably be a
>>>> dev_dbg.
>>>
>>> it's not a problem at all. It just means that a newer OMAP has come to
>>> market and perhaps we don't need extra code to support it. A revision
>>> detection should *never* be grounds to failure. When we can't understand
>>> the revision, we default to the highest possible value we know.
>>>
>>> that's not an error.
>>
>> Agreed. I'm not treating it as an error. We still continue probe and the
>> driver should work for newer revisions. Just prints a line on the
>> console about the new revision. Thought it would be useful to us, but if
>> you think it is a problem I don't mind removing it :).
> 
> that's the thing. It _is_ useful to *us*, kernel/device-driver
> engineers. But for the end user it just ends up as yet another
> meaningless print in dmesg ;-)
> 

Okay, makes sense. I'll convert it to dev_dbg().

--
cheers,
-roger
