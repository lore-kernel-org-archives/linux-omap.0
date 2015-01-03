From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] cleanup ti-soc-thermal
Date: Sat, 03 Jan 2015 12:57:04 -0600
Message-ID: <54A83B80.1020508@ti.com>
References: <20150103111904.GA11545@amd> <20150103174804.GA20341@kahuna> <20150103185130.GA5950@amd>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35807 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbbACS5H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Jan 2015 13:57:07 -0500
In-Reply-To: <20150103185130.GA5950@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org
Cc: edubezval@gmail.com, rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 01/03/2015 12:51 PM, Pavel Machek wrote:
> On Sat 2015-01-03 11:48:04, Nishanth Menon wrote:
>> On 12:19-20150103, Pavel Machek wrote:
>>> Simplify code by removing goto's where they point to simple return.
>>>
>>> Avoid confusing |= on error values.
>>
>> Please split these up into chunks of related changes. there is white
>> space and quiet a few other changes all mixed in.
>
> Do you believe that the patch is too big to be understood? I don't
> think it is.
>
> It is four screens, and it is pretty obvious it does not change any
> code.

It basic patch generation stuff - where you are being nice to the 
reviewer. When you are doing functional changes, at least drop out or at 
the very least mention that there are white space changes in your patch 
submission.

I dont care too much to review stuff where I have to look at multiple 
changes in a single patch - trivial or not. Sorry.. just a waste of my time.

--
Regards,
Nishanth Menon

