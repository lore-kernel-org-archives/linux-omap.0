From: Ming Lei <tom.leiming@gmail.com>
Subject: [QUESTION] How to enable runtime PM
Date: Mon, 27 Sep 2010 10:07:07 +0800
Message-ID: <AANLkTikAmbXPE=WX=D=g12xCVRUrmrXGY_qwuteCxbgX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38879 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323Ab0I0CHI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Sep 2010 22:07:08 -0400
Received: by wyb28 with SMTP id 28so3437447wyb.19
        for <linux-omap@vger.kernel.org>; Sun, 26 Sep 2010 19:07:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

Hi Kevin,

I am interested in runtime pm implementation on OMAP3, and
want to test this function on omap3-based beagle board, but seems
no devices on omap3 Soc can support runtime pm(no __pm_runtime_*
message found from 'dmesg' and rpm debug option is surely enabled)
now after trying the two omap trees below:

     git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git#pm-core
     git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git#pm

So, could you give me some guideline about how to bring up runtime pm
on beagle? such as,

               which git tree and branch should be used?
               which option should be enabled?
               or other things.

thanks,

-- 
Lei Ming
