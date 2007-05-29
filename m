From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] USB: Fix OTG HNP for hub.c
Date: Tue, 29 May 2007 13:34:58 -0700
Message-ID: <20070529203458.GB27603@atomide.com>
References: <11804401622277-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401752426-git-send-email-felipebalbi@users.sourceforge.net>
	<1180440176127-git-send-email-felipebalbi@users.sourceforge.net>
	<200705291221.20343.david-b@pacbell.net>
	<31e679430705291224h5f1e8552paf8bff92f97f7f3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <31e679430705291224h5f1e8552paf8bff92f97f7f3f@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <felipebalbi@users.sourceforge.net> [070529 12:25]:
> Hi,
>
> On 5/29/07, David Brownell <david-b@pacbell.net> wrote:
>> On Tuesday 29 May 2007, Felipe Balbi wrote:
>> > From: Tony Lindgren <tony@atomide.com>
>> >
>> > This patch makes makes OTG Host Negotiation Protocol (HNP)
>> > to behave.
>>
>> Not really.  It makes it strongly *MIS* behave in fact,
>> since it always kicks off HNP ... even when it should not
>> do so, because the device is in the whitelist.  (Called
>> the "Targeted Peripherals List", TPL, in jargonese.)
>>
>> The two blocks of code are in the wrong order ...

Hmm, are you sure about that? My patch is based on
USB_TG_1-3.pdf and playing with usbcv13.exe and two N800s.

I'm under the impression that if the peripheral supports HNP, the
host must offer HNP at least once during the session.

And as I understand, the whitelist is for peripherals the host
supports, with HNP or no HNP.

With my patch, we offer to do HNP right in the beginning of the
session. Then the peripheral can use it or not use depending if
HNP is enabled on peripheral.

>> A more limited patch would help.  Specifically, just
>> fixing whatever bug was seen in the original code,
>> rather than abstracting it into a new subroutine and
>> changing the logic while doing so.

Dave, did you ever get HNP working with any device and test
it with usbcv13.exe and OPT?

> Tony do you have any comments?
> Do you mind if I try to re-work you patch?

Felipe I guess you're the only one with OPT right now, and that's
really what we should use for doing the HNP. So go ahead!

Regards,

Tony
