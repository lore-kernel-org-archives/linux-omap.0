From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Text Display problem on MISTRAL'S QVGA LCD
Date: Sat, 26 Apr 2008 20:01:38 +0200
Message-ID: <48136E02.80306@googlemail.com>
References: <20080426164256.28383.qmail@f5mail-237-216.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.241]:34261 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757272AbYDZSBb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Apr 2008 14:01:31 -0400
Received: by hs-out-0708.google.com with SMTP id 4so2901099hsl.5
        for <linux-omap@vger.kernel.org>; Sat, 26 Apr 2008 11:01:27 -0700 (PDT)
In-Reply-To: <20080426164256.28383.qmail@f5mail-237-216.rediffmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balaji narayanam <narayanamb@rediffmail.com>
Cc: linux-omap@vger.kernel.org


You used the wrong (old) OMAP ML.

linux-omap-open-source@linux.omap.com

shouldn't be used any more. OMAP ML moved to

http://vger.kernel.org/vger-lists.html#linux-omap

Use

linux-omap@vger.kernel.org

instead. CCed now.

balaji narayanam wrote:
>   
> Dear all,
> 
> 
> I am working on MISTRAL'S QVGA LCD INTERFACED TO OSK5912.
> 
> I am using Linux-2.6.22 kernel version. I am able to play the .avi files using mplayer. But I am unable to dispaly the text data on the 
> QVGA LCD screen. When ever I sent any text data to the QVGA LCD, it is displaying only Junk data on the screen. I hope it might be due to the Font size Problem. I request  to help by giving an example, how to display the text data on the MISTRAL'S QVGA LCD.

An

echo "Hello world" > /dev/tty0

works just fine for me using the (font) settings in

linux-git/arch/arm/configs/omap_osk_5912_defconfig

Dirk



