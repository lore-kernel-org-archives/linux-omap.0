From: david.hagood@gmail.com
Subject: where is "struct constraint_id" defined?
Date: Thu, 5 Mar 2009 09:54:13 -0600 (CST)
Message-ID: <6e77f93b754e8ec34333f764a6a00c43.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:48334 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbZCEPyT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 10:54:19 -0500
Received: by qw-out-2122.google.com with SMTP id 5so5807286qwi.37
        for <linux-omap@vger.kernel.org>; Thu, 05 Mar 2009 07:54:16 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id 0885EC7B8014
	for <linux-omap@vger.kernel.org>; Thu,  5 Mar 2009 09:54:13 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I am trying to build the OMAP3 graphics kernel module against
2.6.29-rc7-omap1 (from GIT), and have been running into problems getting
it to build.

Two problems were pretty easy: the TI code was including "asm/resource.h"
and "asm/semaphore.h" rather than "linux/resource.h" and
"linux/semaphore.h".

Having made those changes, it builds all the way through to the TI
supplied "sysutils_linux.c", which barfs with :

In file included from
/space/src/OMAP35x_Graphics_SDC_3_00_00_06/GFX_Linux_KM/services4/srvkm/env/linux/kbuild/../../../../../services4/system/omap3430/sysutils.c:28:
/space/src/OMAP35x_Graphics_SDC_3_00_00_06/GFX_Linux_KM/services4/srvkm/env/linux/kbuild/../../../../../services4/system/omap3430/sysutils_linux.c:154:
error: variable 'cnstr_id_vdd2' has initializer but incomplete type

(and many other errors).

The problem line of the code is:

static struct constraint_id cnstr_id_vdd2 = {

and I cannot find a definition of "struct constraint_id" anywhere in the
kernel.

Has this been renamed, or moved, or am I looking in the wrong place?



