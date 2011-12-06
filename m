From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 5/7] media: v4l2: introduce two IOCTLs for face detection
Date: Tue, 06 Dec 2011 21:59:11 +0100
Message-ID: <2893768.IFJoMOGMWT@wuerfel>
References: <1322817178-8931-1-git-send-email-ming.lei@canonical.com> <CACVXFVO8Uk808J9HgVv6ernd4x_QwN3YsAaERF=W8F=NQrLwQw@mail.gmail.com> <CACVXFVOoQRZKDEWUtuq3hE3H25b7UUWWAJbsTGgVHJcUbnihig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACVXFVOoQRZKDEWUtuq3hE3H25b7UUWWAJbsTGgVHJcUbnihig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ming Lei <ming.lei@canonical.com>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Sylwester Nawrocki <snjw23@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 06 December 2011 23:45:27 Ming Lei wrote:
> >
> > and it is not difficult to implement it in a generic way so that new
> > array parameters can be supported as 64/32 compatible.
> 
> How about the below patch to support 64/32 compatible array parameter?

Looks technically correct to me, if you replace the 'return -ENOMEM' with
'ret = -ENOMEM;\n goto out;'.

The video_usercopy function already has multiple micro-optimizations
(on-stack buffers, cmd_input_size) that make it more complex than
I'd hope, but your addition seems ok to me.

Let's see what Mauro thinks.

	Arnd
