From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: OMAP3 & DSP
Date: Tue, 27 Jan 2015 00:31:00 +0200
Message-ID: <54C6C024.90507@gmail.com>
References: <54C69BF6.4010105@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:64800 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757203AbbAZWij (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2015 17:38:39 -0500
Received: by mail-wi0-f174.google.com with SMTP id n3so1091607wiv.1
        for <linux-omap@vger.kernel.org>; Mon, 26 Jan 2015 14:38:38 -0800 (PST)
In-Reply-To: <54C69BF6.4010105@gmx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sven Brandau <brandau@gmx.de>, linux-omap@vger.kernel.org

Hi,

On 26.01.2015 21:56, Sven Brandau wrote:
> Hello,
>
> is there any driver support for the DSP on OMAP3 SOCs available in the
> current kernel?
>
> This means DSP image loading, starting and communication mechanisms
> between ARM CPU and DSP.
>
> The original TI driver only running on kernels with versions 2.6.x.
>
> Best regards,
> Sven
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

we still try to support out-of-the-tree tidspbridge, last version I 
tried and it was working was 3.16 (iirc), check it if it does the job 
for you:

https://gitorious.org/linux-n900/linux-n900/source/4af08adb31709cb3e057af10675f354553848653:drivers/staging/tidspbridge

It is tailored to be compatible with Maemo 5, but should work (in 
theory) with any distro as long as you have gst-dsp.

Regards,
Ivo
