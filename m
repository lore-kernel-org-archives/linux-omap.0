From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM: dts: dra72-evm: Add i2c1 and tps65917 nodes
Date: Mon, 28 Jul 2014 12:00:57 +0530
Message-ID: <53D5EE21.1040000@ti.com>
References: <1406528334-4415-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406528334-4415-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-patch-review-uAqBSO/uNfhBDgjK7y7TUQ@public.gmane.org
Cc: nm-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Monday 28 July 2014 11:48 AM, Keerthy wrote:
> The patch series adds i2c1 and tps65917 and related nodes.
> The patch series is boot tested on DRA72-EVM.
> 
> Thanks to Lokesh <lokeshvutla-l0cyMroinI0@public.gmane.org> for testing the series.
For booting, this is dependent on recent hwmod fix patch series posted by me:
http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg108001.html

Boot log for this series can be found here:
http://paste.ubuntu.com/7881545/

Thanks and regards,
Lokesh
> 
> Keerthy J (2):
>   ARM: dts: dra72-evm: Enable I2C1 node
>   ARM: dts: dra72-evm: Add tps65917 PMIC node
> 
>  arch/arm/boot/dts/dra72-evm.dts |  120 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
