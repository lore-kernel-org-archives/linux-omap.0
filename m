From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [OMAPZOOM][PATCH 2/3] DSPBRIDGE: Flooding the mailbox causes
 	reliability issues (messages lost) and performance issues (busy looping
 	waiting for a slot in the mailbox)
Date: Mon, 23 Mar 2009 16:48:32 -0500
Message-ID: <496565EC904933469F292DDA3F1663E60287E2B16A@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E60287E2B12C@dlee06.ent.ti.com>
 <94a0d4530903231445u53870036rc581265fc724ea5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43272 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754694AbZCWVsl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 17:48:41 -0400
In-Reply-To: <94a0d4530903231445u53870036rc581265fc724ea5e@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "Aguilar Pena, Leed" <leed.aguilar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Ok let me try that.

-----Original Message-----
From: Felipe Contreras [mailto:felipe.contreras@gmail.com] 
Sent: Monday, March 23, 2009 3:46 PM
To: Guzman Lugo, Fernando
Cc: Pandita, Vikram; Aguilar Pena, Leed; linux-omap@vger.kernel.org
Subject: Re: [OMAPZOOM][PATCH 2/3] DSPBRIDGE: Flooding the mailbox causes reliability issues (messages lost) and performance issues (busy looping waiting for a slot in the mailbox)

On Mon, Mar 23, 2009 at 11:06 PM, Guzman Lugo, Fernando <x0095840@ti.com> wrote:
> From: Fernando Guzman Lugo <x0095840@ti.com>
> Date: Fri, 20 Mar 2009 20:46:51 -0500
> Subject: [PATCH] DSPBRIDGE: Flooding the mailbox causes reliability issues (messages lost) and performance issues (busy looping waiting for a slot in the mailbox)

Judging from this you are the author... perhaps it's a good idea to
use the --author option:
git commit --amend -s --author="Felipe Contreras <felipe.contreras@nokia.com>"

-- 
Felipe Contreras

