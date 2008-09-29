From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: i2c errors on omap3430sdp
Date: Mon, 29 Sep 2008 12:14:15 -0500
Message-ID: <A24693684029E5489D1D202277BE89441213A6C4@dlee02.ent.ti.com>
References: <423644ca0809290917u81926efxf329fc193b9e863b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37657 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbYI2ROY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 13:14:24 -0400
In-Reply-To: <423644ca0809290917u81926efxf329fc193b9e863b@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Marini <jason.marini@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Jason, Felipe,

Apparently it was a HW issue with the camkit I was using.

I realized that when trying with another one :)

Anyways, I appreciate your help and time.

Jason, BTW, this messages kept appearing endlessly without being able to kill the process, is that expected?

Regards,
Sergio

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Jason Marini
Sent: Monday, September 29, 2008 11:18 AM
To: linux-omap@vger.kernel.org
Subject: Re: i2c errors on omap3430sdp

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
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

