From: Chen Baozi <baozich@gmail.com>
Subject: Re: Linux kernel for OMAP5432 uEVM
Date: Wed, 31 Jul 2013 20:30:07 +0800
Message-ID: <59979577-BEDE-4823-9497-BF122D1F6613@gmail.com>
References: <20130730033808.GA23486@cbz-workstation> <51F7387B.9060304@ti.com> <D890FDE7-B6AD-48E9-BE9C-3835F95E4457@gmail.com> <51F8CB7A.9070108@ti.com> <51F8F5A9.5080308@ti.com> <51F9003A.7080402@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:40554 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab3GaMaN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Jul 2013 08:30:13 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so717488pbb.41
        for <linux-omap@vger.kernel.org>; Wed, 31 Jul 2013 05:30:12 -0700 (PDT)
In-Reply-To: <51F9003A.7080402@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org

Hi Roger,
On Jul 31, 2013, at 8:16 PM, Roger Quadros <rogerq@ti.com> wrote:

> Hi Chen,
> 
> On 07/31/2013 02:31 PM, Roger Quadros wrote:
>> On 07/31/2013 11:31 AM, Lokesh Vutla wrote:
>>> Hi Chen,
>>> 
>>> On Wednesday 31 July 2013 01:19 PM, Chen Baozi wrote:
>>>> 
>>>> On Jul 30, 2013, at 11:52 AM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
>>>> 
>>>>> You can also use Linus's kernel with the above clk data branch.( OMAP5 uEVM boots)
>>>>> Please let me know if you need more info.
>>>> 
>>>> And the ethernet driver is not available by default?
>>> You need the following patch series recently posted by Roger:
>>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg92694.html
>>> 
>> 
>> Those will work only if you proceed with Tero's clock data in DT approach.
>> 
> 
> I've created a branch that contains all patches required to get ethernet working on 
> uEVM on top of Tero's DT clocks. I took the leisure of picking the baseport tree from
> Lokesh [1].
> 
> You can get the necessary stuff from branch 
> 	usbhost-uevm-3.11-rc3
> in git tree 
> 	git://github.com/rogerq/linux.git

Thanks a lot. I'll have a try.

Baozi

