From: =?ISO-8859-1?Q?Kevyn=2DAlexandre_Par=E9?=
	<kevyn.alexandre.pare@gmail.com>
Subject: Question OMAP3 and PM
Date: Wed, 3 Jun 2009 20:35:10 -0400
Message-ID: <dc1d0f40906031735j32bf558cj379f3c5be632a6a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f214.google.com ([209.85.217.214]:34402 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875AbZFDAfI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2009 20:35:08 -0400
Received: by gxk10 with SMTP id 10so668905gxk.13
        for <linux-omap@vger.kernel.org>; Wed, 03 Jun 2009 17:35:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, linux-omap@vger.kernel.org

I'm interested in the PM branch latest and greatest that is working
for the beagleboard and the omap3evm.

I clone these git for master branch (2.6.30-rc7) and compile and try
without success.

http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=summary

Beagleboard image was freezing after displaying uncompressed with
success for both branch.

Mistral image was displaying more stuff but no success. I will email
the output later if asking.

First, I'm interested to know which tag/branch should I use?
kernel.org is at 2.6.29.4 for stable? since rc is dev tag I imagine
that the one I'm looking for is v2.6.29-omap1. Do that branch have the
OFF mode, smartrelfex and suspend and resume working? I want to
measure the power consumption of those 2 board.

Thx for helping me out.

Best Regards

kap
