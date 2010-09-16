From: venki kaps <venkiece2005@gmail.com>
Subject: Re: OMAP3 DSP MMU fault + off mode issue
Date: Thu, 16 Sep 2010 11:59:03 +0900
Message-ID: <AANLkTikEmoFk89=jFtdgt-cKyRiJ2dkv49CV64bOOf1R@mail.gmail.com>
References: <AANLkTikHM+o_FCgnVzGhs8UtQ_geXFzKNQpGSZiEN7sx@mail.gmail.com>
	<AANLkTimd_sRpOYaurOT0iSbfd0pMZvhxgUcaqbQvSobu@mail.gmail.com>
	<AANLkTimO1UK+WA8Mc3Myi3gWBpD=D7tXDOX104a8NMKW@mail.gmail.com>
	<87mxrjgjre.fsf@deeprootsystems.com>
	<AANLkTi=oSTBhceK+oMKH8r9ybeMo4XYcQ+hYQOTRY94u@mail.gmail.com>
	<AANLkTi=wydMEm4=kEuxLvNMfAWE6kzAKQ4wBHKFfgXGZ@mail.gmail.com>
	<AANLkTi=cH+P6v1t2K5SCBY7EV08egqV2j6b0avJomv7u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34275 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab0IPC7E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 22:59:04 -0400
In-Reply-To: <AANLkTi=cH+P6v1t2K5SCBY7EV08egqV2j6b0avJomv7u@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, omar.ramirez@ti.com, h-kanigeri2@ti.com, ameya.palande@nokia.com, fernando.lugo@ti.com, x0hebbar@ti.com, ernesto@ti.com, s-anna@ti.com, grgupta@ti.com, ivan.gomez@ti.com, ext-andriy.shevchenko@nokia.com, x0095078@ti.com, deepak.chitriki@ti.com, nm@ti.com, ext-phil.2.carmody@nokia.com, ohad@wizery.com, devel@linuxdriverproject.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Sep 16, 2010 at 7:34 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, Sep 15, 2010 at 7:03 PM, venki kaps <venkiece2005@gmail.com> wrote:
>> In latest kernels (Eg, linux-2.6.36-rc3),The MMU-Fault debugging
>> enhancements code is moved under CONFIG_TIDSPBRIDGE_BACKTRACE.
>
> Indeed, I added that configuration in order to avoid that possibly
> troublesome code in a production system. I haven't seen it working
> properly yet.
Thanks for the information.
Even I have not used that configuration but in production system, We
could avoid the DSP task information to be printed by the MPU
dspbridge when DSP MMU fault ocurrs.

Venkii,
