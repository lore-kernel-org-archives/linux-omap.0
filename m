From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 13:18:51 +0200
Message-ID: <AANLkTim4021cTnhVZrQpefq1MG-eEPOFLDRO-XDepHb4@mail.gmail.com>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<201005242049.18920.rjw@sisk.pl>
	<87wrusvrqe.fsf@deeprootsystems.com>
	<201005250138.16293.rjw@sisk.pl>
	<1274863655.5882.4875.camel@twins>
	<AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
	<1274867106.5882.5090.camel@twins>
	<20100526120242.5c9b73ad@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100526120242.5c9b73ad@schatten.dmk.lab>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Mickler <florian@mickler.org>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Wed, May 26, 2010 at 12:02 PM, Florian Mickler <florian@mickler.org> wrote:

>> So why again was this such a great scheme? Go fix your userspace to not
>> not run when not needed.
>
> Hi Peter!
>
> This was already mentioned in one of these threads.
>
> The summary is: The device this kernel is running on dosn't want to
> (or can) rely on userspace to save power. This is because it is an open
> system, without an app-store or the like. Everyone can run what he
> wants.

I don't see this as a valid point. Everyone can run a different kernel
where nothing will just work. Are you aiming protection against that
as well?

~Vitaly
