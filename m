From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] CPUidle: increment state counter for state actually
 entered
Date: Wed, 1 Oct 2008 10:35:03 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620365A10BE6@dlee02.ent.ti.com>
References: <1222858024-20369-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_13B9B4C6EF24D648824FF11BE89671620365A10BE6dlee02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37645 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbYJAPf7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Oct 2008 11:35:59 -0400
In-Reply-To: <1222858024-20369-1-git-send-email-khilman@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--_002_13B9B4C6EF24D648824FF11BE89671620365A10BE6dlee02enttico_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Wednesday, October 01, 2008 5:47 AM

> This patch does the accounting use 'dev->last_state' state instead of
> the governor-chosen state.  If the target's enter_idle hook enters a
> different state than it was asked, it should update dev->last_state.

Isn't this the same as the patch Venki pushed on the pm list?  I've been us=
ing a version of it for a while from him and haven't seen any issue.

I had also done a version which was much more evasive.  In the version I wa=
s hacking at I tried to push the aborted state information back into the go=
vernor as it locally caches the last state tried.

Doing this simpler way like in patch does make sure the accounting is corre=
ct which is a plus, powertop doesn't 'lie' any more.  It however, does not =
stop a following likely mis-prediction based on the local state kept in the=
 governor.

Doing at least this much is necessary.  However, if you don't want to feed =
the false state data into the predictor more linkage has to be done.

Regards,
Richard W.




--_002_13B9B4C6EF24D648824FF11BE89671620365A10BE6dlee02enttico_
Content-Type: message/rfc822

Received: from dflp53.itg.ti.com (128.247.5.6) by dlee73.ent.ti.com
 (157.170.170.88) with Microsoft SMTP Server (TLS) id 8.1.291.4; Mon, 29 Sep
 2008 17:37:39 -0500
Received: from sabine.ext.ti.com (localhost [127.0.0.1])	by dflp53.itg.ti.com
 (8.13.8/8.13.8) with ESMTP id m8TMbZrx024715;	Mon, 29 Sep 2008 17:37:35 -0500
 (CDT)
Received: from mail13-sin-R.bigfish.com (mail-sin.bigfish.com [207.46.51.74])
	by sabine.ext.ti.com (8.13.7/8.13.7) with ESMTP id m8TMbSn0017520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);	Mon, 29
 Sep 2008 17:37:35 -0500
Received: from mail13-sin (localhost.localdomain [127.0.0.1])	by
 mail13-sin-R.bigfish.com (Postfix) with ESMTP id C1A6F14E8102;	Mon, 29 Sep
 2008 22:37:27 +0000 (UTC)
Received: by mail13-sin (MessageSwitch) id 1222727845391794_30839; Mon, 29 Sep
 2008 22:37:25 +0000 (UCT)
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
 [140.211.169.13])	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)	by mail13-sin.bigfish.com (Postfix) with
 ESMTP id C6CA8520076;	Mon, 29 Sep 2008 22:37:24 +0000 (UTC)
Received: from daredevil.linux-foundation.org (localhost [127.0.0.1])	by
 smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id
 m8TMWcfM023136;	Mon, 29 Sep 2008 15:32:39 -0700
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])	by
 smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with	ESMTP id
 m8TMUKdd022574 for <linux-pm@lists.linux-foundation.org>;	Mon, 29 Sep 2008
 15:30:23 -0700
Received: from orsmga001.jf.intel.com ([10.7.209.18])	by
 orsmga101.jf.intel.com with ESMTP; 29 Sep 2008 15:24:19 -0700
Received: from linux-os.sc.intel.com ([172.25.110.8])	by
 orsmga001.jf.intel.com with ESMTP; 29 Sep 2008 15:29:16 -0700
Received: by linux-os.sc.intel.com (Postfix, from userid 47009)	id 1590328006;
 Mon, 29 Sep 2008 15:30:11 -0700 (PDT)
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: "lenb@kernel.org" <lenb@kernel.org>
CC: "linux-pm@lists.linux-foundation.org"
	<linux-pm@lists.linux-foundation.org>
Sender: "linux-pm-bounces@lists.linux-foundation.org"
	<linux-pm-bounces@lists.linux-foundation.org>
Date: Mon, 29 Sep 2008 17:24:26 -0500
Subject: [linux-pm] [patch 0/2] cpuidle: Time accounting fix
Thread-Topic: [linux-pm] [patch 0/2] cpuidle: Time accounting fix
Thread-Index: Ackig/qdOwDdTw5RRFOBcTheX+9W9g==
Message-ID: <20080929222426.914988000@intel.com>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: 
 <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
 	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
List-Unsubscribe: 
 <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
 	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-AuthSource: dlee73.ent.ti.com
X-MS-Has-Attach: 
X-Auto-Response-Suppress: All
X-MS-TNEF-Correlator: 
list-post: <mailto:linux-pm@lists.linux-foundation.org>
user-agent: quilt/0.46-1
x-ironport-av: E=Sophos;i="4.33,334,1220252400"; d="scan'208";a="445066257"
x-spam-status: No, hits=-104.19 required=5
 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,USER_IN_WHITELIST
x-bigfish: vps-45(zzzz272Rzz2ba5Mz2fheILfR6bh66h)
errors-to: linux-pm-bounces@lists.linux-foundation.org
list-id: Linux power management <linux-pm.lists.linux-foundation.org>
x-scanned-by: MIMEDefang 2.63 on 140.211.169.21
received-spf: pass (localhost is always allowed.)
x-spam-checker-version: SpamAssassin 3.2.4-osdl_revision__1.47__
x-spam-tcs-scl: 5:0
list-archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
x-extloop1: 1
x-beenthere: linux-pm@lists.linux-foundation.org
x-mailman-version: 2.1.9
x-mimedefang-filter: lf$Revision: 1.188 $
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

As noted in PM minisummit notes here
http://lwn.net/Articles/292447/

Richard Woodruff <r-woodruff2@ti.com> reported a bug
"the CPUIDLE bug that if target is avoided due to BM activity the original
target state is still accounted the time."

Following provides a mechanism to fix the problem for all drivers and fixes
the problem for acpi cpuidle driver.

--
--_002_13B9B4C6EF24D648824FF11BE89671620365A10BE6dlee02enttico_--
