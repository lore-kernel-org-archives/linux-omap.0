From: Guillaume Gardet <guillaume.gardet@free.fr>
Subject: Beagleboard xM - Bogomips are very low
Date: Tue, 19 Mar 2013 16:17:46 +0100
Message-ID: <5148819A.5040500@free.fr>
Reply-To: guillaume.gardet@free.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:51930 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755843Ab3CSPS2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Mar 2013 11:18:28 -0400
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 933132DB43
	for <linux-omap@vger.kernel.org>; Tue, 19 Mar 2013 16:18:25 +0100 (CET)
Received: from [192.168.0.13] (unknown [82.244.147.214])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 587EB8231B
	for <linux-omap@vger.kernel.org>; Tue, 19 Mar 2013 16:17:47 +0100 (CET)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

On a Beagleboard xM rev. B, I noticed that vanilla kernel 3.4.6 have the folowing bogomips for 300MHz and 800 MHz operations: 262.08 and 700.57.

With kernel 3.7.10, I have : 175.65 and 467.41 bogompis.

Any idea why bogomips are so low now?

Guillaume

