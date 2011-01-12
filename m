From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: Issues with ADATA SD cards on OMAP? -- dto calculation??
Date: Tue, 11 Jan 2011 21:58:17 -0800
Message-ID: <AANLkTikh_cQnsy--NCOFMtR_zq2U8W0Vs6cABx7qnsGF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62816 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074Ab1ALF6T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jan 2011 00:58:19 -0500
Received: by qyk12 with SMTP id 12so279631qyk.19
        for <linux-omap@vger.kernel.org>; Tue, 11 Jan 2011 21:58:17 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Kipisz, Steven" <s-kipisz2@ti.com>

On Sat, Jan 8, 2011 at 10:04 PM, Steve Sakoman <sakoman@gmail.com> wrot=
e:
> I've recently been testing memory card performance to identify the
> best performing brands/models.
>
> As expected, I found a huge difference in performance between brands.
> What I didn't expect to find, however, was a brand (ADATA) that
> doesn't seem to play well with the 2.6.36 kernel on OMAP3 hardware.
> I'm wondering if this failure might be exposing an issue in the OMAP
> mmc driver/hw setup.
>
> I tested both 4GB and 8GB versions of the ADATA Class 6 cards. =A0I w=
as
> not able to boot successfully from either card on both Overo and
> Beagle hardware (both 35xx and 37xx versions were tested).
>
> The error was the same in all cases: x-load, u-boot, and the kernel
> were all loaded successfully from SD, but the kernel was not able to
> mount the rootfs:

On the suggestion of Steve Kipisz of TI I tried increasing the value
of dto in the set_data_timeout function of
drivers/mmc/host/omap_hsmmc.c

Hard coding dto to the max value of 14 appears to fix the timeout
errors with ADATA brand cards.

Does anyone understand the rationale behind the current dti
computation?  For reference, here is the code:

	if (timeout) {
		while ((timeout & 0x80000000) =3D=3D 0) {
			dto +=3D 1;
			timeout <<=3D 1;
		}
		dto =3D 31 - dto;
		timeout <<=3D 1;
		if (timeout && dto)
			dto +=3D 1;
		if (dto >=3D 13)
			dto -=3D 13;
		else
			dto =3D 0;
		if (dto > 14)
			dto =3D 14;
	}

I am far from certain that just increasing dto (let alone by what
amount!) is the proper fix, since the timeout may be just a symptom of
a more fundamental timing/voltage issue.

I have a few more cards to test that failed 100% of the time with the
standard code, but I suspect that they are likely to work now too.

Any thoughts?

Steve


> Waiting for root device /dev/mmcblk0p2...
> mmc0: host does not support reading read-only switch. assuming write-=
enable.
> mmc0: new high speed SDHC card at address 0260
> mmcblk0: mmc0:0260 SD =A0 =A03.75 GiB
> =A0mmcblk0: p1 p2
> EXT3-fs: barriers not enabled
> kjournald starting. =A0Commit interval 5 seconds
> EXT3-fs (mmcblk0p2): using internal journal
> EXT3-fs (mmcblk0p2): mounted filesystem with writeback data mode
> VFS: Mounted root (ext3 filesystem) on device 179:2.
> devtmpfs: mounted
> Freeing init memory: 168K
> INIT: version 2.86 booting
> Please wait: booting...
> Starting udev
> Remounting root file system...
> mmcblk0: error -110 sending read/write command, response 0x900, card
> status 0xe00
> mmcblk0: error -110 transferring data, sector 3556505, nr 8, card sta=
tus 0xc00
> end_request: I/O error, dev mmcblk0, sector 3556512
> Buffer I/O error on device mmcblk0p2, logical block 426490
> lost page write due to I/O error on mmcblk0p2
> mmcblk0: error -110 sending read/write command, response 0x900, card
> status 0xe00
> mmcblk0: error -110 transferring data, sector 4076825, nr 8, card sta=
tus 0xc00
> end_request: I/O error, dev mmcblk0, sector 4076832
> Buffer I/O error on device mmcblk0p2, logical block 491530
> lost page write due to I/O error on mmcblk0p2
> mmcblk0: error -110 sending read/write command, response 0x900, card
> status 0xe00
> mmcblk0: error -110 transferring data, sector 4126233, nr 8, card sta=
tus 0xc00
> end_request: I/O error, dev mmcblk0, sector 4126234
> Buffer I/O error on device mmcblk0p2, logical block 497706
> lost page write due to I/O error on mmcblk0p2
>
> And so on, with many more mmc errors.
>
> If I reset and try again, things go wrong even sooner:
>
> Waiting for root device /dev/mmcblk0p2...
> mmc0: host does not support reading read-only switch. assuming write-=
enable.
> mmc0: new high speed SDHC card at address 0260
> mmcblk0: mmc0:0260 SD =A0 =A03.75 GiB
> =A0mmcblk0: p1 p2
> EXT3-fs: barriers not enabled
> mmcblk0: error -110 sending read/write command, response 0x900, card
> status 0xe00
> mmcblk0: error -110 transferring data, sector 147545, nr 8, card stat=
us 0xc00
> end_request: I/O error, dev mmcblk0, sector 147552
> Buffer I/O error on device mmcblk0p2, logical block 370
> lost page write due to I/O error on mmcblk0p2
>
> The ADATA cards seem to work with no issues on my desktop system.
>
> Has anyone else run into this issue? =A0Any theories on where to star=
t looking?
>
> FWIW, there is this thread on the beagleboard list discussing issues
> with mmc writes:
>
> http://groups.google.com/group/beagleboard/browse_thread/thread/00837=
24ff7e54c58/f55578bb1c1379db#f55578bb1c1379db
>
> In this thread Gerald Coley speculates that the driver may be setting
> the mmc1 voltage to 3.0V rather than 3.15V.
>
> Regards,
>
> Steve
>
> PS: For those who might be interested in the microSD card performance=
 tests:
>
> http://www.sakoman.com/OMAP/microsd-card-perfomance-test-results.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
