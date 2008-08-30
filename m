From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 0/2] OMAP BRIDGE Power Management implementation
Date: Fri, 29 Aug 2008 22:09:04 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53448FFBBC@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34721 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753880AbYH3DJN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 23:09:13 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pasam, Vijay" <vpasam@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Hi,

I'm submitting Power Management implementation for DSP-BRIDGE code, apply these patches on top of the latest set, also you will need PM patches from Paul Walmsley and Rajendra Nayak to get this working.

You can find the complete dspbridge set at:
https://omapzoom.org/gf/project/omapbridge/frs/?action=FrsReleaseView&release_id=133

Tests performed on Open Source PM:
1. Run samples with performance governor. No issues found.

Known Issues:
1. Observed below messages on opp change request.
<3>clock: Could not find fieldval 0 for clock iva2_ck parent  dpll2_m2_ck
 clock: Could not find fieldval 0 for clock iva2_ck parent dpll2_m2_ck
<3>clock: Could not find fieldval 0 for clock iva2_ck parent dpll2_m2_ck

2. Some times after opp changes IVA status registers are not accessible. 

3. Also MMU Faults were observed.

Currently investigating these issues.

Along with this patch we submit a checkpatch cleanup for function typedefs that were not used, also deleted code related to these typedefs.

- omar
