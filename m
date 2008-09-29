From: "Jason Marini" <jason.marini@gmail.com>
Subject: Re: i2c errors on omap3430sdp
Date: Mon, 29 Sep 2008 12:17:54 -0400
Message-ID: <423644ca0809290917u81926efxf329fc193b9e863b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:48444 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbYI2QRz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 12:17:55 -0400
Received: by mail-gx0-f16.google.com with SMTP id 9so10693980gxk.13
        for <linux-omap@vger.kernel.org>; Mon, 29 Sep 2008 09:17:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>> Hi all,
>>
>> I'm currently testing the OV3640 CSI2 camera implementation for 3430SDP, and I had \
>> it working some weeks ago.
>> Today I did a git pull from the master branch.
>>
>> Without changing anything i2c related, I now sometimes get a message that I wasn't \
>> getting before:
>> i2c_omap i2c_omap.2: controller timed out waiting for start condition to finish
>> i2c_omap i2c_omap.2: controller timed out waiting for start condition to finish
>>
>> Anyone is seeing this?
>>
>> Any omap i2c registration changes that I could be missing?
>
>Is you driver new style i2c driver ???
>
>Can you put some printks in your driver and try to narrow down which
>transfer is triggering this timeout ??
>
>--
>balbi
>--

Sergio,

I recently added a patch to print out that message if the i2c bus took
longer than 1s to poll for the i2c start condition.  I had been seeing
kernel lockups when doing soft resets, and JTAG debug pointed me an
infinite loop in the omap_i2c_read_reg function.  I added a timeout,
as can be seen in my patch here:
http://marc.info/?l=linux-omap&m=121995188317408&w=2

You are seeing this message instead of a kernel hang :^)

-Jason Marini
