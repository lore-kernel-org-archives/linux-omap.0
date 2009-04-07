From: Hugo Vincent <hugo.vincent@gmail.com>
Subject: Re: Preempt-RT on OMAP3?
Date: Tue, 7 Apr 2009 16:19:20 +1200
Message-ID: <5a7b8b7b0904062119w42209eedp8645d096acb8c4dd@mail.gmail.com>
References: <5a7b8b7b0904052025g74325484h66335606bebea5a3@mail.gmail.com>
	 <200904061927.09627.david-b@pacbell.net>
	 <5a7b8b7b0904061944h65f7b36cja70681d6a512693b@mail.gmail.com>
	 <200904062036.57982.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:42037 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbZDGETX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 00:19:23 -0400
Received: by yx-out-2324.google.com with SMTP id 31so2461284yxl.1
        for <linux-omap@vger.kernel.org>; Mon, 06 Apr 2009 21:19:20 -0700 (PDT)
In-Reply-To: <200904062036.57982.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Tue, Apr 7, 2009 at 3:36 PM, David Brownell <david-b@pacbell.net> wr=
ote:
> On Monday 06 April 2009, Hugo Vincent wrote:
>> Here is a complete boot log + config:
>> http://hugovincent.com/files/lkml-20090407/boot2.log
>
> Erm, not very complete actually. =A0Enable DEBUG_LL to see
> more early messages ... like the ones starting right
> after the kernel decompression messages.

How's this?
http://hugovincent.com/files/lkml-20090407/boot3.log

(In case it isn't clear, we get messages twice because console and
debug_LL are on the same serial port. I also had to increase
CONFIG_LOG_BUF_SHIFT to get a complete log in dmesg.)

> Also, re those udev-induced messages:
>
> Remounting root file system...
> uncorrectable error : <3>end_request: I/O error, dev mtdblock0, secto=
r 0
> Buffer I/O error on device mtdblock0, logical block 0
> uncorrectable error : <3>uncorrectable error : <3>end_request: I/O er=
ror, dev mtdblock0, sector 8
> Buffer I/O error on device mtdblock0, logical block 1
> end_request: I/O error, dev mtdblock0, sector 16
> Buffer I/O error on device mtdblock0, logical block 2
> uncorrectable error : <3>end_request: I/O error, dev mtdblock0, secto=
r 24
> Buffer I/O error on device mtdblock0, logical block 3
> uncorrectable error : <3>end_request: I/O error, dev mtdblock0, secto=
r 0
> Buffer I/O error on device mtdblock0, logical block 0
>
> You shouldn't need mtdblock unless you run JFSS2, so that's
> the quick way to get rid of them: =A0take that out of your
> kernel configuration. =A0Else, add "mtdblock*" to
> the "KERNEL=3D=3D... ; goto persistent_storage_end" check in
>
> =A0/etc/udev/rules.d/60-persistent-storage.rules
>
> I understand the next version of udev will fix that.

Thanks for that. Unfortunately I am using JFFS2 for now - perhaps I
should switch to UBIFS.

-- Hugo
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
