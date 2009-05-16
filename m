From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Tracking N770 breakage
Date: Sat, 16 May 2009 14:06:53 +0100
Message-ID: <20090516140653.10104565olvxrwjk@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:35865 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983AbZEPNGx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 09:06:53 -0400
Received: from lidskialf.net (beyond.lidskialf.net [172.16.1.1])
	by mail.lidskialf.net (Postfix) with ESMTP id A31CB48A708F9
	for <linux-omap@vger.kernel.org>; Sat, 16 May 2009 14:06:53 +0100 (BST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi, I've tracked where the N770 breaks on the linux-omap tree master branch:

This commit (REMOVE OMAP LEGACY CODE: Reset clocks and PM code to  
mainline) works fine:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=eba05254cb561dc27d5664503f91f7c21954e648


This next commit (Merge current mainline tree into linux-omap tree) does not:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=0595ee8a05836666b225e6bf003ede0da1e6e329

So "something" has been pulled back from mainline that breaks things.  
I've tried git bisecting between these two, but it seems to un-do all  
the local commits on the linux-omap tree when bisecting the merge from  
mainline, which isn't very useful.



