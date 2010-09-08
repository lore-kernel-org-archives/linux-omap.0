From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Subject: Re: Patch to fix swapping of front and back porches when reading
 from modedb.c
Date: Wed, 08 Sep 2010 15:47:18 +0200
Message-ID: <4C8793E6.4070103@gmail.com>
References: <4C87920F.9050005@gmail.com> <AANLkTikkrkVMv0gwx6f8TRGEV8A8yCS1QRg1p7izfadF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61618 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab0IHNme (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 09:42:34 -0400
Received: by eyb6 with SMTP id 6so36652eyb.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Sep 2010 06:42:33 -0700 (PDT)
In-Reply-To: <AANLkTikkrkVMv0gwx6f8TRGEV8A8yCS1QRg1p7izfadF@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

  On 09/08/2010 03:38 PM, Russ Dill wrote:
> On Wed, Sep 8, 2010 at 6:39 AM, Tasslehoff Kjappfot<tasskjapp@gmail.com>  wrote:
>>
>> Hi list :-)
>>
>> I had trouble getting a standard 800x600@60Hz VGA signal to display
>> correctly on my monitors. Measuring the output showed that the front and
>> back porches were swapped both for hsync and vsync. After reading the source
>> I think I found the error in drivers/video/omap2/omapfb/omapfb-main.c. Patch
>> attached.
>>
>> http://www.xfree86.org/3.3.6/fbdev6.html shows the way it should be, but
>> todays code sets:
>>
>> hfp = left margin
>> hbp = right margin
>> vfp = upper margin
>> vbp = lower margin
>>
>> I tested a patched kernel with 800x600@60Hz on two different monitors and a
>> vga grabber, and it solved my issues.
> This looks good. Before this came up, I also thought that front porch
> meant left margin, and back porch meant margin, but margins are named
> in relation to pixel data, and porches are named in relation to sync
> pulses.
>
> You might want to add a Signed-off-by line
>
> Reviewed-by: Russ.Dill@gmail.com

Signed-off-by: tasskjapp@gmail.com

