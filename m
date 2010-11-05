From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/3] staging: tidspbridge: fix mgr_enum_node_info
Date: Fri, 5 Nov 2010 18:01:47 +0200
Message-ID: <AANLkTimgHvTz9sSG+opnnkeGQ2LH7hVV5x-iJOMvffgE@mail.gmail.com>
References: <1288970148-22191-1-git-send-email-ionut.nicu@mindbit.ro>
	<1288970148-22191-2-git-send-email-ionut.nicu@mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61949 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551Ab0KEQBt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 12:01:49 -0400
Received: by bwz11 with SMTP id 11so2800573bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 09:01:47 -0700 (PDT)
In-Reply-To: <1288970148-22191-2-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

On Fri, Nov 5, 2010 at 5:15 PM, Ionut Nicu <ionut.nicu@gmail.com> wrote:
> The current code was always returning a non-zero status value
> to userspace applications when this ioctl was called.
>
> The error code was ENODATA, which isn't actually an error,
> it's always returned by dcd_enumerate_object() when it hits the
> end of list.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>

You should leave the original author (me).

-- 
Felipe Contreras
