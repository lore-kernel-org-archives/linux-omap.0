From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: YUV422 input to CPI?
Date: Mon, 23 Apr 2012 05:24:28 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9F85BE@DBDE01.ent.ti.com>
References: <E47FC7FC-B1CC-4E8A-9957-AEAF483DDAFA@pg.canterbury.ac.nz>
 <CA+2YH7vpCdXhJUQrsZ+3Tp=b5q=3su1K4TaEumWGeMeCZXpvyw@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83E9F8032@DBDE01.ent.ti.com>
 <511240CD-BADD-4E0F-8F4B-0107A420BF9E@pg.canterbury.ac.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43689 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753314Ab2DWFYp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 01:24:45 -0400
In-Reply-To: <511240CD-BADD-4E0F-8F4B-0107A420BF9E@pg.canterbury.ac.nz>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Simon Knopp <simon.knopp@pg.canterbury.ac.nz>, Enrico <ebutera@users.sourceforge.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "General mailing list for gumstix users." <gumstix-users@lists.sourceforge.net>

On Mon, Apr 23, 2012 at 08:48:35, Simon Knopp wrote:
> On 23/04/2012, at 2:11 AM, Hiremath, Vaibhav wrote:
> > On Fri, Apr 20, 2012 at 15:56:46, Enrico wrote:
> >> 
> >> Yes it's possible but yuv support is still not in mainline kernel.
> >> 
> >> Have a look at the linux-media ml archive to know what is the current
> >> status, problems etc...basically if you don't need bt656 support you
> >> can try the omap3isp-omap3isp-yuv branch at [1].
> >> 
> > 
> > During one of the internal releases, I have added YUV (BT656) support, it is 
> > based on 2.6.37 based kernel, but still it will give you pointer and help
> > you to change the code to get support for the same.
> > 
> > I have created separate, clean and independent patches for 
> > adding support for BT656 YUV support.
> > 
> > 
> > http://arago-project.org/git/projects/?p=linux-omap3.git;a=history;f=drivers/media/video/isp;hb=20c003f2f024d9f50f59edf9f1b8f5f035fb15b8
> > 
> > 
> > Thanks,
> > Vaibhav
> > 
> >> Enrico
> >> 
> >> [1]: http://git.linuxtv.org/pinchartl/media.git
> 
> Thanks Enrico and Vaibhav. 
> 
> My current setup uses an old version of the isp code for kernel 2.6.34 from a patch in the linux-omap3-caspapx OpenEmbedded recipe for Gumstix (not ideal, but I need gstreamer dsp support). I'm not sure which commit/branch/tree/patchset this is based on, but it turns out it does support YUV. 
> 

That's even closer then, it would be easier to back port from 2.6.37 to 
2.6.34. And as I said, refer to it as a reference or pointer to backport it, 
and patch commit description should help you to understand this.


Thanks,
Vaibhav

> Regards,
> Simon.
> 
> 

