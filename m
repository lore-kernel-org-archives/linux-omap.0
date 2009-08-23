From: Tar Gz <bsdraisefromhell@gmail.com>
Subject: Re: Can't mount proc filesystem
Date: Sun, 23 Aug 2009 11:37:37 -0700
Message-ID: <d9ca78710908231137uf28715bm9fb41cf4a6266fce@mail.gmail.com>
References: <d9ca78710908231126n5082c0e6tc86acd9448f5e2c9@mail.gmail.com>
	 <4A918B79.5030607@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f183.google.com ([209.85.211.183]:58279 "EHLO
	mail-yw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933613AbZHWShg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Aug 2009 14:37:36 -0400
Received: by ywh13 with SMTP id 13so2156356ywh.15
        for <linux-omap@vger.kernel.org>; Sun, 23 Aug 2009 11:37:37 -0700 (PDT)
In-Reply-To: <4A918B79.5030607@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

because my kernel booting and enter the busybox manually

how to enter to shell like bash?

On 8/23/09, Gary Thomas <gary@mlbassoc.com> wrote:
> Tar Gz wrote:
>> hi all
>>
>> i try to develop linux 2.6.26 kernel with omap patch but when i'm
>> booting, i'm enter busybox and running /etc/init.d/rcS
>>
>> but failed to mount proc filesystem...i have enabled kernel /rpoc
>> filesystems support but it's still can't mounting..any idea?
>
> You should not be running /etc/init.d/rcS manually.  The log
> you sent previously shows it has already run.
>
> What makes you think that /proc wasn't mounted?
> Why are you running /etc/init.d/rcS by hand?
>
> --
> ------------------------------------------------------------
> Gary Thomas                 |  Consulting for the
> MLB Associates              |    Embedded world
> ------------------------------------------------------------
>
