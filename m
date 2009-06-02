From: halli manjunatha <hallimanju@gmail.com>
Subject: Re: DSS2: How to test TV and LCD output simulatenously
Date: Tue, 2 Jun 2009 09:52:00 +0530
Message-ID: <ca6476860906012122q4f90c34ay2c98a76cd3921aa1@mail.gmail.com>
References: <5F744A5A3C131242B81CE5874BD2CFFB34E35EAC@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:53705 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbZFBEV7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2009 00:21:59 -0400
Received: by yw-out-2324.google.com with SMTP id 5so4553280ywb.1
        for <linux-omap@vger.kernel.org>; Mon, 01 Jun 2009 21:22:00 -0700 (PDT)
In-Reply-To: <5F744A5A3C131242B81CE5874BD2CFFB34E35EAC@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Venkatesh, Subbu" <subbu.wrs@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shah, Hardik" <hardik.shah@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>

Hi subbu,
first boot the board including      omapfb.vram="1:2M"    in boootargs
and follow the below steps it will enable both just try it it should work


***********************************************************************************
echo "0" > /sys/devices/platform/omapdss/overlay0/enabled
echo "0" > /sys/devices/platform/omapdss/overlay1/enabled

echo "" > /sys/class/graphics/fb1/overlays
echo "0,1" > /sys/class/graphics/fb0/overlays

echo "720,564" > /sys/devices/platform/omapdss/overlay1/output_size
echo "tv" > /sys/devices/platform/omapdss/overlay1/manager

echo "1" > /sys/devices/platform/omapdss/overlay0/enabled
echo "1" > /sys/devices/platform/omapdss/overlay1/enabled


echo "1" > /sys/devices/platform/omapdss/display2/enabled



**********************************************************************************


On Tue, Jun 2, 2009 at 7:54 AM, Venkatesh, Subbu <subbu.wrs@ti.com> wrote:
> Hi,
> I have DSS2 ported on LDP board, I could manage to get output display on TV and LCD interface individually, also tested some of the features like Rotation and Mirroring, they worked with out any problem.
> Now I am trying to get output both on TV and LCD simultaneously,
>
> I was not successful with my approach that I tried, like
>
> 1. Boot the kernel with the default LCD display
> 2. Then I enabled ntsc timings for TV, as PAL do not work on it.
>    #echo ntsc > /sys/devices/platform/omapdss/display1/timings
> 3. Enabled TV
>  # echo 1 > /sys/devices/platform/omapdss/display1/enable
> and did the common fb test....
> But it did not seem to work.
> Its nice if someone has different working approach or can suggest me where I am going wrong in the above steps.
>
> Regards,
> Subbu
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Regards
Manjunatha H
