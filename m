From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Nagging free/reclaim gpio's
Date: Tue, 31 Aug 2010 00:52:12 -0500
Message-ID: <4669227da337328b96db94126a99b550@secure211.sgcpanel.com>
References: <4C7BF7A3.3000900@balister.org> <d468ab8f1c720366e645de5e2150d53e@secure211.sgcpanel.com> <4C7C0B2B.6080407@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:33320 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755964Ab0HaFwN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 01:52:13 -0400
In-Reply-To: <4C7C0B2B.6080407@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: linux-omap@vger.kernel.org

Hi,

On Mon, 30 Aug 2010 15:48:59 -0400, Philip Balister <philip@balister.org>
wrote:
>> this is telling you, you have entered invalid
>> arguments to gpio_unexport.
> 
> I'm calling gpio_free, it must then be calling gpio_unexport for me ...

yes, but please always keep the list in Cc.

-- 
balbi
