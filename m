From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 5/7] media: v4l2: introduce two IOCTLs for face detection
Date: Tue, 6 Dec 2011 12:55:55 +0000
Message-ID: <201112061255.56136.arnd@arndb.de>
References: <1322817178-8931-1-git-send-email-ming.lei@canonical.com> <201112051437.27538.arnd@arndb.de> <CACVXFVMB+HuQDb+Pxo0d8x46P82-c-OPxaL0c661Wztyx3NWJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61544 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab1LFM4M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Dec 2011 07:56:12 -0500
In-Reply-To: <CACVXFVMB+HuQDb+Pxo0d8x46P82-c-OPxaL0c661Wztyx3NWJA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: linux-arm-kernel@lists.infradead.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <snjw23@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org

On Tuesday 06 December 2011, Ming Lei wrote:
> diff --git a/include/linux/videodev2.h b/include/linux/videodev2.h
> index 073eb4d..8aeaa1e 100644
> --- a/include/linux/videodev2.h
> +++ b/include/linux/videodev2.h
> @@ -2214,7 +2214,12 @@ struct v4l2_fd_result {
>         __u32   buf_index;
>         __u32   face_cnt;
>         __u32   reserved[6];
> -       struct v4l2_fd_detection *fd;
> +
> +       /*make 64/32 compatible*/
> +       union {
> +               struct v4l2_fd_detection *fd;
> +               __u64   dummy;
> +       };
>  };
> 

That's not compatible, at least not on any big-endian architecture.
If you want to have an indirect pointer, you have to cast it to the
__u64 member in user space and back in kernel space.

Using an array added to the end of the v4l2_fd_result structure
rather than a pointer would really make this easier IMHO.

	Arnd
