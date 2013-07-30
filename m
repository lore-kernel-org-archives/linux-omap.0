From: Nishanth Menon <nm@ti.com>
Subject: Re: Linux kernel for OMAP5432 uEVM
Date: Tue, 30 Jul 2013 07:24:44 -0500
Message-ID: <51F7B08C.1070200@ti.com>
References: <20130730033808.GA23486@cbz-workstation> <51F7387B.9060304@ti.com> <AEBD4502-35A4-4662-B435-7F4F0D5C5D6A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39693 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747Ab3G3MYq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jul 2013 08:24:46 -0400
In-Reply-To: <AEBD4502-35A4-4662-B435-7F4F0D5C5D6A@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chen Baozi <baozich@gmail.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org

On 07/30/2013 01:07 AM, Chen Baozi wrote:
>
> On Jul 30, 2013, at 11:52 AM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
>
>> Hi Chen,
>> On Tuesday 30 July 2013 09:08 AM, Chen Baozi wrote:
>>> Hi all,
>>>
>>> I'm trying to boot my OMAP5432 uEVM devboard with the lastest kernel of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git.
>> Which branch are you using ?
>
> the master branch.
>
>>> However, after u-boot loading uImage & DTB, there is no output message any
>>> more, such as:
>> Clk data might be missing here. Try merging the below branch and test it
>> https://git.kernel.org/cgit/linux/kernel/git/ssantosh/linux.git/log/?h=for_3.11/out_of_tree/omap5_clk_data
>
> Thanks, I'll have a try.

There is also clock data dts support now in Tero's series:
http://marc.info/?l=linux-omap&m=137456411706971&w=2


-- 
Regards,
Nishanth Menon
