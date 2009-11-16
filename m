From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 26/32] OMAP3: PM debug: allow runtime toggle of PM features
Date: Mon, 16 Nov 2009 10:31:34 -0800
Message-ID: <873a4el3sp.fsf@deeprootsystems.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-12-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-14-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-15-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-16-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-17-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-18-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-19-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-20-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-21-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-22-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-23-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-24-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-25-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-26-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-27-git-send-email-khilman@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A8C87BF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:46882 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbZKPSbc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 13:31:32 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1140445qwe.37
        for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2009 10:31:38 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C87BF@dbde02.ent.ti.com> (Thara Gopinath's message of "Fri\, 13 Nov 2009 15\:35\:57 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

"Gopinath, Thara" <thara@ti.com> writes:

[...]

>>>
>>>+void omap3_pm_off_mode_enable(int enable)
>>>+{
>>>+	struct power_state *pwrst;
>>>+	u32 state;
>>>+
>>>+	if (enable)
>>>+		state = PWRDM_POWER_OFF;
>>>+	else
>>>+		state = PWRDM_POWER_RET;
>>>+
>>>+	list_for_each_entry(pwrst, &pwrst_list, node) {
>>>+		pwrst->next_state = state;
>>>+		set_pwrdm_state(pwrst->pwrdm, state);
>
> Shld the next states of MPU and CORE domain also be changed? 

No.  MPU & CORE are handled by CPUidle, and there the enable_off_mode
flag is checked.

> It should happen only in idle thread or system suspend path. Not at
> any arbit point where user sets enable_off_mode.

Why not?  

If the domain is idle, it is turned off immediately.  If it's not idle,
it doesn't transition until it is.

Kevin
<

