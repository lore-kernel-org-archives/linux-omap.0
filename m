From: Bharathi Subramanian <bharathi.list@gmail.com>
Subject: DevKit8K: DSS TV-Out Issue
Date: Fri, 16 Apr 2010 17:28:26 +0530
Message-ID: <s2i2b3771721004160458s403439bbsfa083c9d232cca0a@mail.gmail.com>
References: <g2o2b3771721004160447qb9e9bab4jcd77d1ac65e3f69b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35116 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758167Ab0DPL61 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 07:58:27 -0400
Received: by pva18 with SMTP id 18so1565968pva.19
        for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 04:58:26 -0700 (PDT)
In-Reply-To: <g2o2b3771721004160447qb9e9bab4jcd77d1ac65e3f69b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

I am trying to load the kernel (Linux
2.6.34-rc3-07875-geba0147-dirty) in the DevKit8K board. My default
output device is TV. Initially, none of the DSS devices got detected.
After merging the "Koen Kooi" patch, DSS devices are getting
detected and still getting below error:

[   97.250915] OMAPFB: omapfb_init
[ =A0 97.251007] OMAPFB: omapfb_probe
[ =A0 97.251037] OMAP_DSS_GET_NEXT_DEV
[ =A0 97.254486] DSS DEV 0
[ =A0 97.256774] OMAP_DSS_GET_NEXT_DEV
[ =A0 97.260101] DSS DEV 1
[ =A0 97.262420] OMAP_DSS_GET_NEXT_DEV
[ =A0 97.265777] TV:NTSC
[ =A0 97.267883] omapdss VENC: venc_check_timings
[ =A0 97.267883] omapdss VENC: venc_set_timings
[ =A0 97.267913] OMAPFB: create 2 framebuffers
[ =A0 97.267944] OMAPFB: fb_infos allocated
[ =A0 97.267974] Overlay 0
[ =A0 97.272674] OMAPFB: allocating 1388544 bytes for fb 0
[ =A0 97.283447] OMAPFB: allocated VRAM paddr 805b5000, vaddr c8a00000
[ =A0 97.283447] Overlay 0
[ =A0 97.288146] OMAPFB: allocating 4194304 bytes for fb 1
[ =A0 97.320404] OMAPFB: allocated VRAM paddr 80708000, vaddr c9000000
[ =A0 97.320434] OMAPFB: region0 phys 805b5000 virt c8a00000 size=3D138=
8544
[ =A0 97.320465] OMAPFB: region1 phys 80708000 virt c9000000 size=3D419=
4304
[ =A0 97.320465] OMAPFB: fbmems allocated
[ =A0 97.320495] Overlay 0
[ =A0 97.325714] RESL H 482 W 720 Mode 0
[ =A0 97.333984] omapfb omapfb: illegal display bpp 0
[ =A0 97.338653] omapfb omapfb: failed to setup fb_info
[ =A0 97.343475] OMAPFB: free_resources
[ =A0 97.343505] OMAPFB: free all fbmem
[ =A0 97.343536] omapfb omapfb: failed to setup omapfb
[ =A0 97.348297] omapfb: probe of omapfb failed with error -22
[ =A0 97.354309] regulator_init_complete: incomplete constraints, leavi=
ng VDVI on
[ =A0 97.361511] regulator_init_complete: incomplete constraints, leavi=
ng VDAC on
[ =A0 97.369323] twl_rtc twl_rtc: setting system clock to 2000-01-01

Here is my understanding:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
omapfp-main.c: omapfb_get_recommended_bpp(fbdev, display))
=A0\--> fbdev->bpp_overrides[i].bpp --> bpp value is 0

This fbdev->bpp_overrides[i].bpp value is initialised by
omapfp-main.c: omapfb_set_def_mode()

=A0\--> omapfb_mode_to_timings(mode_str, &timings, &bpp)

fbdev->bpp_overrides[fbdev->num_bpp_overrides].bpp =3D bpp; (Value is 0=
)

If the FOR loop in omapfp_get_recommended_bpp() is commented out, then
it gets the bpp value from the below function,

=A0dss/display.c: omapdss_default_get_recommended_bpp() --> Return bpp =
24

But after this modification, kernel panic is happening.
http://bharathi.pastebin.com/G7ZdmjQt

Any clue to overcome this TV-Out issue?

--
Thanks
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
