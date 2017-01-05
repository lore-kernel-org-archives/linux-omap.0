From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Myir AM437x Rico board support (DTS) for Linux mainline 4.9 and
 4.4 Ti Processor SDK 03.02.00.05
Date: Thu, 5 Jan 2017 14:12:52 -0800
Message-ID: <20170105221252.GA2630@atomide.com>
References: <201701051754.03159.ppisa@pikron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201701051754.03159.ppisa-hnFyeMMZ0rvQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Pisa <ppisa-hnFyeMMZ0rvQT0dZR+AlfA@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, Dan Murphy <DMurphy-l0cyMroinI0@public.gmane.org>, support-0A6ZgDe55FJWk0Htik3J/w@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Pavel Pisa <ppisa-hnFyeMMZ0rvQT0dZR+AlfA@public.gmane.org> [170105 08:54]:
> Hello Tony and others,
> 
> I have found some personal time during holydays[*] and proceed
> furhers with RICO board support for perspective kernel versions.
> 
> I have prepared a device tree which provides quite complete
> board support for the most of peripherals found on MyIR
> AM437x Ricoboard. I have tested the kernel on the real board
> which I have bought for myself to do testing and can contribute
> previous work to to mainline.
> 
> LEDs, Ethernet, LEDs, SDcard, eMMC, onboard SPI NVM etc.
> works. Generally the AM437x mainline support is great except
> for SGX. It has been pleasant to work with it. I used TFTP boot
> and ramdisk overlay over NFS exported Debian Jessie RO chroot
> install.

OK nice. Please start sending the patches to linux-omap,
linux-arm-kernel and devicetree mailing lists so we can
start merging in the support :)

> Only significant missing piece is HDMI support. I have put
> setup which I prepared for Ti kernels to device-tree.
> But mainline supports SII9022 HDMI encoder only by
> 
>   drivers/gpu/drm/bridge/sii902x.c
> 
> but OMAP DSS changes "sil,sii9022" in device-tree
> to omapdss,sil,sii9022 which seems to be customized
> version found in Texas Instruments tree
> 
>   drivers/gpu/drm/omapdrm/displays/encoder-sii9022-video.c
> 
> Do you know if there are some plans to support combination
> of this driver or include customized version in mainline
> for OMAP?
> 
> I expect that non accelerated graphic with parallel
> LCD panel would work with 4.9 mainline kernel and
> the prepared device tree if #if 0 is changed to #if 1.
> 
> The 4.9 mainline support files can be found there
> 
>   http://pikron.com/files/linux/rico/linux-4.9/am437x-myir-ricoboard.dts
>   http://pikron.com/files/linux/rico/linux-4.9/am437x-myir-ricoboard.dtb
>   
> http://pikron.com/files/linux/rico/linux-4.9/config-4.9-mainline-myir-ricoboard

Seems OK for the dts on a quick glance. Tomi and Jyri would
know more about the HDMI support.

> I would be happy if they can help others, some feedback
> and cooperation would be great as well. I would be happy
> to contribute DTS to mainline if it is found acceptable.

Yeah let's do that first, then you can figure out the HDMI
part.

> I can prepare version without HDMI or complete DSS section
> if actual untested/able section is unacceptable.
> 
> Because of missing HDMI support and attempt to test SGX
> accelerated support, I have tried official Ti
> Processor SDK image for AM437x (am437x-evm-linux-03.02.00.05).
> I have prepared DTS and tested it with my overlay enabled
> kernel and Debian and Ti root filesystems as well as with
> original Ti kernel.
> 
> There are files for use with HDMI connected monitor
> 
>   files/linux/rico/linux-ti-4.4/am437x-myir-ricoboard-hdmi.dts
>   files/linux/rico/linux-ti-4.4/am437x-myir-ricoboard-hdmi.dtb
>   files/linux/rico/linux-ti-4.4/config-ti-4.4-myir-ricoboard
> 
> and another set for parallel LCD panel (untested)
> 
>   files/linux/rico/linux-ti-4.4/am437x-myir-ricoboard.dts
>   files/linux/rico/linux-ti-4.4/am437x-myir-ricoboard.dtb
> 
> I have managed to build SGX driver for my kernel configuration
> and from the testing of Ti image it seem to be used same way
> as for original Ti kernel build.
> 
> I have no luck with accelerated Xorg. But Ti release notes
> states that Xorg support is missing in 03.02.00.05.
> 
> There is question if it is permanent status or if there is some
> change.
> 
> Is there chance that Ti includes this prepared DTS in their
> kernel branch?
> 
> For sure mainline 4.9 support is even more interesting
> for me and future.

No idea about the above really, but the basic support seem
very much straight forward.

Regards,

Tony


> [*] Our company partner cares mainly (and may be pays something)
> for my work on maintenance of ancient MyIR Linux 3.12.10 kernel
> in their products. And MyIR company does not seem to really
> care about users and updates at all even if the enhancements
> are sent them for free. Typical experience but great thing about
> this board is that a schematic diagram is provided which makes
> possible to develop proper support.
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
