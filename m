From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v7 00/18] OMAP2,3: hwmod DSS Adaptation
Date: Fri, 21 Jan 2011 17:26:17 +0530
Message-ID: <AANLkTimbbxdzmXPzB+oBS+CwNpSw0GyCJo5V1L9=4E_3@mail.gmail.com>
References: <1295196103-29417-1-git-send-email-sumit.semwal@ti.com> <87fwsmj164.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:51114 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754022Ab1AUL4k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jan 2011 06:56:40 -0500
Received: by bwz4 with SMTP id 4so1573567bwz.25
        for <linux-omap@vger.kernel.org>; Fri, 21 Jan 2011 03:56:37 -0800 (PST)
In-Reply-To: <87fwsmj164.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org

Hi Kevin,

On Fri, Jan 21, 2011 at 10:36 AM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Sumit,
>
> Sumit Semwal <sumit.semwal@ti.com> writes:
>
> [...]
>
>> Testing:
>> ---------
>> The patches are tested on 2420-n800, 2430sdp, 3630zoom, 3430sdp.
>> Complete bootup with penguins on panel is done on 3430sdp.
>> For the rest of the mentioned platforms, kernel is built with "OMAP2=
_DSS"
>> and bootup is tested so that base address and clk_get calls are succ=
essful.
>
> I think this series needs more validation on the other platforms.
> Getting a visible framebuffer w/tux on all tested platforms seems lik=
e a
> minimal requirement.
>
> I gave a test of this on 3530/Beagle with CONFIG_PANEL_GENERIC_DPI=3D=
y and
> driving a DVI monitor, using the following kernel cmdline
>
> # cat /proc/cmdline
> console=3DttyO2,115200n8 mpurate=3D600 vram=3D12M omapfb.mode=3Ddvi:1=
024x768MR-16@60 omapfb.debug=3Dy omapdss.def_disp=3Ddvi root=3D/dev/mmc=
blk0p2 rw rootfstype=3Dext3 rootwait
>
> Without your series, I see penguin logo and get a console login on th=
e
> screen with this boot log (from dmesg |grep -i omapfb):
>
> [ =A0 =A02.651885] OMAPFB: omapfb_init
> [ =A0 =A02.652160] OMAPFB: omapfb_probe
> [ =A0 =A02.657653] OMAPFB: create 3 framebuffers
> [ =A0 =A02.657714] OMAPFB: fb_infos allocated
> [ =A0 =A02.657714] OMAPFB: allocating 1572864 bytes for fb 0
> [ =A0 =A02.668212] OMAPFB: allocated VRAM paddr 8f400000, vaddr d0a00=
000
> [ =A0 =A02.668243] OMAPFB: region0 phys 8f400000 virt d0a00000 size=3D=
1572864
> [ =A0 =A02.668243] OMAPFB: region1 phys 00000000 virt =A0 (null) size=
=3D0
> [ =A0 =A02.668273] OMAPFB: region2 phys 00000000 virt =A0 (null) size=
=3D0
> [ =A0 =A02.668273] OMAPFB: fbmems allocated
> [ =A0 =A02.668518] OMAPFB: check_fb_var 0
> [ =A0 =A02.668548] OMAPFB: max frame size 1572864, line size 2048
> [ =A0 =A02.668548] OMAPFB: xres =3D 1024, yres =3D 768, vxres =3D 102=
4, vyres =3D 768
> [ =A0 =A02.668579] OMAPFB: set_fb_fix
> [ =A0 =A02.669036] OMAPFB: fb_infos initialized
> [ =A0 =A02.673522] OMAPFB: set_par(0)
> [ =A0 =A02.673614] OMAPFB: set_fb_fix
> [ =A0 =A02.673614] OMAPFB: apply_changes, fb 0, ovl 0
> [ =A0 =A02.673645] OMAPFB: setup_overlay 0, posx 0, posy 0, outw 1024=
, outh 768
> [ =A0 =A02.673645] OMAPFB: paddr 8f400000, vaddr d0a00000
> [ =A0 =A02.674346] OMAPFB: pan_display(0)
> [ =A0 =A02.674346] OMAPFB: setcmap
> [ =A0 =A02.674377] OMAPFB: setcmap
> [ =A0 =A02.683746] OMAPFB: pan_display(0)
> [ =A0 =A02.683776] OMAPFB: setcmap
> [ =A0 =A02.692108] OMAPFB: setcmap
> [ =A0 =A02.701599] OMAPFB: framebuffers registered
> [ =A0 =A02.701629] OMAPFB: apply_changes, fb 0, ovl 0
> [ =A0 =A02.701660] OMAPFB: setup_overlay 0, posx 0, posy 0, outw 1024=
, outh 768
> [ =A0 =A02.701690] OMAPFB: paddr 8f400000, vaddr d0a00000
> [ =A0 =A02.701721] OMAPFB: apply_changes, fb 1, ovl 1
> [ =A0 =A02.701751] OMAPFB: apply_changes, fb 2, ovl 2
> [ =A0 =A02.701751] OMAPFB: create_framebuffers done
> [ =A0 =A02.702331] OMAPFB: mgr->apply'ed
> [ =A0 =A02.704803] OMAPFB: create sysfs for fbs
> [ =A0 =A02.704833] OMAPFB: create sysfs for fbs
>
> With your series applied (no other changes), I don't see anything on =
the
> screen because omapfb_probe() fails:
>
> [ =A0 =A02.519653] OMAPFB: omapfb_init
> [ =A0 =A02.519958] OMAPFB: omapfb_probe
> [ =A0 =A02.520019] omapfb omapfb: no driver for display
> [ =A0 =A02.525115] OMAPFB: free_resources
> [ =A0 =A02.525146] OMAPFB: free all fbmem
> [ =A0 =A02.525177] omapfb omapfb: failed to setup omapfb
>
> which indicates that omap_dss_get_device() is failing in omapfb_probe=
().
Thanks for testing this out - yes, you're right. I was able to
reproduce this here, after getting hold of a beagle from someone, and
found out the reason.

The patch series misses some updates of device names [they were done
for 3430sdp, but left out for other platforms somehow in the version
of patches I got from the original authors.]

I am updating this now, and will send out an updated patchset in some
time. Unfortunately, the platforms available to me right now for
testing were rather limited, so I would truly appreciate testing on
other platforms not mentioned in the mail.

Best regards,
~Sumit.
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
