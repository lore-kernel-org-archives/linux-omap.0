From: Jokiniemi Kalle <Kalle.Jokiniemi@digia.com>
Subject: VS: [PATCH] OMAP3: PM: Fix the pwrdm_enable/disable_hdwr_sar funcs
Date: Mon, 8 Jun 2009 10:57:18 +0300
Message-ID: <CA04A6A57256304AB6CA9036AD639A18138D7E46CD@E2K7MAIL.it.local>
References: <1244206853-4426-1-git-send-email-rnayak@ti.com>
	<87hbyu72n8.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.0906051642370.6425@utopia.booyaka.com>,<873aae70n7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:57746 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754299AbZFHH5S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 03:57:18 -0400
In-Reply-To: <873aae70n7.fsf@deeprootsystems.com>
Content-Language: fi-FI
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


________________________________________
L=E4hett=E4j=E4: Kevin Hilman [khilman@deeprootsystems.com]
L=E4hetetty: 6. kes=E4kuuta 2009 1:53
Vastaanottaja: Paul Walmsley
Kopio: Rajendra Nayak; Jokiniemi Kalle; linux-omap@vger.kernel.org
Aihe: Re: [PATCH] OMAP3: PM: Fix the pwrdm_enable/disable_hdwr_sar func=
s

Paul Walmsley <paul@pwsan.com> writes:

>> On Fri, 5 Jun 2009, Kevin Hilman wrote:
>>
>>> Rajendra Nayak <rnayak@ti.com> writes:
>>>
>>> > The pwrdm_enable_hdwr_sar/pwrdm_disable_hdwr_sar do not
>>> > actually set/reset the SAVEANDRESTORE bit in the PWSTCTRL
>>> > register but modify some other bit instead.
>>> > This happens due to the OMAP3430ES2_SAVEANDRESTORE_SHIFT
>>> > being defined as (1 << 4) instead of just 4.
>>> >
>>> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>>
>>> Thanks, pushing to PM branch.
>>>
>>> I'll wait to hear from Kalle if we can revert his previous patch
>>> for this.
>>
>> I think Kalle covered this one already:
>>
>> http://patchwork.kernel.org/patch/15586/
>
> ... but was missing from PM branch.  Remedied now.
>
> But we also have a patch in the PM branch[1] which disables the
> USBHOST SAR by removing the HAS_HDWR_SAR flag for the pwrdm.
>
> I'm gessing/hoping that fixing this shift value allows us to
> revert that patch and am hoping for some confirmation from
> Kalle.

The above shift fix enabled both USBHOST and USBTLL saverestores.
Unfortunately, the USBHOST saverestore seems to cause the USBHOST
power domain to hang in active state after toggling
/sys/power/enable_off_mode 0 -> 1-> 0. This was observed at least
on RX-51. Haven't tested this on other hardware though. USBTLL
saverestore works ok on ES3.1 and later devices.

I think the conclusion from discussion with Richard W. was that using
SW triggered power domain state transition for USBHOST would make
the USBHOST SAR work. The problem with just disabling USBHOST
SAR is that it leaves ES3.0 devices open for the dreaded "cold reset
issue" (as USBTLL SAR won't work on ES3.0).

We are currently using all ES3.1 devices, so there is no push to get a
better fix for this. If anyone wants to take a shot at the problem, fee=
l
free to do so.

- Kalle

>
> Kevin
>
> [1]  http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-omap-p=
m.git;a=3Dcommit;h=3D942fc93ce6b5ec7999f7864f6bb088cc8f308f45
>--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
