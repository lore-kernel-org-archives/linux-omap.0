From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] omapfb: panel-sony-acx565akm: constify attribute_group
 structures.
Date: Tue, 01 Aug 2017 16:04:12 +0200
Message-ID: <4895469.EV6kLxFEj8@amdc3058>
References: <CGME20170719052638epcas3p38153e17e63deab45c6d39fd1c56e3af2@epcas3p3.samsung.com>
        <0daabb462abd99a557da903c961de0eae1782998.1500441926.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <0daabb462abd99a557da903c961de0eae1782998.1500441926.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday, July 19, 2017 10:55:57 AM Arvind Yadav wrote:
> attribute_group are not supposed to change at runtime. All functions
> working with attribute_group provided by <linux/sysfs.h> work
> with const attribute_group. So mark the non-const structs as const.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    5227	    560	      0	   5787	   169b	panel-sony-acx565akm
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>    5291	    496	      0	   5787	   169b	panel-sony-acx565akm.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
