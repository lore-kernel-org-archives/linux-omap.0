From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] drm/omap: add more new timings fields
Date: Mon, 10 Sep 2012 07:48:53 -0500
Message-ID: <CAF6AEGs3bJBWq0ORBFy5q8ec8No+zG-5GMmZo-ik6H6wMEFMfQ@mail.gmail.com>
References: <1347040786-29156-1-git-send-email-rob.clark@linaro.org>
	<1347256238.8127.4.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:65448 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757849Ab2IJMsy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 08:48:54 -0400
Received: by vbbff1 with SMTP id ff1so2498193vbb.19
        for <linux-omap@vger.kernel.org>; Mon, 10 Sep 2012 05:48:53 -0700 (PDT)
In-Reply-To: <1347256238.8127.4.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Andy Gross <andy.gross@ti.com>

On Mon, Sep 10, 2012 at 12:50 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Fri, 2012-09-07 at 12:59 -0500, Rob Clark wrote:
>> From: Rob Clark <rob@ti.com>
>>
>> Without these, DVI is broken.
>>
>> Signed-off-by: Rob Clark <rob@ti.com>
>> ---
>> Greg, it looks like the omapdss changes which added these fields, as
>> well as the interlaced field, where merged in Linux 3.5-rc5.  So I
>> think both this and the 'update for interlaced' patch are needed for
>> both 3.6 and 3.5.
>
> The omapdss timing and interlace changes were merged in 3.6 merge
> window, they were not merged in 3.5 merge window (and even less in
> 3.5-rc5)...

ok, git-log must be playing tricks on me... then these patches are
only needed for 3.6

BR,
-R

>  Tomi
>
