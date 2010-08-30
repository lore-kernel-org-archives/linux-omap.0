From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Nagging free/reclaim gpio's
Date: Mon, 30 Aug 2010 13:54:51 -0500
Message-ID: <d468ab8f1c720366e645de5e2150d53e@secure211.sgcpanel.com>
References: <4C7BF7A3.3000900@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39976 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733Ab0H3Syu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Aug 2010 14:54:50 -0400
In-Reply-To: <4C7BF7A3.3000900@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: linux-omap@vger.kernel.org

Hi,

On Mon, 30 Aug 2010 14:25:39 -0400, Philip Balister <philip@balister.org>
wrote:
> I've got a module that claims gpio's when it is loaded and frees them 
> when it is unloaded. It looks like something goes wrong when I free
them:
> 
> gpio_unexport: gpio144 status -22
> gpio_unexport: gpio146 status -22
> gpio_unexport: gpio14 status -22
> gpio_unexport: gpio21 status -22
> gpio_unexport: gpio22 status -22
> gpio_unexport: gpio23 status -22

this is telling you, you have entered invalid
arguments to gpio_unexport.

> Then when I try to reclaim them I get this:
> 
> gpio_request: gpio-175 (sysfs) status -16
> export_store: status -16
> gpio_request: gpio-175 (sysfs) status -16
> export_store: status -16
> gpio_request: gpio-114 (sysfs) status -16
> export_store: status -16
> gpio_request: gpio-114 (sysfs) status -16
> export_store: status -16
> gpio_request: gpio-173 (sysfs) status -16
> export_store: status -16
> gpio_request: gpio-173 (sysfs) status -16
> export_store: status -16
> 
> 
> This has to be silly, but I can't find the problem. Everything works 
> fine, I just would like the messages to go away :)

it's telling you that the gpio is busy, claimed by sysfs usage,
so you can't claim it again.

-- 
balbi
