From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [OMAPZOOM][PATCH 2/3] DSPBRIDGE: Flooding the mailbox causes
	reliability issues (messages lost) and performance issues (busy looping
	waiting for a slot in the mailbox)
Date: Mon, 23 Mar 2009 23:45:35 +0200
Message-ID: <94a0d4530903231445u53870036rc581265fc724ea5e@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E60287E2B12C@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:17722 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbZCWVph (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 17:45:37 -0400
Received: by fg-out-1718.google.com with SMTP id e12so572169fga.17
        for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2009 14:45:35 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E60287E2B12C@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "Aguilar Pena, Leed" <leed.aguilar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Mar 23, 2009 at 11:06 PM, Guzman Lugo, Fernando <x0095840@ti.com> wrote:
> From: Fernando Guzman Lugo <x0095840@ti.com>
> Date: Fri, 20 Mar 2009 20:46:51 -0500
> Subject: [PATCH] DSPBRIDGE: Flooding the mailbox causes reliability issues (messages lost) and performance issues (busy looping waiting for a slot in the mailbox)

Judging from this you are the author... perhaps it's a good idea to
use the --author option:
git commit --amend -s --author="Felipe Contreras <felipe.contreras@nokia.com>"

-- 
Felipe Contreras
