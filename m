From: Philip Balister <philip@balister.org>
Subject: Nagging free/reclaim gpio's
Date: Mon, 30 Aug 2010 14:25:39 -0400
Message-ID: <4C7BF7A3.3000900@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:31667 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751733Ab0H3ScY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Aug 2010 14:32:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I've got a module that claims gpio's when it is loaded and frees them 
when it is unloaded. It looks like something goes wrong when I free them:

gpio_unexport: gpio144 status -22
gpio_unexport: gpio146 status -22
gpio_unexport: gpio14 status -22
gpio_unexport: gpio21 status -22
gpio_unexport: gpio22 status -22
gpio_unexport: gpio23 status -22


Then when I try to reclaim them I get this:

gpio_request: gpio-175 (sysfs) status -16
export_store: status -16
gpio_request: gpio-175 (sysfs) status -16
export_store: status -16
gpio_request: gpio-114 (sysfs) status -16
export_store: status -16
gpio_request: gpio-114 (sysfs) status -16
export_store: status -16
gpio_request: gpio-173 (sysfs) status -16
export_store: status -16
gpio_request: gpio-173 (sysfs) status -16
export_store: status -16


This has to be silly, but I can't find the problem. Everything works 
fine, I just would like the messages to go away :)

Philip
