From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 5/7] media: v4l2: introduce two IOCTLs for face detection
Date: Fri, 02 Dec 2011 13:33:36 +0100
Message-ID: <42689146.OPtqLboC2m@wuerfel>
References: <1322817178-8931-1-git-send-email-ming.lei@canonical.com> <1322817178-8931-6-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322817178-8931-6-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ming Lei <ming.lei@canonical.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <snjw23@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 02 December 2011 17:12:56 Ming Lei wrote:
> +/**
> + * struct v4l2_fd_result - VIDIOC_G_FD_RESULT argument
> + * @buf_index: entry, index of v4l2_buffer for face detection
> + * @face_cnt:  return, how many faces detected from the @buf_index
> + * @fd:                return, result of faces' detection
> + */
> +struct v4l2_fd_result {
> +       __u32   buf_index;
> +       __u32   face_cnt;
> +       __u32   reserved[6];
> +       struct v4l2_fd_detection *fd;
> +};


This data structure is not 32/64 bit safe: running a 64 bit kernel with 32 bit
user space will see an incompatible layout.

One way to solve this is to remove the pointer and just start the array
directly after the __u32 members. Alternatively, you can use a __u64
to pass the pointer in an integer representation.

A nicer interface from the data structure perspective would be to
get rid of the array altogether and always return exactly one face.

	Arnd
