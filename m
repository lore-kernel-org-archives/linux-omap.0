From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH][GIT 3/4+] dspbridge custom bool types cleanup
Date: Wed, 6 Aug 2008 11:24:06 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53081F1BBE@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59433 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756312AbYHFQYO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 12:24:14 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m76GO84t012778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 11:24:13 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m76GO7aH029984
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 11:24:07 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

This patch replaces bool typedefs with the ones from the kernel, as reported by checkpatch tool. It should be applied on top of the latest set of cleanup patches (BRD001 to BRD007) and after Felipe's Kbuild patch (BRD008).

As it is quite big, you can found it at:
http://omapzoom.org/gf/project/omapbridge/frs/?action=FrsReleaseBrowse&frs_package_id=16

It is named: BRD009-ARM-OMAP-removed_custom_bool_types.patch

This patch will break compatibility with the previous API and Samples tarballs on omapzoom. The tarballs with new API and Samples to support this will be uploaded very soon! You will be able to download them from:

http://omapzoom.org/gf/project/omapbridge/frs/

Use these API and samples tarballs after applying this patch. I'll send a mail as soon as this tarball is ready.

- omar
