From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [REVIEW PATCH 2/2] OMAP3EVM Multi-Media Daughter Card Support
Date: Thu, 29 Jan 2009 20:32:48 +0100
Message-ID: <200901292032.48972.hverkuil@xs4all.nl>
References: <hvaibhav@ti.com> <1233256950-26704-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1233256950-26704-2-git-send-email-hvaibhav@ti.com>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, linux-media@vger.kernel.org, Brijesh Jadav <brijesh.j@ti.com>, Hardik Shah <hardik.shah@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 29 January 2009 20:22:30 hvaibhav@ti.com wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
>
> This is second version of OMAP3EVM Mulit-Media/Mass Market
> Daughter Card support.
>
> Fixes:
>     - Cleaned unused header files, struct formating, and unused
>       comments.
>     - Pad/mux configuration handled in mux.ch
>     - mux.ch related changes moved to seperate patch
>     - Renamed file board-omap3evm-dc.c to board-omap3evm-dc-v4l.c
>       to make more explicit.
>     - Added some more meaningful name for Kconfig option
>
> TODO:
>     - Camera sensor support (for future development).
>     - Driver header file inclusion (dependency on ISP-Camera patches)
>       I am working with Sergio to seperate/move header file to standard
>       location.
>     - Still need to fix naming convention for DC
>
> Tested:
>     - TVP5146 (BT656) decoder interface on top of
>       Sergio's ISP-Camera patches.
>     - Loopback application, capturing image through TVP5146
>       and saving it to file per frame.

What is the status of converting tvp5146 to v4l2_subdev? The longer it takes 
to convert it, the harder it will be now that you are starting to use this 
driver. v4l2_int_device should be phased out, preferably by 2.6.30.

I'm more than happy to assist in this conversion, but please try to do this 
asap!

Thanks,

	Hans

-- 
Hans Verkuil - video4linux developer - sponsored by TANDBERG
