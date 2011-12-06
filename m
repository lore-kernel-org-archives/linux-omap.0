From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [RFC PATCH v1 5/7] media: v4l2: introduce two IOCTLs for face detection
Date: Tue, 6 Dec 2011 21:11:08 +0800
Message-ID: <CACVXFVPYUY-vpeoKJKX2XN7-0w+=seW0u3EaP=hD9m1Sy7nkTQ@mail.gmail.com>
References: <1322817178-8931-1-git-send-email-ming.lei@canonical.com>
	<201112051437.27538.arnd@arndb.de>
	<CACVXFVMB+HuQDb+Pxo0d8x46P82-c-OPxaL0c661Wztyx3NWJA@mail.gmail.com>
	<201112061255.56136.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201112061255.56136.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <snjw23@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 6, 2011 at 8:55 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 06 December 2011, Ming Lei wrote:
>> diff --git a/include/linux/videodev2.h b/include/linux/videodev2.h
>> index 073eb4d..8aeaa1e 100644
>> --- a/include/linux/videodev2.h
>> +++ b/include/linux/videodev2.h
>> @@ -2214,7 +2214,12 @@ struct v4l2_fd_result {
>> =A0 =A0 =A0 =A0 __u32 =A0 buf_index;
>> =A0 =A0 =A0 =A0 __u32 =A0 face_cnt;
>> =A0 =A0 =A0 =A0 __u32 =A0 reserved[6];
>> - =A0 =A0 =A0 struct v4l2_fd_detection *fd;
>> +
>> + =A0 =A0 =A0 /*make 64/32 compatible*/
>> + =A0 =A0 =A0 union {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_fd_detection *fd;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __u64 =A0 dummy;
>> + =A0 =A0 =A0 };
>> =A0};
>>
>
> That's not compatible, at least not on any big-endian architecture.
> If you want to have an indirect pointer, you have to cast it to the
> __u64 member in user space and back in kernel space.

Looks like it is a bit ugly.

>
> Using an array added to the end of the v4l2_fd_result structure
> rather than a pointer would really make this easier IMHO.

I have tried to do this, but video_usercopy needs a few changes
to handle array args if no indirect pointer is passed to kernel.

I am not sure if media guys are happy to accept the changes, :-)

thanks,
--
Ming Lei
