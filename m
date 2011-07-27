From: "Hilman, Kevin" <khilman@ti.com>
Subject: Re: [RFC/PATCH 0/7] decouple platform_device from omap_device
Date: Wed, 27 Jul 2011 14:45:33 -0700
Message-ID: <CALyTGODe8r9zr4fA+AX=-XhpLjNXKtfHzxFUWMNSehDawEDMBA@mail.gmail.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<20110727140457.GA8558@manju-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:44491 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753031Ab1G0Vpj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jul 2011 17:45:39 -0400
Received: by mail-iy0-f180.google.com with SMTP id 42so2237417iyh.25
        for <linux-omap@vger.kernel.org>; Wed, 27 Jul 2011 14:45:33 -0700 (PDT)
In-Reply-To: <20110727140457.GA8558@manju-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Grant Likely <grant.likely@secretlab.ca>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hi Manjunath,

On Wed, Jul 27, 2011 at 7:04 AM, G, Manjunath Kondaiah <manjugk@ti.com>=
 wrote:
> Kevin,
>
> On Thu, Jul 21, 2011 at 04:52:10PM -0700, Kevin Hilman wrote:
>> Here's a first whack, proof-of-concept on how we could start to
>> decouple the platform_device from an omap_device.
>>
>> The main RFC is in the last patch, and everything leading up to it a=
re
>> misc. omap_device cleanups that make the last patch cleaner and
>> clearer. =A0It's really the last patch that does the decoupling.
>>
>> This will be necessary if we're going to decouple the platform_devic=
e
>> creation from the omap_device/omap_hwmod creation etc. =A0This patch
>> leaves them both done in omap_device_build(), but shows that they ca=
n
>> be decoupled.
> Can you pls mention baseline used for these patches? I tried applying=
 on
> latest mainline, v3.0 and =A0git://git.pwsan.com/linux-2.6 prcm-devel=
-3.1

Oops, sorry.  I forgot to mention it.

Due to some misc. dependencies (mainly on Beagle board file), I've
temporarily based it on the for-next branch of the arm-soc tree[1]
since that has everything already queued for the next merge window. I
also based it on the omap_device patch I posted which changes the pr_*
prints to dev_*.

=46or convenience, I've pushed this series to the 'wip/od-devres' branc=
h
of my tree[2].

Sorry for the confusion,

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/arm/linux-arm-soc.git

[2] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm=
=2Egit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
