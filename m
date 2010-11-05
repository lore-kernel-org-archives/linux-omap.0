From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH v3 1/3] staging: tidspbridge: fix mgr_enum_node_info
Date: Fri, 05 Nov 2010 12:39:13 -0400
Message-ID: <4CD43331.7010705@gmail.com>
References: <1288974674-24330-1-git-send-email-ionut.nicu@mindbit.ro> <1288974674-24330-2-git-send-email-ionut.nicu@mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40574 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761Ab0KEQjR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 12:39:17 -0400
Received: by yxk8 with SMTP id 8so2302474yxk.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 09:39:16 -0700 (PDT)
In-Reply-To: <1288974674-24330-2-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@gmail.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

Ionut Nicu wrote, on 11/05/2010 12:31 PM:
> The current code was always returning a non-zero status value
> to userspace applications when this ioctl was called.
>
> The error code was ENODATA, which isn't actually an error,
> it's always returned by dcd_enumerate_object() when it hits the
> end of list.
>
> Signed-off-by: Felipe Contreras<felipe.contreras@gmail.com>

please try this as well:
a) git rebase -i master (to rebase from master if your branch is off that)
b) change this commit to edit
c) git commit --amend --author "Felipe Contreras 
<felipe.contreras@gmail.com>"
to change the authorship
d) git rebase --continue

OR
edit the patch Manually and change:
From: Ionut Nicu <ionut.nicu@gmail.com>
to
From: Felipe Contreras <felipe.contreras@gmail.com>

The From shows the authorship, that way, when you do a git send email, 
the proper acknowledgements are done :)

-- 
Regards,
Nishanth Menon
