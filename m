From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: On the APIs for Enabling and Disabling Wakeup capability.
Date: Mon, 28 Jun 2010 09:25:26 -0700
Message-ID: <878w5z6s5l.fsf@deeprootsystems.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E75F0BBF@dbde02.ent.ti.com>
	<87vd9isdxb.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94026FFCAA53@dbde02.ent.ti.com>
	<74583B8642AB8841B30447520659FCA901AA4908FF@dnce01.ent.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E940270056DEE@dbde02.ent.ti.com>
	<87ljacbd5u.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E76F4082@dbde02.ent.ti.com>
	<87sk4dqynm.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402700F3049@dbde02.ent.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E940270192021@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:57737 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab0F1QZa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jun 2010 12:25:30 -0400
Received: by pxi8 with SMTP id 8so1876673pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 28 Jun 2010 09:25:30 -0700 (PDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940270192021@dbde02.ent.ti.com>
	(Hema Kalliguddi's message of "Mon, 28 Jun 2010 19:55:00 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "Basak, Partha" <p-basak2@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>, "Kamat, Nishant" <nskamat@ti.com>

"Kalliguddi, Hema" <hemahk@ti.com> writes:

>>>>> > http://focus.ti.com/pdfs/wtbu/SWPU223D_Final_EPDF_06_07_2010.pdf
>>>>> >
>>
>>[HK] The errata is applicable to OMAP3430 only.  But this sequence
>>applicable for omap4 as well. So for submitting the changes we need to
>>have the HWMOD api to be changed to enaforce the Autodile set only
>>after the smart idle.
>
> When can I expect the HWMOD API change which includes the auto idle
> setting only after Smart idle setting and wakeup enable/disable
> settings?

Hi Hema,

If this is blocking you, rather than waiting for somone else to add this
feature, I suggest that you add the API you think would be needed with
proposed patches to the hwmod layer.  One for the idle settings, another
for wakeups.  In the changelog, describe (in detail) the reasons these
APIs would be used.

Kevin
