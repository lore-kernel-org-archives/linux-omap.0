From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RESEND PATCH] staging: tidspbridge: protect dmm_map properly
Date: Fri, 11 Mar 2011 19:38:57 +0200
Message-ID: <AANLkTi=Hy18s5fOziHSNdG6QUZE85bg0Bb9cAqE42mVQ@mail.gmail.com>
References: <1299864633-27542-1-git-send-email-felipe.contreras@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1299864633-27542-1-git-send-email-felipe.contreras@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>
Cc: linux-main <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg KH <greg@kroah.com>, Ohad Ben-Cohen <ohad@wizery.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Tuomas Kulve <tuomas@kulve.fi>
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 11, 2011 at 7:30 PM, Felipe Contreras
<felipe.contreras@nokia.com> wrote:
> We need to protect not only the dmm_map list, but the individual
> map_obj's, otherwise, we might be building the scatter-gather list with
> garbage. So, use the existing proc_lock for that.
>
> I observed race conditions which caused kernel panics while running
> stress tests, also, Tuomas Kulve found it happening quite often in
> Gumstix Over. This patch fixes those.
>
> Cc: Tuomas Kulve <tuomas@kulve.fi>
> Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>

Omar, 2.6.38 is imminent, if this patch has any chance of getting in,
I think you would need to push it soon.

Cheers.

-- 
Felipe Contreras
