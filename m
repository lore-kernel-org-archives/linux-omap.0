From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: GCC 5.1 bug affecting ARM kernels
Date: Fri, 15 May 2015 01:51:42 +0300
Message-ID: <20150514225142.GE609@fuloong-minipc.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:34608 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422863AbbENWvt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2015 18:51:49 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

There is a code generation bug in GCC 5.1 that affects some ARM kernels:

	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=65932

The bug report mentions arm926ej-s, and also some OMAP1 and 2 kernels
fail to boot (there is a crash after warnings about some bogus duplicate
sysfs files) unless they are compiled with -fno-ipa-sra.

A.
