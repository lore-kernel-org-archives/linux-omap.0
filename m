From: Felix Xiaozhu Lin <xzl@rice.edu>
Subject: Re: update: n8x0 idle power problem
Date: Mon, 26 Oct 2009 20:25:59 -0500
Message-ID: <f25d86460910261825j61a96688p949a1348c256c1a9@mail.gmail.com>
References: <f25d86460910261536k5003954ehec9f30a936a6766@mail.gmail.com>
	 <006001ca5698$1bad9960$a14ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:35839 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504AbZJ0BZy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 21:25:54 -0400
Received: by yxe17 with SMTP id 17so10360965yxe.33
        for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 18:25:59 -0700 (PDT)
In-Reply-To: <006001ca5698$1bad9960$a14ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Girish S G <girishsg@ti.com>, linux-omap@vger.kernel.org

Yes. I took off N810's battery and powered it with an external power supply.

By different power rails, you mean dissecting N810 to do finer-grain
power measurement?

Hope any people who have also done this 'overall' measurement can
confirm my observation or point out my mistake.

Best Regards,
--
Felix


On Mon, Oct 26, 2009 at 6:57 PM, Girish S G <girishsg@ti.com> wrote:
>
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felix
>> Xiaozhu Lin
>> Sent: Monday, October 26, 2009 5:36 PM
>> To: linux-omap@vger.kernel.org
>> Subject: update: n8x0 idle power problem
>>
>> Hi, All,
>>
>> Regarding the idle power problem I've mentioned in a mail last weekend:
>>
>> http://marc.info/?l=linux-omap&m=125634121921583&w=2
>>
>> I have spent more efforts on this problem. By comparing with PM debug
>> messages from Maemo kernel, it seems full-retention in linux-omap
>> 2.6.28 has no problem on n810. Moreover, I've observed that l-o kernel
>> consumes more power in other power states (e.g. when USB is plugged
>> and the screen is dim but not off, Maemo kernel takes ~90mA@3.8V while
>> l-o kernel takes ~180mA@3.8V). As a result, I think the extra power
>> may not be consumed by OMAP processor core but by some device.
>
> I assume you are measuring at the battery level(?). If you have measurement done across
> different rails then it would help to understand who is consuming more.
>
>
> -Girish
>
>
>
>
