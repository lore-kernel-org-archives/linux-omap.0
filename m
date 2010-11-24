From: TAO HU <tghk48@motorola.com>
Subject: OMAP4 ES2.0 Unhandled fault: imprecise external abort
Date: Wed, 24 Nov 2010 11:11:44 +0800
Message-ID: <AANLkTinXqSA0botGAGzEtk8_xOVt0W05k9+0w4v1gqF0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:47564 "EHLO
	exprod5og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955Ab0KXDLw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Nov 2010 22:11:52 -0500
Received: from il27vts01 (il27vts01.cig.mot.com [10.17.196.85])
	by mdgate2.corp.mot.com (8.14.3/8.14.3) with SMTP id oAO3AM7Y010661
	for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 20:10:22 -0700 (MST)
Received: from mail-ey0-f182.google.com (mail-ey0-f182.google.com [209.85.215.182])
	by mdgate2.corp.mot.com (8.14.3/8.14.3) with ESMTP id oAO2xr7W007471
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 20:10:22 -0700 (MST)
Received: by mail-ey0-f182.google.com with SMTP id 7so20377279eyb.27
        for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 19:11:44 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi, All

We got following errors on OMAP ES2.0 board.

And noticed a similar case was reported at below link
http://www.opensubscriber.com/message/kernel-team@lists.ubuntu.com/14591440.html

Is any conclusion/fix available?

<1>[ 348.873840] Unhandled fault: imprecise external abort (0x1406) at
0x462d301c
<1>[ 348.885040] Unhandled fault: imprecise external abort (0x1406) at
0xbe8fec78
<1>[ 348.897247] Unhandled fault: imprecise external abort (0x1406) at
0xbe8fec78
<1>[ 348.954772] Unhandled fault: imprecise external abort (0x1406) at
0xb000c454
<1>[ 348.967590] Unhandled fault: imprecise external abort (0x1406) at
0xb000c454
<1>[ 348.989471] Unhandled fault: imprecise external abort (0x1406) at
0xbeb02fb8
<4>[ 349.006683] Process 2664(coredump) has RLIMIT_CORE set to 1
<4>[ 349.012481] Aborting core
<1>[ 349.023040] Unhandled fault: imprecise external abort (0x1406) at
0xbeb02fb8
<1>[ 349.041625] Unhandled fault: imprecise external abort (0x1406) at
0xbed6cfbc
<4>[ 349.061370] Process 2665(kkkkkkkkkkkkkkk) has RLIMIT_CORE set to 1
<4>[ 349.067810] Aborting core
<0>[ 349.077362] Kernel panic - not syncing: Attempted to kill init!

-- 
Best Regards
Hu Tao
