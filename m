From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Mon, 18 Aug 2008 22:50:58 +0530
Message-ID: <5d5443650808181020l19e9bce2g9ccb59979f626a93@mail.gmail.com>
References: <20080818.180829.145776296.Hiroshi.DOYU@nokia.com>
	 <EBA93F3E4CB46947A4C5275F6308CF3E03435165@dlee15.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f29.google.com ([209.85.217.29]:52660 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbYHRRU7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 13:20:59 -0400
Received: by gxk10 with SMTP id 10so5146510gxk.13
        for <linux-omap@vger.kernel.org>; Mon, 18 Aug 2008 10:20:58 -0700 (PDT)
In-Reply-To: <EBA93F3E4CB46947A4C5275F6308CF3E03435165@dlee15.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pasam, Vijay" <vpasam@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org, "Woodruff, Richard" <r-woodruff2@ti.com>, felipe.contreras@gmail.com, siarhei.siamashka@nokia.com, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, tony@atomide.com

Hi Vijay,

On Mon, Aug 18, 2008 at 10:42 PM, Pasam, Vijay <vpasam@ti.com> wrote:
> Hi Hiroshi,
>
>> Yes, "dspgateway" won't support OMAP3 but if I remember
>> correctly that TWL is already in OMAP2? and also does Camera
>> use the same mechanism of this MMU? This may be benefit or a
>> must, I guess..
>
> I agree. If we are certain that camera driver or some other driver uses
> MMU the same way bridge does and the MMU architecture is the same, it
> makes sense to make this generic code. My point is that if DSPGateway
> doesn't use TWL, it will not benefit from using the Bridge MMU code
> which has TWL enabled.
>

I think recently some one from TI posted OMAP3 camera driver at
linux-v4l2 mailing list and which I think was using camera MMU, but
not the common MMU framework it seems from the description. They
should first start converting to the common MMU infrastructure then.

http://lists-archives.org/video4linux/23215-omap3-camera-driver.html

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
