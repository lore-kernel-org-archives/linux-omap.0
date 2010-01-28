From: "Andrew Murray" <amurray@mpc-data.co.uk>
Subject: RE: [PATCH] omap3: pm: cpufreq: populate l3 opp1 again
Date: Thu, 28 Jan 2010 14:00:18 -0000
Message-ID: <0C997DD87CC88A4F86C897F52650B52B02807801@MOLSON.mpc-data.co.uk>
References: <1264657260-12310-1-git-send-email-nm@ti.com> <4B6134EB.8040202@ti.com> <74583B8642AB8841B30447520659FCA9E768536D@dnce01.ent.ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301E22B41EC@dbde02.ent.ti.com> <74583B8642AB8841B30447520659FCA9E76853B4@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cvs.mpc-ogw.co.uk ([81.2.99.171]:36319 "EHLO
	molson.mpc-data.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932219Ab0A1OAV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 09:00:21 -0500
Content-class: urn:content-classes:message
In-Reply-To: <74583B8642AB8841B30447520659FCA9E76853B4@dnce01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "Dasgupta, Romit" <romit@ti.com>, "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

> From: Cousson, Benoit [mailto:b-cousson@ti.com]
> Sent: 28 January 2010 13:48
> To: Dasgupta, Romit; Menon, Nishanth
> Cc: linux-omap; Andrew Murray; Kevin Hilman
> Subject: RE: [PATCH] omap3: pm: cpufreq: populate l3 opp1 again

> I don't want to keep it. I just want to document it in order to
explain
> why the code is not aligned with the public doc.
> 
> Andrew did ask the question so the answer might be useful for others
as
> well, hence a small comment on top of the CORE OPP list.
> 
> Benoit

I agree. 

I don't think it matters if the OPP 'OMAP_OPP_DEF' is there or not.
Though as the OPPs differ to the hardware descriptions it should be
documented - perhaps as suggested, by a comment.

It is confusing when validating the power management software support -
and the best place to look for the rationale is in the code. 

Andrew Murray
