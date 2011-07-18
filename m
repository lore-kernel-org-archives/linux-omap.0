From: Nick Pelly <npelly@google.com>
Subject: Re: [PATCH] omap-serial: Allow IXON and IXOFF to be disabled.
Date: Mon, 18 Jul 2011 16:09:42 -0700
Message-ID: <CAESwx=jhutBN9ESiuQkhD9xYR95zUxBZjA_YTyubSniguGmrjg@mail.gmail.com>
References: <1310669360-752-1-git-send-email-npelly@google.com> <CAAL8m4zQkOqdy0J4wKTR-OQWZDFsfBkDgJmhwhr9DPGmDQ+kBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:15837 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850Ab1GRXKQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jul 2011 19:10:16 -0400
Received: from hpaq14.eem.corp.google.com (hpaq14.eem.corp.google.com [172.25.149.14])
	by smtp-out.google.com with ESMTP id p6INAEjD001835
	for <linux-omap@vger.kernel.org>; Mon, 18 Jul 2011 16:10:15 -0700
Received: from yxk38 (yxk38.prod.google.com [10.190.3.166])
	by hpaq14.eem.corp.google.com with ESMTP id p6IN9nuQ019358
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 18 Jul 2011 16:10:13 -0700
Received: by yxk38 with SMTP id 38so1831251yxk.2
        for <linux-omap@vger.kernel.org>; Mon, 18 Jul 2011 16:10:13 -0700 (PDT)
In-Reply-To: <CAAL8m4zQkOqdy0J4wKTR-OQWZDFsfBkDgJmhwhr9DPGmDQ+kBA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: linux-omap@vger.kernel.org

On Thu, Jul 14, 2011 at 10:37 PM, Govindraj <govindraj.ti@gmail.com> wrote:
>
> On Fri, Jul 15, 2011 at 12:19 AM, Nick Pelly <npelly@google.com> wrote:
> > Fixes logic bug that software flow control cannot be disabled, because
> > serial_omap_configure_xonxoff() is not called if both IXON and IXOFF bits
> > are cleared.
> >
>
> Thanks, Good Point.
>
> need to send to this patch to linux-serial@vger.kernel.org,
> CC'ing "Greg Kroah-Hartman <gregkh@suse.de>"
>
> will be merged through tty tree.
>
> feel free to add
>
> Acked-by: Govindraj.R <govindraj.raja@ti.com>
> Tested-by: Govindraj.R <govindraj.raja@ti.com>

Done.
