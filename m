From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] staging: tidspbridge: protect dmm_map properly
Date: Mon, 7 Mar 2011 20:14:22 +0200
Message-ID: <AANLkTikLv7xi4PF5j8dw9kFZbJaNR5utGbU3E=uBveFO@mail.gmail.com>
References: <1292865120-24020-1-git-send-email-felipe.contreras@nokia.com> <AANLkTi=w=5L8tbjGDCgoRpjRXYrNxsfWaE2SL4XG9+pY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=w=5L8tbjGDCgoRpjRXYrNxsfWaE2SL4XG9+pY@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>, linux-main <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 7, 2011 at 8:02 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Dec 20, 2010 at 7:12 PM, Felipe Contreras
> <felipe.contreras@nokia.com> wrote:
>> We need to protect not only the dmm_map list, but the individual
>> map_obj's, otherwise, we might be building the scatter-gather list with
>> garbage. So, use the existing proc_lock for that.
>>
>> I observed race conditions which caused kernel panics while running
>> stress tests. This patch fixes those.
>
> I just heard that Tuomas Kulve is getting a lot of panics on Gumstix
> Overo. I propose we apply this patch on the stable tree ASAP, and if
> there's no better proposals, also on .38.

Agree that a fix should be merged asap, and I don't mind which.
Especially since things have changed lately and chances that we will
use this code for OMAP4 too are really small now.
