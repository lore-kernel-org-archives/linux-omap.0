From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] staging: tidspbridge - configure full L1 MMU range
Date: Wed, 5 Jan 2011 12:05:31 +0200
Message-ID: <AANLkTimYymY2vqCg3J_0KNiwSpF3FQL32FP=CE27BTvG@mail.gmail.com>
References: <1294208410-4772-1-git-send-email-fernando.lugo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1294208410-4772-1-git-send-email-fernando.lugo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fernando Guzman Lugo <fernando.lugo@ti.com>
Cc: omar.ramirez@ti.com, gregkh@suse.de, rene.sapiens@ti.com, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 5, 2011 at 8:20 AM, Fernando Guzman Lugo
<fernando.lugo@ti.com> wrote:
> Otherwise a virtual address beyond of the L1 size is used,
> the MMU hardware will look into a memory that does not belong to
> L1 translation tables. IOW; the MMU would allow to access any
> memory, configured or not.
>
> Reported-by: Felipe Contreras <felipe.contreras@nokia.com>
> Signed-off-by: Fernando Guzman Lugo <fernando.lugo@ti.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>

People rarely use ' - ' in the commit summary:
% git log --oneline -1000 | grep -e ' - ' | wc -l
32

Which means about only 3%. If you do the same on
drivers/staging/tidspbridge, you'll see that the only commits that
have that are from you.

staging: tidspbridge: configure full L1 MMU range

Other than that, I think this is is a critical bugfix, and should be
applied ASAP.

Cheers.

-- 
Felipe Contreras
