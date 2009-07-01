From: "HU TAO-TGHK48" <taohu@motorola.com>
Subject: RE: [PATCH 4/4] I2C: OMAP3: PM: (re)init for every transfer to support off-mode
Date: Wed, 1 Jul 2009 17:43:11 +0800
Message-ID: <F12CE1A68F023D498A2691C7B53931150365550F@ZMY16EXM66.ds.mot.com>
References: <1245965646-20070-1-git-send-email-khilman@deeprootsystems.com><1245965646-20070-2-git-send-email-khilman@deeprootsystems.com><1245965646-20070-3-git-send-email-khilman@deeprootsystems.com><1245965646-20070-4-git-send-email-khilman@deeprootsystems.com><1245965646-20070-5-git-send-email-khilman@deeprootsystems.com><4A44AD44.4070107@nokia.com> <87bpobjcx6.fsf@deeprootsystems.com><F12CE1A68F023D498A2691C7B5393115035F09BD@ZMY16EXM66.ds.mot.com><87y6rb7yz7.fsf@deeprootsystems.com><7B4574D56E4ADF438756313E9A172A874D31A30B@dlee01.ent.ti.com>,<87ocs67ndy.fsf@deeprootsystems.com> <7B4574D56E4ADF438756313E9A172A874D31A321@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail119.messagelabs.com ([216.82.241.195]:60261 "EHLO
	mail119.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282AbZGAJne convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jul 2009 05:43:34 -0400
Received: from il27exr03.cig.mot.com (il27exr03.mot.com [10.17.196.72])
	by motgate5.mot.com (8.14.3/8.14.3) with ESMTP id n619hZQw018244
	for <linux-omap@vger.kernel.org>; Wed, 1 Jul 2009 02:43:36 -0700 (MST)
Received: from az10vts04.mot.com (il27vts04.cig.mot.com [10.17.196.88])
	by il27exr03.cig.mot.com (8.13.1/Vontu) with SMTP id n619hZUf014802
	for <linux-omap@vger.kernel.org>; Wed, 1 Jul 2009 04:43:35 -0500 (CDT)
Received: from ZMY16EXM66.ds.mot.com (zmy16exm66.ap.mot.com [10.179.4.26])
	by il27exr03.cig.mot.com (8.13.1/8.13.0) with ESMTP id n619hY6F014781
	for <linux-omap@vger.kernel.org>; Wed, 1 Jul 2009 04:43:35 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <7B4574D56E4ADF438756313E9A172A874D31A321@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org, "Nayak, Rajendra" <rnayak@ti.com>, "Hogander Jouni (Nokia-D/Tampere)" <jouni.hogander@nokia.com>, "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>, Chen Xiaolong-A21785 <A21785@motorola.com>

Hi, Jon

It is fine.

In fact, the credit should be given to Xiaolong Chen
(A21785@motorola.com).



-----Original Message-----
From: Hunter, Jon [mailto:jon-hunter@ti.com] 
Sent: Wednesday, July 01, 2009 12:49 AM
To: Kevin Hilman
Cc: HU TAO-TGHK48; Aaro Koskinen; linux-omap@vger.kernel.org; Nayak,
Rajendra; Hogander Jouni (Nokia-D/Tampere); Pakaravoor, Jagadeesh
Subject: RE: [PATCH 4/4] I2C: OMAP3: PM: (re)init for every transfer to
support off-mode

Hi Kevin,

> Jon, thanks for the clarification.  I will fold this change into the 
> upstream-bound I2C changes.

Thanks.

> Tao, in the future please be sure to cite original authors and/or 
> sources when submitting patches to the list.

Actually, I should point out that Hu Tao and I worked on this together
originally for the omapzoom.org tree. So I should have added Hu Tao's
name to this when submitting originally to omapzoom.org. So we should
give credit to Hu Tao on this. Sorry about that.

Cheers,
Jon
