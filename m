From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 1/2] I2C: i2c-omap: Change device name: i2c_omap ->
 omap_i2c
Date: Fri, 10 Dec 2010 09:28:37 +0100
Message-ID: <4D01E4B5.1010703@ti.com>
References: <1291904657-32729-1-git-send-email-b-cousson@ti.com>	<1291904657-32729-2-git-send-email-b-cousson@ti.com>	<878vzydgxr.fsf@deeprootsystems.com>	<20101209190110.GR20097@trinity.fluff.org>,<87wrni7jys.fsf@deeprootsystems.com> <BC214410FD04D84F9079A6242365970707D4FA@008-AM1MPN1-001.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46502 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab0LJI26 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 03:28:58 -0500
In-Reply-To: <BC214410FD04D84F9079A6242365970707D4FA@008-AM1MPN1-001.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "aaro.koskinen@nokia.com" <aaro.koskinen@nokia.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "ben-i2c@fluff.org" <ben-i2c@fluff.org>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>

On 12/9/2010 11:18 PM, aaro.koskinen@nokia.com wrote:
> Hi,
>
> Kevin Hilman [khilman@deeprootsystems.com]:
>> Ben Dooks<ben-i2c@fluff.org>  writes:
>>> Renaming stuff like this is going to have an impact on the userspace
>>> as anyone looking through /sys's driver heirarchy is going to miss the
>>> old name...
>>>
>>> It all depends if you really want to go ahead with this...
>>
>> Yes, we are aware of the userspace impact, but this name change makes
>> all devices on OMAP have consistent names and actually improves the
>> ability to have userspace tools have consistent naming as well.
>
> So there are no imporant users, or if there is, they are prepared for this change?

Well, I do not know any user of that today. Do you have some in mind?

Benoit

