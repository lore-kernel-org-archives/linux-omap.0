From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/2] omap: dsp: make the driver actually work
Date: Tue, 5 Oct 2010 22:23:52 +0300
Message-ID: <AANLkTikOBWxXh7uVrDxfW3OnwOM58JTXU76KUUoQWBWM@mail.gmail.com>
References: <1286208555-8829-1-git-send-email-felipe.contreras@gmail.com>
	<20101005190741.GC20825@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101005190741.GC20825@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, Tony Lindgren <tony@atomide.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 5, 2010 at 10:07 PM, Greg KH <greg@kroah.com> wrote:
> On Mon, Oct 04, 2010 at 07:09:13PM +0300, Felipe Contreras wrote:
>> It seems the platform device was dropped from the migration of tidspbridge into
>> staging, plus the sdram meblock (previously bootmem) required for it work are
>> gone.
>>
>> Withouth these patches the driver loads, but doesn't do anything.
>>
>> A second issue with ioremap() still remains, but that can be solved by
>> reverting 309caa9.
>>
>> I think these might be worth to get into 2.6.36, if not, I have versions with
>> more changes; cleanups and so on.
>
> I've applied this to my staging-next tree, for .37, as it's not a big
> deal for .36.

Well, I thought it would be nice if the driver actually worked on .36,
but anyway, I'll rebase the rest of my cleanup patches and send them.
Hopefully I find a way to get rid of the ioremap() issue.

Cheers.

-- 
Felipe Contreras
