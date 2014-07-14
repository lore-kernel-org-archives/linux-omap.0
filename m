From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 0/5] OMAP Mailbox framework adoption & DT support
Date: Mon, 14 Jul 2014 10:58:04 -0500
Message-ID: <53C3FE0C.4080502@ti.com>
References: <1405116252-53612-1-git-send-email-s-anna@ti.com> <CAPdLdq=ZnPBQiGVbKOk8G5soP=uPYpT7mEjigpR=W1Hc4btV3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPdLdq=ZnPBQiGVbKOk8G5soP=uPYpT7mEjigpR=W1Hc4btV3g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Mayer <markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Device Tree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Markus,

On 07/11/2014 06:15 PM, Markus Mayer wrote:
> On 11 July 2014 15:04, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> wrote:
>> Hi,
>>
>> This is a refresh of the OMAP Mailbox framework adoption & DT support
>> series [1], to work with the revised OMAP mailbox DT/hwmod cleanup
>> series [2].
>>
>> The series has one less patch than the previous series, with the patch
>> "mailbox/omap: add a custom of_xlate function" squashed into the OMAP
>> mailbox framework adaptation patch. The first 3 patches deal with the
>> OMAP DT bindings and parse support like previous series, and the last
>> 2 patches deal with the mailbox framework adaptation. The testing is
>> also done with the updated v8 version of mailbox framework [3] from
>> Jassi Brar, no changes are required for the v7 to v8 update.
>>
>> The AM335 PM suspend series [4] which relies on this series also does
>> not require any changes.
> 
> May I ask what branch this series is based upon? I tried a number of
> branches (3.16-rcX, 3.15, linux-next), and the series won't apply to
> any of them (other than patch 1/5, which does apply fine, but that
> also contains no code).

There are couple of dependent preparatory series. You probably missed
the following in the cover letter.
> The series depends on the OMAP mailbox cleanup series [5] and the
> refreshed OMAP mailbox DT/hwmod cleanup series [2].

As long as you pick the two dependent series, they apply fine on any of
the 3.16-rcs. I have posted all the series based on 3.16-rc2. Here's a
merged branch for your reference (not for pulling though, it has one
additional commit to allow me to test on OMAP2)
https://github.com/sumananna/mailbox/commits/submit/3.16-rc2-omap-mbox-v8-fwk-v2

The last 2 patches in the series also depend on the mailbox framework
patches from Jassi to not throw any build errors if enabled.

regards
Suman
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
