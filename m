From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: Bad page state in tidspbridge driver
Date: Mon, 9 Jan 2012 11:30:11 -0600
Message-ID: <CAB-zwWimymN-oBomkQD0QZJZhnHSByJRQQvAzDUR13AT-O_n2g@mail.gmail.com>
References: <201201081917.31376.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:45567 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932429Ab2AIRaM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Jan 2012 12:30:12 -0500
Received: by mail-wi0-f173.google.com with SMTP id hm2so3837534wib.18
        for <linux-omap@vger.kernel.org>; Mon, 09 Jan 2012 09:30:11 -0800 (PST)
In-Reply-To: <201201081917.31376.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>, Arne Caspari <arne@unicap-imaging.org>

Hi Laurent,

On Sun, Jan 8, 2012 at 12:17 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi,
>
> I'm hitting what seems to be a tidspbridge driver issue when using gs=
t-dsp
> with the DSP JPEG encoder.
>
> My application captures images from the OMAP3 ISP directly to frame b=
uffer
> memory for display. It then passes the frame buffer buffer pointer to=
 gst-dsp
> and the tidspbridge driver, which maps them to the DSP IOMMU address =
space.

=46rame buffer sounds like kernel memory not user's, this because
tidspbridge map functions do get_user_pages on the memory passed to
it, unless you set VM_IO (I believe, so tidspbridge just does a
get_page), however the issue might be related with the page count in
the end.

> When starting the JPEG encoder a bunch of identical messages are prin=
ted to
> the kernel log:
>
> [14643.065490] BUG: Bad page state in process source:src =A0pfn:89e39
> [14643.072143] page:c0b11720 count:0 mapcount:0 mapping: =A0(null) in=
dex:0x0
> [14643.079437] page flags: 0x410(dirty|reserved)
> [14643.084197] [<c003ee5c>] (unwind_backtrace+0x0/0xe0) from [<c00a4c=
34>]
> (bad_page+0xc4/0xec)
> [14643.093505] [<c00a4c34>] (bad_page+0xc4/0xec) from [<c00a5480>]
> (free_pages_prepare+0x70/0xe8)
> [14643.102935] [<c00a5480>] (free_pages_prepare+0x70/0xe8) from [<c00=
a5634>]
> (free_hot_cold_page+0x20/0x1ac)
> [14643.113525] [<c00a5634>] (free_hot_cold_page+0x20/0x1ac) from [<bf=
00d120>]
> (bridge_brd_mem_un_map+0x12c/0x3d4 [bridgedriver])
> [14643.126007] [<bf00d120>] (bridge_brd_mem_un_map+0x12c/0x3d4 [bridg=
edriver])
> from [<bf01cda8>] (proc_un_map+0x6c/0xa0 [bridgedriver])
> [14643.139404] [<bf01cda8>] (proc_un_map+0x6c/0xa0 [bridgedriver]) fr=
om
> [<bf014490>] (api_call_dev_ioctl+0xe8/0x10c [bridgedriver])
> [14643.152160] [<bf014490>] (api_call_dev_ioctl+0xe8/0x10c [bridgedri=
ver])
> from [<bf0208b8>] (bridge_ioctl+0x12c/0x15c [bridgedriver])
> [14643.165191] [<bf0208b8>] (bridge_ioctl+0x12c/0x15c [bridgedriver])=
 from
> [<c00d8fd8>] (do_vfs_ioctl+0x4e8/0x55c)
> [14643.176177] [<c00d8fd8>] (do_vfs_ioctl+0x4e8/0x55c) from [<c00d908=
0>]
> (sys_ioctl+0x34/0x54)
> [14643.185333] [<c00d9080>] (sys_ioctl+0x34/0x54) from [<c003a700>]
> (ret_fast_syscall+0x0/0x3c)
>
> The backtrace is printed because the page has the PG_reserved flag se=
t, which
> is expected (as far as I know) for the frame buffer memory.

Yes, PG_reserved is set, and given that tidspbridge is unmapping, it
is also telling the kernel that the pages are not going to be used
anymore, however in the beginning the memory was allocated by either
frame buffer or display driver.

I believe the issue is because the page count reaches to 0 but
PG_reserved is set as you point out.

> Is this use case unsupported ?

Not entirely supported, as long as the memory used by other drivers
increases the page count of each page there shouldn't be any issue,
since bridge doesn't know which pages have more than X number of
users.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
