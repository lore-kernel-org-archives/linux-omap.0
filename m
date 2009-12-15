From: Niamathullah sharief <omapsha@gmail.com>
Subject: Re: bootloader compilation
Date: Tue, 15 Dec 2009 11:20:52 +0530
Message-ID: <4ad3b6300912142150l42b4116dy20df36db1906aad9@mail.gmail.com>
References: <4ad3b6300912132302x31d08d06gfba97dbb885a2ba@mail.gmail.com>
	 <4B263E54.5050204@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:42232 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbZLOFux convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 00:50:53 -0500
Received: by pxi4 with SMTP id 4so2362232pxi.33
        for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 21:50:53 -0800 (PST)
In-Reply-To: <4B263E54.5050204@billgatliff.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-omap@vger.kernel.org

yes i saw all the steps in the website. i am getting some errors while
doing that steps. now i have to boot from mmc card. for that i
installed tollchain fpr ARM processor in my host computer. AFter
installing that toolchain i gave "make" to compile "xloader". But
found the following error

"root@ariem-desktop:/home/xloader# make
arm-none-linux-gnueabi-gcc -Wa,-gstabs -D__ASSEMBLY__ -g  -Os
-fno-strict-aliasing  -fno-common -ffixed-r8  -D__KERNEL__
-DTEXT_BASE=3D0x40200800 -I/home/xloader/include -fno-builtin
-ffreestanding -nostdinc -isystem
/usr/lib/gcc/i486-linux-gnu/4.3.3/include -pipe  -DCONFIG_ARM
-D__ARM__ -march=3Darmv7-a  -c -o cpu/omap3/start.o
/home/xloader/cpu/omap3/start.S
make: arm-none-linux-gnueabi-gcc: Command not found
make: *** [cpu/omap3/start.o] Error 127
root@ariem-desktop:/home/xloader# "

   i dont know what  is wrong.

On Mon, Dec 14, 2009 at 7:02 PM, Bill Gatliff <bgat@billgatliff.com> wr=
ote:
> Niamathullah sharief wrote:
>> Hello, =A0 =A0i am newbie. i am having beagle board with me. now i w=
ant to
>> compile bootloader. what is theprocedure to do that? where can i fin=
d
>> the right tutorial to compile bootloader. i didnt find the right
>> tutorial for newbie. please help me.
>>
>
> beagleboard.org.
>
>
> b.g.
>
> --
> Bill Gatliff
> bgat@billgatliff.com
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
