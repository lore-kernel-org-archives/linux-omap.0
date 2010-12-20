From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/2] staging: tidspbridge: fix dma race condition
Date: Mon, 20 Dec 2010 19:11:01 +0200
Message-ID: <AANLkTikZN8rPcusHrOR3eCyQWXmzd=fMc4riRvKpzQ_O@mail.gmail.com>
References: <1292855134-14374-1-git-send-email-felipe.contreras@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1292855134-14374-1-git-send-email-felipe.contreras@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>
Cc: linux-main <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 20, 2010 at 4:25 PM, Felipe Contreras
<felipe.contreras@nokia.com> wrote:
> I found a race condition that triggers a kernel panic. It's explained in the
> following patches, but basically the map_obj that contains the user pages is
> being destroyed while doing a DMA operation (which requires that map_obj).
>
> My solution is to convert the spinlock to a semaphore, and exten the area
> protected (which might sleep).
>
> I have not tested these specific patches; they have been forward ported. But in
> a similar branch, they solve the issue.

Please disregard this patch series, I'll send a simpler single patch
that does the trick.

-- 
Felipe Contreras
