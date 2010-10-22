From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] staging: tidspbridge: make the MGR_ENUMNODE_INFO ioctl work
Date: Fri, 22 Oct 2010 16:36:31 +0300
Message-ID: <AANLkTim_tRKFc84e33irZuuWmrZNApH_Y2kKXBrQ4NcJ@mail.gmail.com>
References: <1287752386-5974-1-git-send-email-ionut.nicu@mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41147 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab0JVNgd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 09:36:33 -0400
Received: by fxm16 with SMTP id 16so638887fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 06:36:32 -0700 (PDT)
In-Reply-To: <1287752386-5974-1-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

On Fri, Oct 22, 2010 at 3:59 PM, Ionut Nicu <ionut.nicu@gmail.com> wrote:
> The current code was always returning a non-zero status value
> to userspace applications when this ioctl was called.
>
> The error code was ENODATA, which isn't actually an error,
> it's always returned by dcd_enumerate_object() when it hits the
> end of list.
>
> Reorganized the code so that it works like "dynreg.out -ln" from
> the userspace-dspbridge package expects it to work.
>
> Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>

I also found this issue, but I have simpler fix. I think my fix should
be applied first, and then your reorganization.

>From 16759e41adc11ad1f34b757dcf19fe55c84bcfc2 Mon Sep 17 00:00:00 2001
From: Felipe Contreras <felipe.contreras@gmail.com>
Date: Sun, 19 Sep 2010 14:52:42 +0300
Subject: [PATCH] staging: tidspbridge: fix mgr_enum_node_info

It's always erroring out.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/staging/tidspbridge/rmgr/mgr.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/mgr.c
b/drivers/staging/tidspbridge/rmgr/mgr.c
index 57a39b9..4ba9517 100644
--- a/drivers/staging/tidspbridge/rmgr/mgr.c
+++ b/drivers/staging/tidspbridge/rmgr/mgr.c
@@ -148,6 +148,11 @@ int mgr_enum_node_info(u32 node_id, struct
dsp_ndbprops *pndb_props,

 		}
 	}
+
+	/* the last status is not 0, but neither an error */
+	if (status > 0)
+		status = 0;
+
 	if (!status) {
 		if (node_id > (node_index - 1)) {
 			status = -EINVAL;

-- 
Felipe Contreras
