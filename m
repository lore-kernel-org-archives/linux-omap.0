From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCHv3 0/4] Add device tree data for omap5
Date: Mon, 20 Aug 2012 17:47:59 +0530
Message-ID: <CAKdam543ATO96rbhgCWKtGUGRQ_+=KSyAk-nGBknjC+BvJSmOw@mail.gmail.com>
References: <1344961473-13675-1-git-send-email-sourav.poddar@ti.com>
	<CAKdam57L8txFtE9ahy3u3vLW0XRP5z4QaNQKVFj9KaEFZE1qvg@mail.gmail.com>
	<503229F5.4030405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:44603 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751823Ab2HTMSB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 08:18:01 -0400
Received: by vbbfo1 with SMTP id fo1so5603849vbb.36
        for <linux-omap@vger.kernel.org>; Mon, 20 Aug 2012 05:17:59 -0700 (PDT)
In-Reply-To: <503229F5.4030405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Benoit,

On Mon, Aug 20, 2012 at 5:43 PM, Benoit Cousson <b-cousson@ti.com> wrote:
> On 08/20/2012 02:10 PM, Poddar, Sourav wrote:
>> Hi All,
>>
>> On Tue, Aug 14, 2012 at 9:54 PM, Sourav Poddar <sourav.poddar@ti.com> wrote:
>>> The following patch series add i2c support for omap5.
>>> As well as enable I2C based devices like pressure and temperature
>>> through device tree. Also add onchip keypad dts data.
>>>
>>> Cc: Benoit Cousson <b-cousson@ti.com>
>>> Cc: Felipe Balbi <balbi@ti.com>
>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>
>>> Sourav Poddar (4):
>>>   arm/dts: omap5-evm: Add I2C support
>>>   arm/dts: omap5-evm: Add tmp102 sensor support
>>>   arm/dts: omap5-evm: Add keypad data
>>>   arm/dts: omap5-evm: Add bmp085 sensor support
>>>
>>> v2->v3
>>> - Rebased on 3.6-rc1
>>> - Add comments for tmp102 and bmp085
>>>  arch/arm/boot/dts/omap5-evm.dts |   32 +++++++++++++++++++++++++++++++
>>>  arch/arm/boot/dts/omap5.dtsi    |   40 +++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 72 insertions(+), 0 deletions(-)
>>>
>> Any comment on this series?
>
> Didn't we mentioned updating the trivial-devices.txt in the
> documentation to list these devices?
>
I had posted a patch for updating the Documentation, though I created
a seperate
hwmon/tmp102.txt file. There is a comment to add it to trivial devices. So,
I will post a single patch doing so.

> Otherwise it it fine. You can add the documentation and I'll take these
> patches as well along with the others.
>
> Regards,
> Benoit
