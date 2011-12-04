From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [RFC PATCH v1 5/7] media: v4l2: introduce two IOCTLs for face detection
Date: Sun, 4 Dec 2011 19:18:37 +0800
Message-ID: <CACVXFVO5Bu8vTfLN_WFsEkHW6JhQFmWPmEyNnrvTsDhoF-WVeA@mail.gmail.com>
References: <1322817178-8931-1-git-send-email-ming.lei@canonical.com>
	<1322817178-8931-6-git-send-email-ming.lei@canonical.com>
	<42689146.OPtqLboC2m@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53978 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab1LDLSj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Dec 2011 06:18:39 -0500
In-Reply-To: <42689146.OPtqLboC2m@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <snjw23@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org

Hi,

On Fri, Dec 2, 2011 at 8:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 02 December 2011 17:12:56 Ming Lei wrote:
>> +/**
>> + * struct v4l2_fd_result - VIDIOC_G_FD_RESULT argument
>> + * @buf_index: entry, index of v4l2_buffer for face detection
>> + * @face_cnt: =A0return, how many faces detected from the @buf_inde=
x
>> + * @fd: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return, result of faces' det=
ection
>> + */
>> +struct v4l2_fd_result {
>> + =A0 =A0 =A0 __u32 =A0 buf_index;
>> + =A0 =A0 =A0 __u32 =A0 face_cnt;
>> + =A0 =A0 =A0 __u32 =A0 reserved[6];
>> + =A0 =A0 =A0 struct v4l2_fd_detection *fd;
>> +};
>
>
> This data structure is not 32/64 bit safe: running a 64 bit kernel wi=
th 32 bit
> user space will see an incompatible layout.

I agree that this is not 32/64 bit safe, but I understand lib32 can han=
dle
this correctly, otherwise many 32bit applications can't run on current
64bit kernel
since many kernel structures used by user space contained pointer,
such as struct v4l2_buffer, struct v4l2_ext_controls in v4l2 ABI.

> One way to solve this is to remove the pointer and just start the arr=
ay
> directly after the __u32 members. Alternatively, you can use a __u64
> to pass the pointer in an integer representation.

So I think this need not to be solved.

>
> A nicer interface from the data structure perspective would be to
> get rid of the array altogether and always return exactly one face.

I choose to return array to user space since v4l2 ioctl has provided
this kind of support, see video_usercopy().

thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
