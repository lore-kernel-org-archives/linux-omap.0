From: Stephan Raue <mailinglists@openelec.tv>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Thu, 10 Mar 2011 15:45:09 +0100
Message-ID: <4D78E3F5.2090600@openelec.tv>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com> <1299764643.2017.177.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail04.solnet.ch ([212.101.4.138]:50314 "EHLO mail04.solnet.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324Ab1CJOy0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 09:54:26 -0500
In-Reply-To: <1299764643.2017.177.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "K, Mythri P" <mythripk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

if i try this patch series the boot stops after (seeing via serial console):

   Starting kernel ...

   Uncompressing Linux... done, booting the kernel.

without this patch series i can see the boot to th OS. I am using this 
patches on top of

   http://gitorious.org/linux-omap-dss2/linux/commits/master

Do i anything wrong or do i use a wrong git repo (the patches apply 
cleanly)? Her my kernel config: http://fpaste.org/9Esw/

Stephan

Am 10.03.2011 14:44, schrieb Tomi Valkeinen:
> On Thu, 2011-03-10 at 04:44 -0600, K, Mythri P wrote:
>> Adding HDMI support on OMAP4.
>>
>> HDMI is a driver that is similar to the VENC or the DSI driver to support
>> HDMI/DVI sink device.
>>
>> The current design adheres to the DSS2 architecture.
>>
>> It is split into the HDMI DSS driver and HDMI panel driver.
> I think this version is good. It works for me, at least =).
>
> Any Panda or Blaze owners reading this want to give this a try?
>
> There are a couple of cosmetic fixes you could still do, I'll email
> about those separately. But they are just about comments/descriptions,
> you can fix them and email me a tarball for the patches, no need to spam
> the mailing list.
>
>   Tomi
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

