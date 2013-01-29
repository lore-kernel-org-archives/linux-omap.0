From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v2 0/9] ARM: OMAP2+: AM33XX: Misc fixes/updates
Date: Tue, 29 Jan 2013 09:21:41 +0100
Message-ID: <871ud4e6wa.fsf@dell.be.48ers.dk>
References: <1359442762-13697-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:64592 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190Ab3A2IVp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jan 2013 03:21:45 -0500
Received: by mail-ea0-f176.google.com with SMTP id a13so71114eaa.7
        for <linux-omap@vger.kernel.org>; Tue, 29 Jan 2013 00:21:44 -0800 (PST)
In-Reply-To: <1359442762-13697-1-git-send-email-vaibhav.bedia@ti.com> (Vaibhav
	Bedia's message of "Tue, 29 Jan 2013 12:29:13 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, khilman@deeprootsystems.com

>>>>> "Vaibhav" == Vaibhav Bedia <vaibhav.bedia@ti.com> writes:

 Vaibhav> Hi,
 Vaibhav> The following patches were earlier posted as part the AM33XX
 Vaibhav> suspend-resume support series [1]. Based on the suggestion
 Vaibhav> from Santosh Shilimkar <santosh.shilimkar@ti.com> i have split
 Vaibhav> out the changes which update the various data files related
 Vaibhav> to AM33XX support. This version addresses the comments
 Vaibhav> received from Sergei Shtylyov and Peter Korsgaard on the earlier
 Vaibhav> patchset [2].

 Vaibhav> These patches apply on top of v3.8-rc5

Besides the dt compatible property names in patch 8, this series looks
good to me:

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
