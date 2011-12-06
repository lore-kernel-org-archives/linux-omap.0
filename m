From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 5/7] media: v4l2: introduce two IOCTLs for face detection
Date: Tue, 6 Dec 2011 14:41:25 +0000
Message-ID: <201112061441.25822.arnd@arndb.de>
References: <1322817178-8931-1-git-send-email-ming.lei@canonical.com> <201112061255.56136.arnd@arndb.de> <CACVXFVPYUY-vpeoKJKX2XN7-0w+=seW0u3EaP=hD9m1Sy7nkTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACVXFVPYUY-vpeoKJKX2XN7-0w+=seW0u3EaP=hD9m1Sy7nkTQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: linux-arm-kernel@lists.infradead.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <snjw23@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 06 December 2011, Ming Lei wrote:
> > Using an array added to the end of the v4l2_fd_result structure
> > rather than a pointer would really make this easier IMHO.
> 
> I have tried to do this, but video_usercopy needs a few changes
> to handle array args if no indirect pointer is passed to kernel.

Ah, I see. Or you would have to encode the array size into the
ioctl command, which is also ugly in a different way.

> I am not sure if media guys are happy to accept the changes, :-)

Maybe Mauro can comment on which solution he prefers then, given
the choice between:

1. adding another handler in drivers/media/video/v4l2-compat-ioctl32.c

2. passing a pointer that is casted to __u64 in user space an back
   in the kernel

3. extending video_usercopy in some way to make this work, preferably
   in a generic way.

4. using a variable command number like
   #define VIDIOC_G_FD_RESULT(num)	_IOC(_IOC_READ|_IOC_WRITE,'V', 95, \
		sizeof(struct v4l2_fd_result) + (num) * sizeof(struct v4l2_fd_detection)

5. requiring the interface to be simplified to return only a single
   struct v4l2_fd_detection at a time

I agree that none of these are nice. My preferred option would be last one,
but I don't know how performance critical the interface is or if it would
cause any races that you want to avoid.

	Arnd
