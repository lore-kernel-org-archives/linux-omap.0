From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/4] omap: mailbox: convert rwlocks to spinlock
Date: Mon, 10 May 2010 13:12:52 +0300
Message-ID: <x2p94a0d4531005100312ocd30641ds7648e9a497e3dfd9@mail.gmail.com>
References: <1273483013-5942-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:57229 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab0EJKMy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 06:12:54 -0400
Received: by ewy20 with SMTP id 20so843290ewy.1
        for <linux-omap@vger.kernel.org>; Mon, 10 May 2010 03:12:53 -0700 (PDT)
In-Reply-To: <1273483013-5942-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>, Kanigeri Hari <h-kanigeri2@ti.com>

On Mon, May 10, 2010 at 12:16 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> From: Ohad Ben-Cohen <ohad@wizery.com>
>
> rwlocks are slower and have potential starvation issues
> therefore spinlocks are generally preferred.
>
> see also: http://lwn.net/Articles/364583/
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Signed-off-by: Kanigeri Hari <h-kanigeri2@ti.com>
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

There's no cover letter, so I'll comment here.

What about these patches?
http://article.gmane.org/gmane.linux.ports.arm.omap/31208

They are needed for dspbridge... AFAIK the only real user for omap mailbox.

-- 
Felipe Contreras
