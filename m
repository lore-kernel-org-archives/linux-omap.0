From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC][PATCH 0/3] OMAP3630: UART4 startup
Date: Thu, 25 Feb 2010 14:08:13 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002251406290.2701@utopia.booyaka.com>
References: <1267108876-18028-1-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49455 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932635Ab0BYVIO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 16:08:14 -0500
In-Reply-To: <1267108876-18028-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergio Aguirre <saaguirre@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Hi,

On Thu, 25 Feb 2010, Sergio Aguirre wrote:

> This small RFC patchlist is intending to add initial UART4 support
> for omap36xx chips.
> 
> VERY IMPORTANT:
>  - This is currently untested. I don't have the HW to test this.
>  - I don't consider myself an omap-serial expert, so please review
>    carefully.

Tony and I corresponded about this series; we decided that I'll handle 
this one because most of the changes are clock/PRCM related.  Will you get 
hardware to test this series soon?  None of us have OMAP3630 hardware, 
unfortunately.


- Paul
