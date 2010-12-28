From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2] staging: tidspbridge: protect dmm_map properly
Date: Tue, 28 Dec 2010 14:37:26 +0200
Message-ID: <AANLkTi=wBG9AXvDva-_uNjGbRphrb356gZ6ChMJjP8aL@mail.gmail.com>
References: <1292870624-25450-1-git-send-email-felipe.contreras@nokia.com>
 <AANLkTikisHaAMZphRJVYdcokVbaZXVF9COrwkdGTDg__@mail.gmail.com>
 <AANLkTi=9AL3aWUsMeih+Gb-sMov=MgBZ1eTp8wb=q1hZ@mail.gmail.com>
 <AANLkTinX8t=3b48e2sxPU-V_G-nGm_1DyEg6B-CeqXDa@mail.gmail.com>
 <1293452486-notmuch-felipe.contreras@nokia.com> <AANLkTinz0HuhGB_WzTQbK8XkfkGALjtg928WdOUYsySf@mail.gmail.com>
 <AANLkTimCB5g29gzWFzaFU1N8+doROTpWaXy18VU5AJyH@mail.gmail.com>
 <AANLkTi=xmxkWnhuYcjtDNDHgep_2EztfGXDv+winW2Y5@mail.gmail.com>
 <AANLkTiksjHKjKQ+mWE=Zf0+967_E46V3+RURcMC-s5cD@mail.gmail.com>
 <AANLkTi=ZY09yJ=pK4ejqOZjh7YjJp1UemRdMgMfpsz2f@mail.gmail.com> <AANLkTinZ0Uwp8jbmsSwm6ut75A06CxrkESTRJT-GoPkP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinZ0Uwp8jbmsSwm6ut75A06CxrkESTRJT-GoPkP@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, greg@kroah.com, omar.ramirez@ti.com, fernando.lugo@ti.com, nm@ti.com, ameya.palande@nokia.com, h-kanigeri2@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 28, 2010 at 2:24 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> user-space crashed, not kernel-space; the code would continue to run
> and eventually release the lock.

So you'll have to be more specific about the scenario you are describing.

If there's a user thread that is still running the proc_*_dma()
function, and we agree that this thread keeps running until completion
and then returns to user space, what's the problem ?

If that user thread will crash, drv_remove_all_resources() will clean
up all map_obj's.

> Yeah, so the chances of getting this fixed on 2.6.37 are dimmed.

I wouldn't worry about that.. In the worst case, "Cc:
stable@kernel.org" will push the fix into 2.6.37.x..
