From: "mohammed shareef" <mdshareef@gmail.com>
Subject: Re: omap5912-osk bad magic number
Date: Tue, 3 Jun 2008 14:03:34 +0530
Message-ID: <a1d91fa0806030133k13b92fe3k6c3eb9733a1b9129@mail.gmail.com>
References: <a1d91fa0806021043n2c0c74b6j9dcbf02d3cc05b06@mail.gmail.com>
	 <20080602184641.GA6028@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:23910 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbYFCIdi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2008 04:33:38 -0400
Received: by ti-out-0910.google.com with SMTP id b6so482281tic.23
        for <linux-omap@vger.kernel.org>; Tue, 03 Jun 2008 01:33:34 -0700 (PDT)
In-Reply-To: <20080602184641.GA6028@kedavra.cpe.vivax.com.br>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: omap <linux-omap@vger.kernel.org>

i am using uImage only..

here is what i do to make an image after compiling the kernel:

arm-linux-objcopy -O binary -R .note -R .comment -S
arch/arm/boot/compressed/vmlinux linux.bin

gzip -9 linux.bin

/tools/mkimage -A arm -O linux -T kernel -C gzip -a 0x10c08000 -e
0x10c08000 -n 'Linux Kernel Image' -d linux.bin.gz uImage.cc

regards,
Shareef

On Tue, Jun 3, 2008 at 12:16 AM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Mon, Jun 02, 2008 at 11:13:48PM +0530, mohammed shareef wrote:
>> Hi,
>>
>> i tried to re-compile my kernel by adding a few features and then
>> transfered the new image using u-boot. Unfortunately am getting the
>> following error:
>>
>> ## Booting image at 00100000 ...
>> Bad Magic Number
>> OMAP5912 OSK #
>>
>> The transfer seems to be complete and proper. all the environment
>> variables are also ok. i tried replacing the new image with the
>> previous working image. that also fails. could some one tell me whats
>> worng?
>
> use uImage instead of zImage
>
> --
> Best Regards,
>
> Felipe Balbi
> me@felipebalbi.com
> http://blog.felipebalbi.com
>
