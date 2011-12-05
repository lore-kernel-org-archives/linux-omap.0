From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 5/7] media: v4l2: introduce two IOCTLs for face detection
Date: Mon, 5 Dec 2011 14:37:27 +0000
Message-ID: <201112051437.27538.arnd@arndb.de>
References: <1322817178-8931-1-git-send-email-ming.lei@canonical.com> <42689146.OPtqLboC2m@wuerfel> <CACVXFVO5Bu8vTfLN_WFsEkHW6JhQFmWPmEyNnrvTsDhoF-WVeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:65159 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215Ab1LEOhe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Dec 2011 09:37:34 -0500
In-Reply-To: <CACVXFVO5Bu8vTfLN_WFsEkHW6JhQFmWPmEyNnrvTsDhoF-WVeA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: linux-arm-kernel@lists.infradead.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <snjw23@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org

On Sunday 04 December 2011, Ming Lei wrote:
> >
> > This data structure is not 32/64 bit safe: running a 64 bit kernel with 32 bit
> > user space will see an incompatible layout.
> 
> I agree that this is not 32/64 bit safe, but I understand lib32 can handle
> this correctly, otherwise many 32bit applications can't run on current
> 64bit kernel
> since many kernel structures used by user space contained pointer,
> such as struct v4l2_buffer, struct v4l2_ext_controls in v4l2 ABI.

The other ones you mentioned are handled in the kernel in
drivers/media/video/v4l2-compat-ioctl32.c. For new ioctl commands,
it's better to define the data structure in a compatible way
so you do not need a wrapper like that.

	Arnd
