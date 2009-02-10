From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP I2C: Include OMAP_I2C_SYSC_REG in save and restore.
Date: Tue, 10 Feb 2009 14:25:25 -0800
Message-ID: <87eiy62alm.fsf@deeprootsystems.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CE87C@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02A3FFF0D2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:18151 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755929AbZBJWZc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 17:25:32 -0500
Received: by qw-out-2122.google.com with SMTP id 5so80609qwi.37
        for <linux-omap@vger.kernel.org>; Tue, 10 Feb 2009 14:25:30 -0800 (PST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A3FFF0D2@dbde02.ent.ti.com> (Jagadeesh Pakaravoor's message of "Tue\, 10 Feb 2009 15\:57\:32 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "jouni.hogander@nokia.com" <jouni.hogander@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com> writes:

> Kevin,
>   Did you get a chance to review this patch?
>

Yes, and I applied it to the PM branch early last week.  See the
commit log[1].

I guess I forgot to respond to the list.  Sorry...
 
Kevin

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=shortlog;h=pm

