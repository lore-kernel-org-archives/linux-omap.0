From: Simon Knopp <simon.knopp@pg.canterbury.ac.nz>
Subject: Re: YUV422 input to CPI?
Date: Mon, 23 Apr 2012 15:18:35 +1200
Message-ID: <511240CD-BADD-4E0F-8F4B-0107A420BF9E@pg.canterbury.ac.nz>
References: <E47FC7FC-B1CC-4E8A-9957-AEAF483DDAFA@pg.canterbury.ac.nz>
 <CA+2YH7vpCdXhJUQrsZ+3Tp=b5q=3su1K4TaEumWGeMeCZXpvyw@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83E9F8032@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantvb.canterbury.ac.nz ([132.181.2.28]:3545 "EHLO
	cantvb.canterbury.ac.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121Ab2DWDSj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Apr 2012 23:18:39 -0400
Received: from CONVERSION-DAEMON.it.canterbury.ac.nz by it.canterbury.ac.nz
 (PMDF V6.5-x6 #31943) id <01OENV6SD9M8AAZ1U4@it.canterbury.ac.nz> for
 linux-omap@vger.kernel.org; Mon,
 23 Apr 2012 15:18:37 +1200 (NEW ZEALAND STANDARD TIME)
In-reply-to: <79CD15C6BA57404B839C016229A409A83E9F8032@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Enrico <ebutera@users.sourceforge.net>
Cc: linux-omap@vger.kernel.org, "General mailing list for gumstix users." <gumstix-users@lists.sourceforge.net>

On 23/04/2012, at 2:11 AM, Hiremath, Vaibhav wrote:
> On Fri, Apr 20, 2012 at 15:56:46, Enrico wrote:
>> 
>> Yes it's possible but yuv support is still not in mainline kernel.
>> 
>> Have a look at the linux-media ml archive to know what is the current
>> status, problems etc...basically if you don't need bt656 support you
>> can try the omap3isp-omap3isp-yuv branch at [1].
>> 
> 
> During one of the internal releases, I have added YUV (BT656) support, it is 
> based on 2.6.37 based kernel, but still it will give you pointer and help
> you to change the code to get support for the same.
> 
> I have created separate, clean and independent patches for 
> adding support for BT656 YUV support.
> 
> 
> http://arago-project.org/git/projects/?p=linux-omap3.git;a=history;f=drivers/media/video/isp;hb=20c003f2f024d9f50f59edf9f1b8f5f035fb15b8
> 
> 
> Thanks,
> Vaibhav
> 
>> Enrico
>> 
>> [1]: http://git.linuxtv.org/pinchartl/media.git

Thanks Enrico and Vaibhav. 

My current setup uses an old version of the isp code for kernel 2.6.34 from a patch in the linux-omap3-caspapx OpenEmbedded recipe for Gumstix (not ideal, but I need gstreamer dsp support). I'm not sure which commit/branch/tree/patchset this is based on, but it turns out it does support YUV. 

Regards,
Simon.

