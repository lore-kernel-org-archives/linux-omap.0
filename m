From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RESEND PATCH] staging: tidspbridge: protect dmm_map properly
Date: Fri, 11 Mar 2011 20:31:03 +0200
Message-ID: <AANLkTik+tjZvyagV3PE4grjJJx-q_AEuKCa3z+e99WzC@mail.gmail.com>
References: <1299864633-27542-1-git-send-email-felipe.contreras@nokia.com>
	<AANLkTi=Hy18s5fOziHSNdG6QUZE85bg0Bb9cAqE42mVQ@mail.gmail.com>
	<AANLkTin_2yo705Ka3KO_09nK3ZUEi_0uYfi6fKQqwBVV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTin_2yo705Ka3KO_09nK3ZUEi_0uYfi6fKQqwBVV@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>, linux-main <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Ohad Ben-Cohen <ohad@wizery.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Tuomas Kulve <tuomas@kulve.fi>
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 11, 2011 at 8:05 PM, Ramirez Luna, Omar <omar.ramirez@ti.com> wrote:
> On Fri, Mar 11, 2011 at 11:38 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Omar, 2.6.38 is imminent, if this patch has any chance of getting in,
>> I think you would need to push it soon.
>
> I'll push it to my queue, however I don't think this would be even
> considered to make it before the official 2.6.38 which should happen
> in the next few days, given that it should climb to staging tree first
> and from there to mainline... we could attempt to shot directly to the
> mainline kernel, but that would raise a few eyebrows and in the end be
> rejected as well because this is a staging driver which is still in
> process of cleanup.

Well, not crashing is better than crashing, regardless of the status
of the driver. And there's no reason not to include the fix.

But if you send it to Greg, then it's Greg's call.

> OTOH, this patch was there long ago, since December, but I just lost
> the track of it at the moment, along with the other proposed
> solutions, so I take it as my fault for not picking it up then.

I don't think there was any consensus as which fix was supposed to go
forward or how, but now there is.

Cheers.

-- 
Felipe Contreras
