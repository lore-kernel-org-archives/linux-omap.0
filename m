From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: [PATCH RFC 2/2] usb: ehci-omap: add suspend/resume support
Date: Fri, 8 Oct 2010 01:34:28 +0530
Message-ID: <AANLkTikCdVASKnYN_vYa8+FCfsNdTgPPH0dLKbOS9Lh8@mail.gmail.com>
References: <1273762822-23073-2-git-send-email-gadiyar@ti.com>
 <Pine.LNX.4.44L0.1005131305320.1731-100000@iolanthe.rowland.org>
 <5A47E75E594F054BAF48C5E4FC4B92AB0322D7D8AA@dbde02.ent.ti.com> <AANLkTi=EoEUDsSVjo7somYESe6k8ziB+FGKrnMAZ2OAC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:58386 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751418Ab0JGUEw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Oct 2010 16:04:52 -0400
In-Reply-To: <AANLkTi=EoEUDsSVjo7somYESe6k8ziB+FGKrnMAZ2OAC@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laine Walker-Avina <lwalkera@ieee.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>

On Fri, Oct 8, 2010 at 1:17 AM, Laine Walker-Avina <lwalkera@ieee.org> =
wrote:
> On Fri, May 14, 2010 at 7:01 AM, Gadiyar, Anand <gadiyar@ti.com> wrot=
e:
>> Alan Stern wrote:
>>> On Thu, 13 May 2010, Anand Gadiyar wrote:
>>>
>>> > Add support for suspend and resume to the ehci-omap driver.
>>> > Added routines for platform_driver suspend/resume and
>>> > wrappers around ehci_bus_suspend/resume.
>>>

=2E..

>>> You could use the runtime-PM interface instead of explicitly suspen=
ding
>>> and resuming the controller. =A0It is now standard.
>>>
>>
>> Will work on this. I'll be out for a while, so it could be some time
>> before I repost.
>>
>> Thanks,
>> Anand
>
> Any more developments on this?
>

Yup. We've rewritten this driver to factor out the common
TLL and UHH programming, so that it plays nicely
when EHCI and OHCI are both loaded. This was needed
to be able to use the omap_device layer to use runtime PM

We didn't want to do the work twice, that's why we
abandoned this initial patch to do it cleanly once.
The current version is being tested now and should
be posted in a while.

It's available on internal trees on dev.omapzoom.org,
if you want to take a look. I can send a link if you like.

- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
