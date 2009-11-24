From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 0/2] VFP save/restore for OMAP3
Date: Tue, 24 Nov 2009 12:37:02 +0200
Message-ID: <1259059024-23719-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:31665 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663AbZKXKj2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 05:39:28 -0500
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Hi,

The following two patches are needed by OMAP3 to save/restore VFP context
during off-mode. Patch 1 adds generic support inside ARM VFP code, and the
second one adds the necessary hooks into OMAP3 power management code.

--Tero


