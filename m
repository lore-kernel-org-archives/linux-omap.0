From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] staging: tidspbridge: protect dmm_map properly
Date: Sun, 13 Mar 2011 01:42:35 +0200
Message-ID: <AANLkTinp0e4EiEH=XV9gCSJzoh-VAY-6qqs91x0s80ro@mail.gmail.com>
References: <1299889746-16502-1-git-send-email-omar.ramirez@ti.com>
	<20110312173626.GC24981@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110312173626.GC24981@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, l-m <linux-kernel@vger.kernel.org>, Felipe Contreras <felipe.contreras@nokia.com>, l-o <linux-omap@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Tuomas Kulve <tuomas@kulve.fi>
List-Id: linux-omap@vger.kernel.org

On Sat, Mar 12, 2011 at 7:36 PM, Greg KH <greg@kroah.com> wrote:
> On Fri, Mar 11, 2011 at 06:29:06PM -0600, Omar Ramirez Luna wrote:
>> Please consider to apply this patch in the staging tree, as the
>> description says it fixes a crash in tidspbridge driver, this bug
>> was already present but it seems to have surfaced by recent tests
>> made by Felipe and Tuomas.
>>
>> It is an urgent fix for 2.6.38.
>
> Heh, it's funny to see such a "urgent" fix take so long to get to me :)

Well, depending on your hardware and use-case this might or might not
be urgent. At least for some people the driver is unusable without
this.

> Is it also applicable for .37?

Yes.

> How about I send it to Linus for .39 and then add it to the .38-stable
> tree when it comes out?

That was the plan for .38/.37-stable. I'd say that's fine, but it
would be even better to avoid people getting bit by this on plain .38.

Cheers.

-- 
Felipe Contreras
