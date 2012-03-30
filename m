From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: OMAP4 errata i740
Date: Fri, 30 Mar 2012 14:02:57 +0200
Message-ID: <4F75A0F1.4030904@ti.com>
References: <1333094862.1932.15.camel@deskari>  <CAMQu2gx30OLnxTS8TOh=xc36fFgtPs08Zhhx6raYDAQ3nxfO1g@mail.gmail.com>  <1333095982.1932.21.camel@deskari> <4F756F66.6020103@ti.com>  <4F757014.5030006@ti.com> <4F757262.60409@ti.com> <4F7589A3.6080104@ti.com>  <4F758B15.1040905@ti.com> <4F75915D.9050205@ti.com>  <CAMQu2gzXoqwdmd6xMs+Rp6TQDJtjQf+ydtRb3AL6+APnmfHzHA@mail.gmail.com>  <4F75963C.2000508@ti.com>  <CAMQu2gx0uOV9Kr=eQe_3e93RfE8L5txLsV4bvYOgAnjxQZr-GA@mail.gmail.com> <1333108748.1932.37.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44385 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934221Ab2C3MDB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 08:03:01 -0400
In-Reply-To: <1333108748.1932.37.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Archit Taneja <a0393947@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>

On 3/30/2012 1:59 PM, Tomi Valkeinen wrote:
> On Fri, 2012-03-30 at 16:50 +0530, Shilimkar, Santosh wrote:
>
>> Exactly. That's what I mean. You tweak sysconfig or clockdomain,
>> both are messy.
>>
>> if one need to choose between two bad options, I guess sysconifig
>> one is better because that is local to IPs and there is some way today
>> for drivers to manage sysconfig directly.
>
> If the driver touches sysconfig, isn't it possible that hwmod/something
> just reverts the changes? I mean, sysconfig register is supposedly
> "owned" by the arch code, and if the driver modifies it there could be a
> race condition.

No because we had to expose API from hwmod core code to do that already 
because of various HW bugs.
So you will not access it directly but through the hwmod API.

The only issue is that these API are exposed today through pdata 
function pointers, and thus this is not usable in a DT case :-(

Regards,
Benoit
